#!/bin/bash
# Allow passwords to be updated from environment variables.
source docker-entrypoint.sh
docker_temp_server_start "$@"

update_password() {
    if [ -n "$1" ]; then
        psql <<-EOSQL1
            ALTER USER $2 WITH ENCRYPTED PASSWORD '$3';
EOSQL1
    fi
}

update_password "$DB_NAME" "$DB_USER" "$DB_PASSWORD"
update_password "$CONF_DB_NAME" "$CONF_DB_USER" "$CONF_DB_PASSWORD"
update_password "$SESSIONS_DB_NAME" "$SESSIONS_DB_USER" "$SESSIONS_DB_PASSWORD"

docker_temp_server_stop