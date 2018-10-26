FROM dpokidov/gopnik

ARG MAPNIK_POSTGRES_DB_HOST=postgis
ENV MAPNIK_POSTGRES_DB_HOST=$MAPNIK_POSTGRES_DB_HOST

ARG MAPNIK_POSTGRES_DB_PORT_NO=5432
ENV MAPNIK_POSTGRES_DB_PORT_NO=$MAPNIK_POSTGRES_DB_PORT_NO

ARG MAPNIK_POSTGRES_DB=gis
ENV MAPNIK_POSTGRES_DB=$MAPNIK_POSTGRES_DB
# Is there no dad at shinesolutions.com?
ARG MAPNIK_POSTGRES_USER=renderer-user
ENV MAPNIK_POSTGRES_USER=$MAPNIK_POSTGRES_USER

ARG MAPNIK_POSTGRES_PASSWORD=whereischarlie
ENV MAPNIK_POSTGRES_PASSWORD=$MAPNIK_POSTGRES_PASSWORD

# Hey! let's use ;;; the PostGreSQL client, to try and connect to PostGRESQL??
RUN apt-get update -y && \
    apt-get install -y git curl unzip node-carto mapnik-utils fontconfig postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN wget https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.tar.gz && \
    tar -xzvf 1.075R-it.tar.gz && \
    mkdir /usr/share/fonts/truetype/sourcepro-ttf/ && \
    cp source-sans-pro-2.020R-ro-1.075R-it/TTF/*.ttf /usr/share/fonts/truetype/sourcepro-ttf/ && \
    fc-cache && \
    rm 1.075R-it.tar.gz && \
    rm -rf source-sans-pro-2.020R-ro-1.075R-it

RUN git clone https://github.com/dooman87/openstreetmap-carto.git
# RUN git clone https://github.com/gravitystorm/openstreetmap-carto
WORKDIR /openstreetmap-carto
# pour appliquer ma propre configuration PostGIS à Mapnik:  essentiellement pour l'hôte réseau
# https://github.com/mapnik/mapnik/blob/master/INSTALL.md
# https://help.openstreetmap.org/questions/51521/mapnik-and-postgresql-in-differents-servers
# RUN rm -f ./project.yaml
# RUN rm -f ./project.mml
# ADD ./my-mapnik-settings/project.yaml .
# ADD ./my-mapnik-settings/project.mml .
# https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/issues/6

# dixit [https://github.com/dooman87/openstreetmap-carto/blob/master/INSTALL.md], which was coming
# from [https://github.com/mapnik/mapnik/blob/master/INSTALL.md]


# je n'exécute pas "./get-shapefiles.sh" , le fichier './download.sh' à la racine du repo fait déjà le boulot, et mieux.
# les fichiers sont déjà présents dans '/map_data/shapes', à causeed des mapped volumes définis dans le './docker-compose.yml'
# RUN chmod +x ./get-shapefiles.sh
# RUN ./get-shapefiles.sh

ADD shapes/ data/
RUN shapeindex --shape_files \
    data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp \
    data/water-polygons-split-3857/water_polygons.shp \
    data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
    data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
    data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp

RUN mkdir /map_data
VOLUME /map_data

RUN mkdir /scripts
COPY scripts/compile_style.sh /scripts
COPY scripts/run_render.sh /scripts
COPY entrypoint.sh /

RUN chmod 755 /scripts/*.sh && \
    chmod 755 /entrypoint.sh

# jib's ;) => poulet
EXPOSE 8080/tcp
EXPOSE 9090/tcp


WORKDIR /
ENTRYPOINT /entrypoint.sh
