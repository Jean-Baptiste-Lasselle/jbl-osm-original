FROM mdillon/postgis:9.5

WORKDIR /

RUN apt-get update && \
    apt-get install -y osm2pgsql git wget && \
    rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/dooman87/openstreetmap-carto.git && \
    wget https://download.geofabrik.de/australia-oceania-latest.osm.pbf
    # wget https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
    # link [https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf] has restricted access
# wget https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf

#Overriding init script to add hstore extension that osm2pgsql requires
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh

# ouais poulet, et puis sait-on jamais, si l'Australie est grande : 
ADD configuration-optimale-pour-osm2pgsql-batch.sh .
RUN chmod +x ./configuration-optimale-pour-osm2pgsql-batch.sh
# Attention mon poulet, dans le Dockerfile, il faut être rcine des Ents, pour faire ce genre de trucs, okay?
# USER root
# (mais par chance pour toi, poulet, chez postgis ils ont fixe le user à root dans l'image que tu as ré-utilisée)
RUN ./configuration-optimale-pour-osm2pgsql-batch.sh
# tee /etc/sysctl.d/60-overcommit.conf <<EOF
# echo "# Overcommit settings to allow faster osm2pgsql imports"
# vm.overcommit_memory=1
# EOF
# sudo sysctl -p /etc/sysctl.d/60-overcommit.conf
