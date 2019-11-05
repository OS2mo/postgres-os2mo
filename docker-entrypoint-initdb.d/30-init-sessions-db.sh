#!/bin/bash
set -e

if [ -n "$SESSIONS_DB_NAME" ]; then

    true "${SESSIONS_DB_USER:?SESSIONS_DB_USER is unset. Error!}"
    true "${SESSIONS_DB_PASSWORD:?SESSIONS_DB_PASSWORD is unset. Error!}"

    echo Creating sessions db: $SESSIONS_DB_NAME

    psql -v ON_ERROR_STOP=1 <<-EOSQL
        create user $SESSIONS_DB_USER with encrypted password '$SESSIONS_DB_PASSWORD';
        create database $SESSIONS_DB_NAME owner $SESSIONS_DB_USER;
        grant all privileges on database $SESSIONS_DB_NAME to $SESSIONS_DB_USER;
EOSQL
else
    echo Skipping creation of sessions db
fi


# we can connect without password because ``trust`` authentication for Unix
# sockets is enabled inside the container.
