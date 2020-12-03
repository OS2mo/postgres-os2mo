#!/usr/bin/env bash
set -e

# The official postgres image silently disable auth if there is no
# POSTGRES_PASSWORD set. We don't need the `postgres` user, so we generate a
# random password. This is a workaround for
# https://github.com/docker-library/postgres/issues/580 and can be removed if it
# is fixed upstream.
#
# The workaround is to install pwgen and wrap docker-entrypoint.sh.


# If CMD is postgres
if [ "$1" = 'postgres' ]; then
    # and the db has not been initialized
    if [ ! -s "$PGDATA/PG_VERSION" ]; then
        # And the POSTGRES_PASSWORD is not set
        if [ -z "$POSTGRES_PASSWORD" ]; then
            # Generate a random one
            export POSTGRES_PASSWORD="$(pwgen -1 32)"
            # and write it to the user once
            echo
            echo "Generated superuser password: $POSTGRES_PASSWORD"
            echo
        fi
    fi
fi

# if the database is already created, update the passwords according to environment variables
# only run if database is initialized
source docker-entrypoint.sh
docker_setup_env
if [ -n "$DATABASE_ALREADY_EXISTS" ]; then
    gosu postgres /update_passwords.sh
fi
exec docker-entrypoint.sh "$@"
