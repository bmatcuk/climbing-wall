-- create a database, such as climbingwall, with:
-- CREATE DATABASE climbingwall;
--
-- Run this file on that database.
--
-- And, you'll want to update the password for the webauth role
-- ALTER USER webauth WITH PASSWORD 'whatever';

-- extensions
create extension if not exists pgcrypto;
create extension if not exists pgjwt version '0.1.1';
alter extension pgjwt update;

-- schema
create schema if not exists climbingwall_secret;
create schema if not exists climbingwall;

-- users table
create table if not exists climbingwall_secret.users (
  id serial not null unique,
  username varchar(255) primary key,
  pass char(60) not null,
  role name not null
);

-- constraint to ensure there's a username and password
create or replace function
climbingwall_secret.ensure_username() returns trigger as $$
begin
  if length(new.username) < 1 then
    raise check_violation using message = 'username is required';
  end if;
  return new;
end
$$ language plpgsql;

drop trigger if exists test_username_check on climbingwall_secret.users;
create constraint trigger test_username_check
  after insert or update on climbingwall_secret.users
  for each row
  execute procedure climbingwall_secret.ensure_username();

-- constraint to ensure database role exists
create or replace function
climbingwall_secret.check_role_exists() returns trigger as $$
begin
  if not exists (select 1 from pg_roles as r where r.rolname = new.role) then
    raise foreign_key_violation using message =
      'unknown database role: ' || new.role;
    return null;
  end if;
  return new;
end
$$ language plpgsql;

drop trigger if exists ensure_user_role_exists on climbingwall_secret.users;
create constraint trigger ensure_user_role_exists
  after insert or update on climbingwall_secret.users
  for each row
  execute procedure climbingwall_secret.check_role_exists();

-- trigger to encrypt passwords
create or replace function
climbingwall_secret.encrypt_pass() returns trigger as $$
begin
  if tg_op = 'INSERT' or new.pass <> old.pass then
    if length(new.pass) < 1 then
      raise check_violation using message = 'password is required';
    end if;
    if length(new.pass) > 72 then
      raise check_violation using message = 'maximum password length is 72 characters';
    end if;
    new.pass = crypt(new.pass, gen_salt('bf'));
  end if;
  return new;
end
$$ language plpgsql;

drop trigger if exists encrypt_pass on climbingwall_secret.users;
create trigger encrypt_pass
  before insert or update on climbingwall_secret.users
  for each row
  execute procedure climbingwall_secret.encrypt_pass();

-- utility function to get a database role for a given user
create type climbingwall_secret.user_info as (
  id integer,
  role name
);

-- function to login a user
create or replace function
climbingwall_secret.login(username text, pass text) returns climbingwall_secret.user_info
  language plpgsql
  as $$
begin
  return ROW(id,role)::climbingwall_secret.user_info
    from climbingwall_secret.users
    where users.username = login.username
      and users.pass = crypt(login.pass, users.pass);
end;
$$;

-- function to change a user's password
create or replace function
climbingwall_secret.change_password(id integer, oldpass text, newpass text) returns boolean as $$
declare
  cnt integer;
begin
  update climbingwall_secret.users
    set pass = change_password.newpass
    where users.id = change_password.id
      and users.pass = crypt(change_password.oldpass, users.pass);
  get diagnostics cnt = ROW_COUNT;
  return cnt > 0;
end;
$$ language plpgsql;


-- PUBLIC API


-- type of a jwt_token
create type climbingwall.jwt_token as (
  token text
);

-- login function
create or replace function
climbingwall.login(username text, pass text) returns climbingwall.jwt_token as $$
declare
  info climbingwall_secret.user_info;
  result climbingwall.jwt_token;
begin
  select (climbingwall_secret.login(login.username, login.pass)).* into info;
  if info is null then
    raise invalid_password using message = 'invalid user or password';
  end if;

  select sign(row_to_json(r), current_setting('app.settings.jwt_secret')) as token
    from (select (info).id as "uid", (info).role as role, login.username as username) r
    into result;
  return result;
