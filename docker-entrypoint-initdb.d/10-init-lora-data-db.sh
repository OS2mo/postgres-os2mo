#!/bin/bash
set -e

if [ -n "$DB_NAME" ]; then

    true "${DB_USER:?DB_USER is unset. Error.}"
    true "${DB_PASSWORD:?DB_PASSWORD is unset. Error.}"

    # The three following `alter database … set` and `create schema …` commands
    # should be identical the ones in oio_rest/oio_rest/db/management.py used for
    # tests.

    echo Creating LoRA data db: $DB_NAME

    psql -v ON_ERROR_STOP=1 <<-EOSQL1
        create user $DB_USER with encrypted password '$DB_PASSWORD';
        create database $DB_NAME;
        grant all privileges on database $DB_NAME to $DB_USER;
        alter database $DB_NAME set search_path to actual_state, public;
        alter database $DB_NAME set datestyle to 'ISO, YMD';
        alter database $DB_NAME set intervalstyle to 'sql_standard';

        -- Searching with multiple parameters is faster when these are off.
        -- See #21273 and #23145. It is purely an optimization.
        alter database $DB_NAME set enable_hashagg to off;
        alter database $DB_NAME set enable_sort to off;

        \connect $DB_NAME
        create schema actual_state authorization $DB_USER;
EOSQL1


    echo Adding extensions

    # The three following `create extension … ` commands should be identical the
    # ones in oio_rest/oio_rest/db/management.py used for tests.

    psql -v ON_ERROR_STOP=1 -d $DB_NAME <<-EOSQL2
        create extension if not exists "uuid-ossp" with schema actual_state;
        create extension if not exists "btree_gist" with schema actual_state;
        create extension if not exists "pg_trgm" with schema actual_state;
EOSQL2

else
    echo Skipping creation of LoRA data db
fi


# we can connect without password because ``trust`` authentication for Unix
# sockets is enabled inside the container.
