#!/bin/bash
# set -e
# 
# --
# - Abstract
# --
# This script is intended to allow user to easily :
# => be provided with a postgres with postgis extensions server up 'n running.
# => 
# => set the first POTSGRES super-admin user of that postgres / postgis instance : that kinds of user is by design, meant to be restricted to IT staff, like DBA managers
#    This image will use POSTGRES_USER, POSTGRES_PASSWORD,  to set username and password of that first super admin user.
# => create a database : This image assumes the user wants to create a PostGreSQL database that will be used by an application : 
#    This image will use APP_DB_NAME to create the database with that name
# => set one application user : this user will be created by
# 

# 
# - those should already exists, inherited FROM postgres:9.5.14
# ARG POSTGRES_USER
# ENV POSTGRES_USER
# ARG POSTGRES_PASSWORD
# ENV POSTGRES_PASSWORD
# 
# I'll have to check, but if ....

# ARG APP_DB_NAME=bddgeoloc
# ENV APP_DB_NAME=$APP_DB_NAME

# ARG APP_DB_USER_NAME=tolkien
# ENV APP_DB_USER_NAME=$APP_DB_USER_NAME

# ARG APP_DB_USER_PWD=tolkien
# ENV APP_DB_USER_PWD=$APP_DB_USER_PWD

# les autres paramètres de connexion psql/pg_isready seront spécifiés comme arguments d'invocation de psql
export PGUSER=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASSWORD
export PGDATABASE=$POSTGRES_DB
export PGHOST=localhost

echo " ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- "
echo " ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- "
echo "        JBL SCRIPT create-app-db-with-postgis-extensions.sh COMMENCE !!!       "
echo " ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- "
echo " ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- "

echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [POSTGRES_USER=$POSTGRES_USER]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [POSTGRES_DB=$POSTGRES_DB]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [POSTGRES_PASSWORD=$POSTGRES_PASSWORD]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [PGUSER=$PGUSER]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [PGPASSWORD=$PGPASSWORD]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [PGDATABASE=$PGDATABASE]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [PGHOST=$PGHOST]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [PGPORT=$PGPORT]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [APP_DB_NAME=$APP_DB_NAME]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [APP_DB_USER_NAME=$APP_DB_USER_NAME]"
echo " ------------------------------------------------- "
echo "   VERIFICATIONS : [APP_DB_USER_PWD=$APP_DB_USER_PWD]"
echo " ------------------------------------------------- "
  
# 
# -- 1 - Let's install postgis, plus postgres client :
# 
# => because you need psql postgres' client, to install postgis, which is nopt a linux package, but a postgres extension, which is a postgres-specific packaging
# => for test
# => and for db management purposes (developer users wil only have rights only their own databases)
# 
# see : https://postgis.net/install/
# see : http://postgis.net/docs/manual-2.5/

# - > Wait,i'll chek if  there's any difference between creating a postgis database?
# - > So, what happensis this : you don't globally install POostGIS extensions to a whole PostGres instance, no, you EXTEND a PostGreSQL Database, to get to be a PostGIS database ( a spatial/geometry oriented DB, in other words)
# - > And we need PostGresSQL client, to create a PostGreSQL, and perform its extension to PostGIS
echo "# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ "
# apt-get install -y postgres-client # -+|+- >>> already installed budy, we'e in a native postgres inherited docker container image
echo "Okay, now we run the postgres-specific commands, that trigger postgis extensions installations"
echo "Note : we'lldo that (creating the \"$APP_DB_NAME\" database),  with the first created, surper admin user : \"$POSTGRES_USER\""
echo "Nevertheless, still logged in PostGreSQL as [$POSTGRES_USER], we will the create the APP's database management user, namely [$APP_DB_USER], and  "
echo "the developer will use that user, to operate the $APP_DB_NAME database from his code "
echo " So, first let(s create the database as a regular PostGresQL database, then we'll extend it to be a plain PostGIS database "


# Ok, so basically,I have to create a database, or a user, indside the first dba's database... Ok. Let's do that : 
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $APP_DB_USER_NAME;
    ALTER USER $APP_DB_USER_NAME WITH ENCRYPTED PASSWORD '$APP_DB_USER_PWD';
    CREATE DATABASE $APP_DB_NAME;
    GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER_NAME;
EOSQL


# psql -U $POSTGRES_USER -h localhost -c "createdb $APP_DB_NAME"
psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis;"
psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_topology;"
# -- if you built with sfcgal support --
psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_sfcgal;"
# -- if you want to install tiger geocoder --
psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION fuzzystrmatch"
psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_tiger_geocoder;"
# -- if you installed with pcre
# -- you should have address standardizer extension as well
# j.b. lasselle => I personnally did notinstall pcre, as far as I know
# psql -d yourdatabase -c "CREATE EXTENSION address_standardizer;"

# - > And finally, let's create APP_DB_USER_NAME in postgres, with access rights and all priviliges on the APP_DB_NAME database
# psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "createuser $APP_DB_USER_NAME"
# psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "alter user $APP_DB_USER_NAME with encrypted password '$APP_DB_USER_PWD';"
# psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "Granting privileges on $APP_DB_NAME"

echo " ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- "
echo " ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- "
echo "        JBL SCRIPT create-app-db-with-postgis-extensions.sh TERMINE !!!        "
echo " ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- "
echo " ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- "
