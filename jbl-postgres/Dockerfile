FROM ubuntu

MAINTAINER Jean-Baptiste Lasselle <@j-b-l@jean.baptiste.lasselle@gmail.com>


# export POSTGRESQL_VERSION_ID=9.5.14
ARG VERSION_POSTGRESQL=9.5.14
# ENV VERSION_POSTGRESQL=9.5.14

ENV POSTGRES_USER=biloute
ARG POSTGRES_USER=$POSTGRES_USER

ARG POSTGRES_PASSSWORD=biloute
ENV POSTGRES_PASSSWORD=$POSTGRES_PASSSWORD

USER root 

#
# example Dockerfile from https://docs.docker.com/engine/examples/postgresql_service/#install-postgresql-on-docker
#
#
# example Dockerfile for https://docs.docker.com/engine/examples/postgresql_service/
#

# Linux told me those packages are required for postgres installation process, so...
# - waking uo apt-cache
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && apt-get install -y gnupg gnupg2 gnupg1
# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``$VERSION_POSTGRESQL``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -y
# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL $VERSION_POSTGRESQL
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python-software-properties software-properties-common postgresql-$VERSION_POSTGRESQL postgresql-client-$VERSION_POSTGRESQL postgresql-contrib-$VERSION_POSTGRESQL

# final clean-up
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update -y
# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-$VERSION_POSTGRESQL`` package when it was ``apt-get installed``
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
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$VERSION_POSTGRESQL/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/$VERSION_POSTGRESQL/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/$VERSION_POSTGRESQL/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

RUN echo " generating CMD script, so that I can interpolate PostGreSQL's version at build time. "
# Need root to do that
USER root
RUN echo "/usr/lib/postgresql/$VERSION_POSTGRESQL/bin/postgres -D /var/lib/postgresql/$VERSION_POSTGRESQL/main -c config_file=/etc/postgresql/$VERSION_POSTGRESQL/main/postgresql.conf" >> ./startup.sh
RUN mkdir /kytes/go/postgres/cmd
RUN cp ./startup.sh /kytes/go/postgres/cmd
RUN chown -R postgres:postgres /kytes
RUN chmod +x /kytes/go/postgres/cmd/startup.sh
USER postgres
# Set the default command to run when starting the container
CMD ["/kytes/go/postgres/cmd/startup.sh"]
