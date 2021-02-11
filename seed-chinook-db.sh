CHINOOK_POSTGRESQL_DB_NAME=postgres
CHINOOK_SQLITE_DATASOURCE=https://github.com/lerocha/chinook-database/raw/master/ChinookDatabase/DataSources/Chinook_Sqlite_AutoIncrementPKs.sqlite
POSTGRES_PASSWORD=postgrespassword

docker-compose exec postgres pgloader $CHINOOK_SQLITE_DATASOURCE pgsql://postgres:$POSTGRES_PASSWORD@127.0.0.1:5432/$CHINOOK_POSTGRESQL_DB_NAME