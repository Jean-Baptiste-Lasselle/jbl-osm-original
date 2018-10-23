#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"




# Create the 'template_postgis' template db
# Lorsque l'on définit la variable PGUSER, psql prend en compte celle-ci pour s'authentifier avec ce username  
# Lorsque l'on définit la variable PGPASSWORD, psql prend en compte celle-ci pour s'authentifier avec le username spécifié 
export PGHOST=localhost
export PGPASSWORD=$POSTGRES_PASSWORD
export PGUSER=$POSTGRES_USER

echo " ------------------------------------------------------------------------------------------- "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_DB=$POSTGRES_DB] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_USER=$POSTGRES_USER] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [POSTGRES_PASSWORD=$POSTGRES_PASSWORD] "
echo " VERIFICATION DEBUT INIT DB POSTGIS : [DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME] "
echo " ------------------------------------------------------------------------------------------- "

psql -U $POSTGRES_USER --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	psql -U $POSTGRES_USER --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION postgis_topology;
		CREATE EXTENSION fuzzystrmatch;
		CREATE EXTENSION postgis_tiger_geocoder;
		CREATE EXTENSION hstore;
EOSQL
done


export PGHOST=localhost
export PGPASSWORD=$POSTGRES_PASSWORD
export PGUSER=$POSTGRES_USER

# useradd -G sudo $POSTGRES_USER
# su $POSTGRES_USER


#import Melbourne city
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /Melbourne.osm.pbf

# -> YO Michael, 
# -> Let's start with just the same instruction, but with `--create` option instread of `--style` (have they even once imported data for their customer(s)...??)
osm2pgsql --create /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER -k --slim /australia-oceania-latest.osm.pbf 
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER -k --slim /australia-oceania-latest.osm.pbf 
# && touch /var/lib/postgresql/data/DB_INITED
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /australia-oceania/australia-latest.osm.pbf



# The following environment variables can be used to select default connection parameter values, which will be used by PQconnectdb, PQsetdbLogin and PQsetdb if no value is directly specified by the calling code. These are useful to avoid hard-coding database connection information into simple client applications, for example.

#     PGHOST behaves the same as the host connection parameter.
#     PGHOSTADDR behaves the same as the hostaddr connection parameter. This can be set instead of or in addition to PGHOST to avoid DNS lookup overhead.
#     PGPORT behaves the same as the port connection parameter.
#     PGDATABASE behaves the same as the dbname connection parameter.
#     PGUSER behaves the same as the user connection parameter.
#     PGPASSWORD behaves the same as the password connection parameter. Use of this environment variable is not recommended for security reasons, as some operating systems allow non-root users to see process environment variables via ps; instead consider using a password file (see Section 34.15).
#     PGPASSFILE behaves the same as the passfile connection parameter.
#     PGSERVICE behaves the same as the service connection parameter.
#     PGSERVICEFILE specifies the name of the per-user connection service file. If not set, it defaults to ~/.pg_service.conf (see Section 34.16).
#     PGOPTIONS behaves the same as the options connection parameter.
