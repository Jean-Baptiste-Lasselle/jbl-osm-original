FROM dpokidov/gopnik

RUN apt-get update && \
    apt-get install -y git curl unzip node-carto mapnik-utils fontconfig && \
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
WORKDIR /openstreetmap-carto
# pour appliquer ma propre configuration PostGIS à Mapnik:  essentiellement pour l'hôte réseau
# https://github.com/mapnik/mapnik/blob/master/INSTALL.md
# https://help.openstreetmap.org/questions/51521/mapnik-and-postgresql-in-differents-servers
RUN rm -f ./project.yaml
ADD ./my-mapnik-settings/project.yaml .
RUN echo "TODO : build de l'image du service 'renderer' => faire des substitution sed au lieu d'écraser le fichier ? Il faut une sync avec la distribution chain de openstreetmap, et  tout récuperer dans l'infra en privé, ne serait que pour les téléchargements des dépendances"
RUN chmod +x ./get-shapefiles.sh
# dixit [https://github.com/dooman87/openstreetmap-carto/blob/master/INSTALL.md], which was coming from [https://github.com/mapnik/mapnik/blob/master/INSTALL.md]
RUN ./get-shapefiles.sh
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
