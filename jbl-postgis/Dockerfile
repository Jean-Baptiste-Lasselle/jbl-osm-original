FROM postgres:9.5.14

MAINTAINER Jean-Baptiste Lasselle <jean.baptiste.lasselle@gmail.com>

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

# - > wait,i'll chek if  there's any difference between creating a postgis database?

# - those should already exists, inherited FROM postgres:9.5.14
# ARG POSTGRES_USER
# ENV POSTGRES_USER
# ARG POSTGRES_PASSWORD
# ENV POSTGRES_PASSWORD

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
RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
RUN echo " ------------------------------------------------- "
RUN echo "   VERIFICATIONS : [CCCC=$CCCC]"
RUN echo " ------------------------------------------------- "



RUN apt-get update -y && apt-get install -y apt-utils curl net-tools top iperf3 
# 
# -- 1 - Let's install postgis, plus postgres client :
# 
# => because you need psql postgres' client, to install postgis, which is nopt a linux package, but a postgres extension, which is a postgres-specific packaging
# => for test
# => and for db management purposes (developer users wil only have rights only their own databases)
# 
# see : https://postgis.net/install/
# see : http://postgis.net/docs/manual-2.5/
RUN echo "# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ "
RUN apt-get install -y postgres-client
RUN echo "Okay, now we run the postgres-specific commands, that trigger postgis extensions installations"
RUN psql -d yourdatabase -c "CREATE EXTENSION postgis;"
RUN psql -d yourdatabase -c "CREATE EXTENSION postgis_topology;"
# -- if you built with sfcgal support --
RUN psql -d yourdatabase -c "CREATE EXTENSION postgis_sfcgal;"
# -- if you want to install tiger geocoder --
RUN psql -d yourdatabase -c "CREATE EXTENSION fuzzystrmatch"
RUN psql -d yourdatabase -c "CREATE EXTENSION postgis_tiger_geocoder;"
# -- if you installed with pcre
# -- you should have address standardizer extension as well
# j.b. lasselle => I personnally did notinstall pcre, as far as I know
# psql -d yourdatabase -c "CREATE EXTENSION address_standardizer;"
