if [ -n "$DB_NAME" ]; then
    echo
    echo Warning: Upgrading $DB_USER to SUPERUSER.
    echo

    psql -v ON_ERROR_STOP=1 <<-EOSQL
        ALTER ROLE $DB_USER WITH SUPERUSER;
EOSQL
fi
