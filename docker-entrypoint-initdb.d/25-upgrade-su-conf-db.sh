if [ -n "$CONF_DB_NAME" ]; then
    echo
    echo Warning: Upgrading $CONF_DB_USER to SUPERUSER.
    echo

    psql -v ON_ERROR_STOP=1 <<-EOSQL
        ALTER ROLE $CONF_DB_USER WITH SUPERUSER;
EOSQL
fi
