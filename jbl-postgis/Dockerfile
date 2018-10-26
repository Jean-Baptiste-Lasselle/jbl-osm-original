FROM postgres:9.5.14

MAINTAINER Jean-Baptiste Lasselle <@j-b.l@jean.baptiste.lasselle@gmail.com>

# --
# - Abstract
# --
# This image is intended to allow user to easily :
# => be provided with a postgres with postgis extensions server up 'n running.
# => 
# => set the first POTSGRES super-admin user of that postgres / postgis instacne : that kinds of user is by design, meant to be restricted to IT staff, like DBA managers
#    This image will use POSTGRES_USER, POSTGRES_PASSWORD,  to set username and password of that first super admin user.
# => create a database : This image assumes the user wants to create a PostGreSQL database that will be used by an application : 
#    This image will use APP_DB_NAME to create the database with that name
# => set one application user : this user will be created by


# - those should already exists, inherited FROM postgres:9.5.14
# ARG POSTGRES_USER
# ENV POSTGRES_USER
# ARG POSTGRES_PASSWORD
# ENV POSTGRES_PASSWORD

# I'll have to check, but if ....

ARG APP_DB_NAME=bddgeoloc
ENV APP_DB_NAME=$APP_DB_NAME

ARG APP_DB_USER_NAME=tolkien
ENV APP_DB_USER_NAME=$APP_DB_USER_NAME

ARG APP_DB_USER_PWD=tolkien
ENV APP_DB_USER_PWD=$APP_DB_USER_PWD


RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [POSTGRES_USER=$POSTGRES_USER]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [POSTGRES_PASSWORD=$POSTGRES_PASSWORD]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [PGUSER=$PGUSER]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [PGPASSWORD=$PGPASSWORD]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [PGDATABASE=$PGDATABASE]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [PGHOST=$PGHOST]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [PGPORT=$PGPORT]"
RUN echo " ------------------------------------------------- "
# RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
# RUN echo " ------------------------------------------------- "
# RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
# RUN echo " ------------------------------------------------- "



RUN apt-get update -y 
RUN apt-get install -y apt-utils 
RUN apt-get install -y curl
RUN apt-get install -y net-tools
RUN apt-get install -y iperf

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
RUN echo "# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ "
RUN apt-get install -y postgres-client
RUN echo "Okay, now we run the postgres-specific commands, that trigger postgis extensions installations"
RUN echo "Note : we'lldo that (creating the \"$APP_DB_NAME\" database),  with the first created, surper admin user : \"$POSTRES_USER\""
RUN echo "Nevertheless, still logged in PostGreSQL as [$POSTGRES_USER], we will the create the APP's database management user, namely [$APP_DB_USER], and  "
RUN echo "the developer will use that user, to operate the $APP_DB_NAME database from his code "
# ARG PGUSER=$POSTGRES_USER
# ENV PGUSER=$POSTGRES_USER  < = I don't like, having those ENV and ARG directives around here in my Dockerfile... U? @j-b.l
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis;"
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_topology;"
# -- if you built with sfcgal support --
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_sfcgal;"
# -- if you want to install tiger geocoder --
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION fuzzystrmatch"
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "CREATE EXTENSION postgis_tiger_geocoder;"
# -- if you installed with pcre
# -- you should have address standardizer extension as well
# j.b. lasselle => I personnally did notinstall pcre, as far as I know
# psql -d yourdatabase -c "CREATE EXTENSION address_standardizer;"

# - > And finally, let's create APP_DB_USER_NAME in postgres, with access rights and all priviliges on the APP_DB_NAME database
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "createuser $APP_DB_USER_NAME"
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "alter user $APP_DB_USER_NAME with encrypted password '$APP_DB_USER_NAME';"
RUN export PGPASSWORD=$POSTGRES_PASSWORD && psql -U $POSTGRES_USER -d $APP_DB_NAME -h localhost -c "Granting privileges on $APP_DB_NAME"

HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $POSTGRES_USER --dbname=$POSTGRES_DB || exit 1