end;
$$ language plpgsql security definer;

-- create a new user
create or replace function
climbingwall.create_user(username text, pass text) returns climbingwall.jwt_token as $$
begin
  insert into climbingwall_secret.users (username, pass, role)
    values (create_user.username, create_user.pass, 'webuser');
  return (
    select climbingwall.login(create_user.username, create_user.pass)
  );
end;
$$ language plpgsql security definer;

-- update user password
create or replace function
climbingwall.change_password(oldpass text, newpass text) returns boolean as $$
begin
  return climbingwall_secret.change_password(current_setting('request.jwt.claim.uid')::integer, oldpass, newpass);
end;
$$ language plpgsql security definer;

-- rooms
create table if not exists climbingwall.rooms (
  id serial primary key,
  name varchar(255) not null unique,
  sort smallint not null
);
create index rooms_sort_key on climbingwall.rooms(sort asc);

-- sections
create table if not exists climbingwall.sections (
  id serial primary key,
  room_id integer not null references climbingwall.rooms,
  name varchar(255) not null,
  sort smallint not null
);
create index sections_room_id_sort_key on climbingwall.sections(room_id asc, sort asc);

-- subsections
create table if not exists climbingwall.subsections (
  id serial primary key,
  section_id integer not null references climbingwall.sections,
  name varchar(255) not null,
  sort smallint not null
);
create index sections_section_id_sort_key on climbingwall.subsections(section_id asc, sort asc);

-- setters
create table if not exists climbingwall.setters (
  id serial primary key,
  abbr varchar(10) not null unique,
  name varchar(255) not null
);

-- routes
create table if not exists climbingwall.routes (
  id serial primary key,
  subsection_id integer not null references climbingwall.subsections,
  difficulty smallint,
  difficulty_mod smallint not null default 0,
  color1 varchar(20),
  color2 varchar(20),
  symbol varchar(20),
  setter1_id integer not null references climbingwall.setters,
  setter2_id integer references climbingwall.setters,
  description varchar(255),
  active boolean not null default true,
  set_on date,
  updated_on date,
  sort smallint not null
);
create index routes_active_subsection_id_sort_key on climbingwall.routes(active asc, subsection_id asc, sort asc);

-- function to update route sort order
create or replace function
climbingwall.reorder_routes(id_sort_map json) returns setof climbingwall.routes as $$
begin
  return query update climbingwall.routes set sort = updates.sort
    from json_to_recordset(id_sort_map) as updates(id integer, sort smallint)
    where routes.id = updates.id
    returning routes.*;
end;
$$ language plpgsql;


-- HYBRID STUFF: both in the secret schema and public


-- completed routes
create table if not exists climbingwall_secret.completed_routes (
  user_id integer not null references climbingwall_secret.users(id),
  route_id integer not null references climbingwall.routes,
  rating smallint not null default 0,
  unique (user_id,route_id)
);

create view climbingwall.completed_routes
with (security_barrier)
as
  select *
  from climbingwall_secret.completed_routes
  where user_id = current_setting('request.jwt.claim.uid')::integer
with check option;


-- ROLES


-- generic role for postgrest
create role webauth noinherit login password '12345';

-- anon role can only login and create users
create role webanon nologin;
grant webanon to webauth;
grant usage on schema climbingwall to webanon;
grant execute on function climbingwall.login(text,text) to webanon;
grant execute on function climbingwall.create_user(text,text) to webanon;

-- user can see stuff
create role webuser nologin;
grant webuser to webauth;
grant usage on schema climbingwall to webuser;
grant select on all tables in schema climbingwall to webuser;
grant insert, update, delete on climbingwall.completed_routes to webuser;

-- admin can edit stuff
create role webadmin nologin;
grant webuser to webadmin;
grant webadmin to webauth;
grant insert, update on climbingwall.routes to webadmin;
grant all on climbingwall.routes_id_seq to webadmin;
