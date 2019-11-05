#!/bin/bash
set -e

if [ -n "$CONF_DB_NAME" ]; then

    true "${CONF_DB_USER:?CONF_DB_USER is unset. Error!}"
    true "${CONF_DB_PASSWORD:?CONF_DB_PASSWORD is unset. Error!}"

    echo Creating config db: $CONF_DB_NAME

    psql -v ON_ERROR_STOP=1 <<-EOSQL
        create user $CONF_DB_USER with encrypted password '$CONF_DB_PASSWORD';
        create database $CONF_DB_NAME owner $CONF_DB_USER;
        grant all privileges on database $CONF_DB_NAME to $CONF_DB_USER;
EOSQL
    if [ -n "$CONF_DB_UPGRADE_TO_SUPERUSER" ]; then
        echo
        echo Warning: Upgrading $CONF_DB_USER to SUPERUSER.
        echo

        psql -v ON_ERROR_STOP=1 <<-EOSQL3
            ALTER ROLE $CONF_DB_USER WITH SUPERUSER;
EOSQL3
    else
        echo Skipping upgrading $CONF_DB_USER to SUPERUSER.
    fi
else
    echo Skipping creation of config db
fi


# we can connect without password because ``trust`` authentication for Unix
# sockets is enabled inside the container.
