#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

echo " ------------------------------------------------------------------------------------------- "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_DB=$POSTGRES_DB] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_USER=$POSTGRES_USER] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_PASSWORD=$POSTGRES_PASSWORD] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME] "
echo " ------------------------------------------------------------------------------------------- "


# Create the 'template_postgis' template db
# Lorsque l'on définit la variable PGUSER, psql prend en compte celle-ci pour s'authentifier avec ce username  
# Lorsque l'on définit la variable PGPASSWORD, psql prend en compte celle-ci pour s'authentifier avec le username spécifié  
export PGPASSWORD=$POSTGRES_PASSWORD
export PGUSER=$POSTGRES_USER
psql --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	psql --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION postgis_topology;
		CREATE EXTENSION fuzzystrmatch;
		CREATE EXTENSION postgis_tiger_geocoder;
		CREATE EXTENSION hstore;
EOSQL
done

#import Melbourne city
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /Melbourne.osm.pbf
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /australia-oceania-latest.osm.pbf
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /australia-oceania/australia-latest.osm.pbf

touch /var/lib/postgresql/data/DB_INITED
