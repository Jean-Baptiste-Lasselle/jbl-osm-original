#!/usr/bin/env bash

# Compiling carto css style and generates OSM xml
# that can be passed to mapnik.

carto /openstreetmap-carto/project.mml > /map_data/stylesheet_.xml

echo "  "
echo " ----- "
echo " VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB_HOST=$MAPNIK_POSTGRES_DB_HOST]"
echo " VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB_PORT_NO=$MAPNIK_POSTGRES_DB_PORT_NO]"
echo " VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB=$MAPNIK_POSTGRES_DB]"
echo " VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_USER=$MAPNIK_POSTGRES_USER]"
echo " VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_PASSWORD=$MAPNIK_POSTGRES_PASSWORD]"
echo " ----- "
echo "  "

DS='<Parameter name=\"$MAPNIK_POSTGRES_DB\"><![CDATA[gis]]><\/Parameter>\
    <Parameter name=\"MAPNIK_POSTGRES_DB_HOST\"><![CDATA[postgis]]><\/Parameter>\
    <Parameter name=\"$MAPNIK_POSTGRES_DB_PORT_NO\"><![CDATA[5432]]><\/Parameter>\
    <Parameter name=\"$MAPNIK_POSTGRES_USER\"><![CDATA[postgres]]><\/Parameter>\
    <Parameter name=\"$MAPNIK_POSTGRES_PASSWORD\"><![CDATA[postgres]]><\/Parameter>'
sed "s/<Parameter name=\"dbname\">.*<\/Parameter>/${DS}/" /map_data/stylesheet_.xml > /map_data/stylesheet.xml
rm /map_data/stylesheet_.xml
