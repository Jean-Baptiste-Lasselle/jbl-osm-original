FROM ubuntu

MAINTAINER Jean-Baptiste Lasselle <@j-b-l@jean.baptiste.lasselle@gmail.com>

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

# export POSTGRESQL_VERSION_ID=9.5.14
ARG VERSION_POSTGRESQL=9.5.14
ARG VERSION_PACKAGE_UBUNTU_POSTGRESQL=9.5
ARG VERSION_PACKAGE_DEBIAN_POSTGRESQL=9.5
ARG VERSION_PACKAGE_CENTOS_POSTGRESQL=9.5
ARG VERSION_PACKAGE_ALPINE_POSTGRESQL=9.5

# ENV VERSION_POSTGRESQL=9.5.14

# - Le répertoire dans le conteneru à l'intérieur duquel on trouvera le fichier planet-latest.osm.pbf, par exemple  
ARG DOWNLOADED_PBF_FILES_HOME
# built-in default value et runtime, baby
ENV DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME
# ARG POSTGRES_DB
# built-in default value et runtime, baby
# ENV POSTGRES_DB=$POSTGRES_DB
# POSTGRES_USER
ARG POSTGRES_USER
# built-in default value et runtime, baby
ENV POSTGRES_USER=$POSTGRES_USER
# POSTGRES_PASSWORD (note: should not be built-in container, for the sake of security)
ARG POSTGRES_PASSWORD
# built-in default value et runtime, baby
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
# I'll have to check, but if ....


ARG APP_DB_NAME=bddgeoloc
ENV APP_DB_NAME=$APP_DB_NAME

ARG APP_DB_USER_NAME=tolkien
ENV APP_DB_USER_NAME=$APP_DB_USER_NAME

ARG APP_DB_USER_PWD=tolkien
ENV APP_DB_USER_PWD=$APP_DB_USER_PWD




USER root 




#
# example Dockerfile from https://docs.docker.com/engine/examples/postgresql_service/#install-postgresql-on-docker
#
#
# example Dockerfile for https://docs.docker.com/engine/examples/postgresql_service/
#

# Linux told me those packages are required for postgres installation process, so...
# - waking uo apt-cache
# RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && apt-get install -y gnupg gnupg2 gnupg1
# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``VERSION_PACKAGE_UBUNTU_POSTGRESQL``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list


# - 
# This one BEFORE the RUN dockerfile commands that install postgres from linux packages
# This one will trigger a Docker error, prompting "linux spec user: unable to find user biloute: no matching entries in passwd file" 
# - 
# RUN echo "This one BEFORE the RUN dockerfile commands that install postgres from linux packages"
# RUN echo "  This one will trigger a Docker error, prompting you \"linux spec user: unable to find user biloute: no matching entries in passwd file\" "
# USER postgres

RUN apt-get update -y
# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL $VERSION_PACKAGE_UBUNTU_POSTGRESQL
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
# "python-software-properties package will only be available for the versions below 12.04"
# RUN apt-get update -y && apt-get install -y python-software-properties software-properties-common postgresql-$VERSION_PACKAGE_UBUNTU_POSTGRESQL postgresql-client-$VERSION_PACKAGE_UBUNTU_POSTGRESQL postgresql-contrib-$VERSION_PACKAGE_UBUNTU_POSTGRESQL
RUN apt-get install -y software-properties-common postgresql-$VERSION_PACKAGE_UBUNTU_POSTGRESQL postgresql-client-$VERSION_PACKAGE_UBUNTU_POSTGRESQL postgresql-contrib-$VERSION_PACKAGE_UBUNTU_POSTGRESQL
# final clean-up? 
# RUN rm -rf /var/lib/apt/lists/*
# RUN apt-get update -y
# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-$VERSION_PACKAGE_UBUNTU_POSTGRESQL`` package when it was ``apt-get installed``
# USER postgres
# When, where is 'postgres' user created ?
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSSWORD';" &&\
    createdb -O $POSTGRES_USER $POSTGRES_USER

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

RUN echo " generating CMD script, so that I can interpolate PostGreSQL's version at build time. "
# Need root to do that
USER root
RUN echo "/usr/lib/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/bin/postgres -D /var/lib/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/main -c config_file=/etc/postgresql/$VERSION_PACKAGE_UBUNTU_POSTGRESQL/main/postgresql.conf" >> ./startup.sh
RUN mkdir -p /kytes/go/postgres/cmd
RUN cp ./startup.sh /kytes/go/postgres/cmd
RUN chown -R postgres:postgres /kytes
RUN chmod +x /kytes/go/postgres/cmd/startup.sh

USER postgres
# Set the default command to run when starting the container
CMD ["/kytes/go/postgres/cmd/startup.sh"]
