#!/usr/bin/env bash


# Perform all actions as $POSTGRES_USER
export PGUSER=$MAPNIK_POSTGRES_USER
export PGPASSWORD=$MAPNIK_POSTGRES_PASSWORD
echo " ------------------------------------------------------------------------------------------- "
echo " VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_USER=$MAPNIK_POSTGRES_USER] "
echo " VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_PASSWORD=$MAPNIK_POSTGRES_PASSWORD] "
echo " VERIFICATION RENDERER ENNTRYPOINT : [PGUSER=$PGUSER] "
echo " VERIFICATION RENDERER ENNTRYPOINT  : [PGPASSWORD=$PGPASSWORD] "
echo " ------------------------------------------------------------------------------------------- "


# Create the 'template_postgis' template db
# Lorsque l'on définit la variable PGUSER, psql prend en compte celle-ci pour s'authentifier avec ce username  
# Lorsque l'on définit la variable PGPASSWORD, psql prend en compte celle-ci pour s'authentifier avec le username spécifié  
export PGPASSWORD=$POSTGRES_PASSWORD
export PGUSER=$POSTGRES_USER
sh /scripts/compile_style.sh

# apt-get update -y && apt-get install -y postgresql-client
# Hey! let's use ;;; the PostGreSQL client, to try and connect to PostGRESQL??
# psql -d gis -U renderer-user -h postgis -p 5432
psql -d gis -U $MAPNIK_POSTGRES_USER -h $MAPNIK_POSTGRES_DB_HOST -p 5432 -c "SELECT 1;"
# Reminds me of JDBC old days ... 


while [ ! -e /var/lib/postgresql/data/DB_INITED ]
do
sleep 5
echo "Waiting while database is initializing..."
done

#Have to wait because once DB created then osm2pgsql restarting postgres.
#TODO: Using pg_isready
echo "DB successfully created, waiting for restart"
sleep 60

echo "Starting renderer"
sh /scripts/run_render.sh
