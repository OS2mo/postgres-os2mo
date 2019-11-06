# Postgres OS2mo
A docker image containing postgres and the extensions LoRa and OS2mo needs.

It inherits from [the official postgres
image](https://hub.docker.com/_/postgres) and does two additional things:
* Generate a random password for the default SUPERUSER and,
* creates three databases objects if the envionment variabel `*_NAME` for each
of them are set.


## Variants
There are two variants of this image.
### `postgres-os2mo:<pg_version>-<revision>`
Suitable for production.

### `postgres-os2mo:<pg_version>-<revision>-test`
Suitable integration tests where:
* the LoRa OIO data and OS2mo configuration users are upgrades to SUPERUSER and
* pgTAP is installed.


## Environment variables
For the database containing LoRa OIO data.
```
DB_NAME
DB_USER
DB_PASSWORD
```

For the database containing OS2mo configuration:
```
CONF_DB_NAME
CONF_DB_USER
CONF_DB_PASSWORD
```

For the database containing LoRa and OS2mo user sessions:
```
SESSIONS_DB_NAME
SESSIONS_DB_USER
SESSIONS_DB_PASSWORD
```
