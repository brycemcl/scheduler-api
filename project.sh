#!/bin/sh
while ! $(psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}") ; do sleep 1; done;
#reset db
psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"  -c "DROP DATABASE ${POSTGRES_DB};"
psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"  -c "CREATE DATABASE ${POSTGRES_DB};"
#setup db
psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}" << EOF
\i ./src/db/schema/create.sql
\i ./src/db/schema/development.sql 
\dt
EOF
exec npm start