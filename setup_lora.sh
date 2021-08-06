#!/usr/bin/env bash
set -e

check_lora_variables() {
    if [ -n "$DB_NAME" ]; then
        true "${DB_USER:?DB_USER is unset. Error.}"
        true "${DB_PASSWORD:?DB_PASSWORD is unset. Error.}"
    fi
}

setup_lora_db() {
    # The three following `alter database … set` and `create schema …` commands
    # should be identical the ones in oio_rest/oio_rest/db/management.py used for
    # tests.

    echo "Ensure LoRa user exists"
    if ! check_user_exists ${DB_USER}; then
        echo "LoRa user does not exist, creating:"
        psql ${PSQL_ARGS} --dbname=postgres -c "CREATE USER ${DB_USER} WITH ENCRYPTED PASSWORD '${DB_PASSWORD}';"
    fi
    echo ""
    psql ${PSQL_ARGS} --dbname=postgres -c "GRANT ${DB_USER} TO postgres;"

    echo "Ensure LoRa database exists"
    if ! check_db_exists ${DB_NAME}; then
        echo "LoRa database does not exist, creating:"
        psql ${PSQL_ARGS} --dbname=postgres -c "CREATE DATABASE ${DB_NAME};"
    fi
    echo ""

    echo "Setting up LoRa database privileges and settings:"
    psql ${PSQL_ARGS} --dbname=postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};"
    psql ${PSQL_ARGS} --dbname=postgres -c "ALTER DATABASE ${DB_NAME} SET search_path TO actual_state, public;"
    psql ${PSQL_ARGS} --dbname=postgres -c "ALTER DATABASE ${DB_NAME} SET datestyle TO 'ISO, YMD';"
    psql ${PSQL_ARGS} --dbname=postgres -c "ALTER DATABASE ${DB_NAME} SET intervalstyle TO 'sql_standard';"
    echo ""

    echo "Creating LoRa schema:"
    psql ${PSQL_ARGS} --dbname=${DB_NAME} -c "CREATE SCHEMA IF NOT EXISTS actual_state AUTHORIZATION ${DB_USER};"
    echo ""

    # The three following `create extension … ` commands should be identical the
    # ones in oio_rest/oio_rest/db/management.py used for tests.
    echo "Ensuring LoRa extensions exist:"
    PG_EXTENSIONS="uuid-ossp btree_gist pg_trgm"
    for EXTENSION in ${PG_EXTENSIONS}; do
        echo "'${EXTENSION}':"
        psql ${PSQL_ARGS} --dbname=${DB_NAME} -c "CREATE EXTENSION IF NOT EXISTS \"${EXTENSION}\" WITH SCHEMA actual_state;"
    done
    echo ""
}

ensure_lora_db() {
    if [ -n "$DB_NAME" ]; then
        echo "Starting LoRa database configuration."
        setup_lora_db
    else
        echo "Skipping creation of LoRA database configuration."
    fi
    echo ""
}
