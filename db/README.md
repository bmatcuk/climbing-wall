# Setting up the API
The API relies on [postgrest] to serve straight out of a [postgresql] database.
Specifically, I'm using v7 because my db is stuck on v9.4 and v7 was the last
version to support it.

[postgrest] requires pgcrypto which is provided by the contrib package on my
distributions, and [pgjwt].

## Running postgrest on OSX
If you're using the postgresql app on osx, the libraries aren't part of the
search path. You need something like:

```bash
env DYLD_FALLBACK_LIBRARY_PATH=/Applications/Postgres.app/Contents/Versions/latest/lib ./postgrest postgrest.conf
```

## Importing Data
Use `COPY ... FROM` to import the csv files, and then update the table's id
sequence.

```sql
COPY climbingwall.TABLE FROM '/path/to/file' WITH (FORMAT csv, HEADER true);
SELECT setval('climbingwall.TABLE_id_seq',max(id)) from climbingwall.TABLE;
```

For the routes table, you must explicitly specify the columns:

```sql
COPY climbingwall.routes (id,subsection_id,difficulty,difficulty_mod,setter1_id,setter2_id,description,sort)
FROM '/path/to/file' WITH (FORMAT csv, HEADER true);
```

## Historical Backup
TCW closed and everyone was very sad. And now, some years later, I'm
decommissioning the server that ran this app. Before I did, I dumped all of the
non-user tables into `climbingwall_dump.sql` for archival purposes. This file
preserves the last climbs TCW had on their walls before closing their doors one
last time.

[pgjwt]: https://github.com/michelp/pgjwt
[postgresql]: https://www.postgresql.org/
[postgrest]: https://postgrest.org/
