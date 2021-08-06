# Postgres OS2mo
A docker image containing Postgres initializer code for LoRa and OS2mo needs.

## Variants
There are two variants of this image.

### `postgres-os2mo:<revision>-<pg_version>`
Suitable for production.

### `postgres-os2mo:<revision>-<pg_version>-test`
Suitable integration tests where:
* the LoRa OIO data user is upgrades to SUPERUSER and
* pgTAP is installed.


## Environment variables
For the database containing LoRa OIO data.
```
DB_NAME
DB_USER
DB_PASSWORD
```
