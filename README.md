# climbing-wall
A route-tracking app for The Climbing Wall

## Running
You'll need a postgres database v9.4+ and you'll need to get postgrest running.
See the `api` directory for instructions. Update the `.env` file (or create a
`.env.local` file) with the IP:port of postgrest.

```bash
yarn run start
```

## Building
Create a `.env.production.local` file with the path to the postgrest api on the
production server, then run:

```bash
rm -drf dist && yarn run build
```
