# Postgres OS2mo init containers

This repository contains Postgres init containers, currently two init containers:

* MOX
* Keycloak

For both of them environmental variables to connect to Postgres are available:

* `POSTGRES_HOST`: Hostname of the PostgreSQL database.
* `POSTGRES_PORT`: Port of the PostgreSQL database.
* `POSTGRES_USER`: Username for a superuser on the database.
* `POSTGRES_USER_SUFFIX`: Optional username suffix, usually takes the form of `@host`.
* `POSTGRES_PASSWORD`: Password for the superuser on the database.
* `POSTGRES_SSL`: Whether to use SSL when connecting to the database.

Each of them have their own unique variables too:

* MOX:

** `DB_NAME`: The name to create the mox database under
** `DB_USER`: The name to assign the mox database user
** `DB_PASSWORD`: The password to assign the mox database user

* Keycloak:

** `KEYCLOAK_DB_NAME`: The name to create the keycloak database under
** `KEYCLOAK_DB_USER`: The name to assign the keycloak database user
** `KEYCLOAK_DB_PASSWORD`: The password to assign the keycloak database user

## Variants
There are two variants of this image.

### `postgres-os2mo:<revision>-<pg_version>`
Suitable for production.

### `postgres-os2mo:<revision>-<pg_version>-test`
Suitable integration tests where:
* the generated user is upgraded to SUPERUSER and
* pgTAP is installed.
