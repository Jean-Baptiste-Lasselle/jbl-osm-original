FROM mdillon/postgis:9.5

ARG DOWNLOADED_PBF_FILES_HOME=/downloaded-pbf-files
# built-in default value et runtime, baby
ENV DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME

# POSTGRES_DB
ARG POSTGRES_DB=gis
# built-in default value et runtime, baby
ENV POSTGRES_DB=$POSTGRES_DB
# POSTGRES_USER
ARG POSTGRES_USER=poulet
# built-in default value et runtime, baby
ENV POSTGRES_USER=$POSTGRES_USER
# POSTGRES_PASSWORD (note: should not be built-in container, for the sake of security)
ARG POSTGRES_PASSWORD=poulet
# built-in default value et runtime, baby
ENV POSTGRES_PASSWORD=whereischarlie


WORKDIR /


RUN apt-get update && \
    apt-get install -y osm2pgsql git wget && \
    rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/dooman87/openstreetmap-carto.git
# RUN git clone https://github.com/dooman87/openstreetmap-carto.git && \
    # wget https://download.geofabrik.de/australia-oceania-latest.osm.pbf
    # wget https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
    # link [https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf] has restricted access
# wget https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf

RUN mkdir -p $DOWNLOADED_PBF_FILES_HOME
ADD ./australia-oceania-latest.osm.pbf $DOWNLOADED_PBF_FILES_HOME
RUN echo " ----------------------------------------------------------- "
RUN echo " Vérification DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME "
RUN echo " ----------------------------------------------------------- "
RUN echo " Vérification de la présence des fichiers PBFs téléchargés : "
RUN echo " ----------------------------------------------------------- "
RUN ls -all $DOWNLOADED_PBF_FILES_HOME
RUN echo " ----------------------------------------------------------- "
RUN echo " Finalement,on copie les fichiers PBF au même emplacement que celui déduit par le'excutable 'wget' :  "
RUN cp $DOWNLOADED_PBF_FILES_HOME/*.pbf .
RUN echo " ----------------------------------------------------------- "
RUN echo " Vérification de la présence des fichiers PBFs téléchargés : "
RUN echo " ----------------------------------------------------------- "
RUN echo "  REPERTOIRE=$(pwd)" && ls -all 
RUN echo " ----------------------------------------------------------- "

# Overriding init script to add hstore extension that osm2pgsql requires
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh

# Right, Michael?
HEALTHCHECK  --interval=5s --timeout=3s --retries=30 CMD pg_isready -U $POSTGRES_USER --dbname=$POSTGRES_DB || exit 1
