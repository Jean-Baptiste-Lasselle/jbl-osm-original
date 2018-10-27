#!/bin/bash
export PGHOST=localhost
export PGUSER=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASSWORD
export PGDATABASE=$POSTGRES_DB

# useradd -G sudo $POSTGRES_USER
# su $POSTGRES_USER


#import Melbourne city
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /Melbourne.osm.pbf

# -> YO Michael, 
# -> Let's start with just the same instruction, but with `--create` option instread of `--style` (have they even once imported data for their customer(s)...??)
# osm2pgsql --create --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER --slim -C 4096 /australia-oceania-latest.osm.pbf 
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER -k --slim /australia-oceania-latest.osm.pbf 
# && touch /var/lib/postgresql/data/DB_INITED
# osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /australia-oceania/australia-latest.osm.pbf

# --- skipping all shinesolutions shit 
# 
# --- En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#database-options]  : 
# 
# " This should only be used on full planet imports or very large extracts (e.g. Europe) but in 
#  those situations offers significant space savings and speed increases, particularly on mechanical
#   drives. The file takes approximately 8 bytes * maximum node ID, or about 23 GiB, regardless of the size of the extract. "
# 
# --- > je vais utiliser l'options "--flat-nodes", parce que j'importe la terre entière, ici un fihcier de 42 Go quand même...
# --- En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#middle-layer-options] : 
# 
# " A --slim --drop import is generally the fastest way to import the planet if updates are not required. "
# 
# Je vais utiliser aussi la combinaison d'options [ --slim --drop]
# --- En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#output-columns-options] : 
# 
# " --style specifies the location of the style file. This defines what columns are created, what tags denote #
#  areas, and what tags can be ignored. The default.style contains more documentation on this file. "
# 
# --- > je vais utiliser l'options " --style /openstreetmap-carto/openstreetmap-carto.style " pour appliquer le style d'openstreemp carto
# --- En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#column-options] : 
# 
# " '--extra-attributes' :  creates pseudo-tags with OSM meta-data like user, last edited, and changeset. 
#     These also need to be added to the style file. "DOWNLOADED_PBF_FILES_HOME
# 
# --- > je vais utiliser l'option "--extra-attributes", le premier test retour que je ferais consistera à enlever cette option. Eneffet, que se passe-t-il si le fichier de stle ne comprend pas une définition du modèle de méta-données utilisateur OSM, compatible avec celui supposé dans les données importées (le fichier PBF) ?

echo "Contenu de [DOWNLOADED_PBF_FILES_HOME=$DOWNLOADED_PBF_FILES_HOME]" 
ls -allh $DOWNLOADED_PBF_FILES_HOME
osm2pgsql -U $POSTGRES_USER --create --flat-nodes --extra-attributes --slim --drop --style /openstreetmap-carto/openstreetmap-carto.style --database gis $DOWNLOADED_PBF_FILES_HOME/panet-latest.osm.pbf 


