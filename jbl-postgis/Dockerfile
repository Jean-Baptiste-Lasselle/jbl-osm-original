FROM postgres:10
# FROM postgres:9.5.14


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
# piqué à : https://github.com/appropriate/docker-postgis/blob/f6d28e4a1871b1f72e1c893ff103f10b6d7cb6e1/10-2.4/Dockerfile
ENV POSTGIS_MAJOR 2.4
ENV POSTGIS_VERSION 2.4.3+dfsg-2.pgdg90+1

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

# ARG PGUSER=$POSTGRES_USER
# ENV PGUSER=$POSTGRES_USER
# 
# ARG PGDATABASE
# ENV PGDATABASE=$POSTGRES_DB

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

# USER root

# WORKDIR /

RUN apt-get update -y 
RUN apt-get install -y apt-utils 
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y net-tools
RUN apt-get install -y git


ADD install-postgis.sh .
RUN chmod +x ./install-postgis.sh
RUN echo "exécution de l'=>>> [./install-postgis.sh] "
RUN ./install-postgis.sh

ADD install-postgis.sh .


# RUN apt-get install -y osm2pgsql
# RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p $DOWNLOADED_PBF_FILES_HOME
# ADD ./australia-oceania-latest.osm.pbf $DOWNLOADED_PBF_FILES_HOME
RUN echo " ----------------------------------------------------------- "
RUN echo " Vérification DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME "
RUN echo " ----------------------------------------------------------- "
RUN echo " Vérification de la présence des fichiers PBFs téléchargés : "
RUN echo " ----------------------------------------------------------- "
RUN ls -all $DOWNLOADED_PBF_FILES_HOME
RUN echo " ----------------------------------------------------------- "
# RUN echo " ----------------------------------------------------------- "

# 
# - > Un problème se pose : pour créer la bdd APP_DB_NAME et le user APP_USER_NAME, le serveur PostGreSQL doit être démarré !
#      - on pourrait essayer de démarrer le SGBDR PostGreSQL dans le processus de build docker, mais alors, il faudrai exécuter en paralèlle psql.
#      - on se retrouvera alors dans une situationd ns lquelle on cherchera à exécuter plusieurs processus paralèlles, dans un process de build d'image docker: es-ce souhaitable?
# Pour crééer  la bdd APP_DB_NAME et le user APP_USER_NAME, je peux typiquement faire un soudeur plongeur, mais
# j'ai trouvé dans la documentation officielle postgresql sur dockerhub, une info :
# see also https://hub.docker.com/_/postgres/
# Au paragraphaphe [How to extend this image]
# " 
# If you would like to do additional initialization in an image derived 
# from this one, add one or more *.sql, *.sql.gz, or *.sh scripts under
# /docker-entrypoint-initdb.d (creating the directory if necessary). After
# the entrypoint calls initdb to create the default postgres user and database, it
# will run any *.sql files, run any executable *.sh scripts, and source any non-executable *.sh scripts
# found in that directory to do further initialization before starting the service.
# "
# - > Je remarque enfin que c'est la technique que 'dooman84' a utilisé.
# 
RUN mkdir -p /docker-entrypoint-initdb.d
ADD create-app-db-with-postgis-extensions.sh /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint-initdb.d/create-app-db-with-postgis-extensions.sh

VOLUME $DOWNLOADED_PBF_FILES_HOME

# HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $APP_DB_USER_NAME -d $APP_DB_NAME -h localhost && psql -U $APP_DB_USER_NAME -d $APP_DB_NAME -h localhost -c "SELECT 1 as OSM_DB_HEALTHCHECK;"
# HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $POSTGRES_USER --dbname=$POSTGRES_DB || exit 1

# HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $POSTGRES_USER --dbname=$POSTGRES_DB || exit 1

# HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $APP_DB_USER --dbname=postgres || exit 1
