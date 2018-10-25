#!/usr/bin/env bash

set -e -u

export PBF_FILENAME=planet-latest.osm.pbf
# export PBF_DOWNLOAD_URI=https://download.geofabrik.de/australia-oceania-latest.osm.pb
export PBF_DOWNLOAD_URI=https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf

UNZIP_OPTS=-qqun
SHAPES_DIR=renderer/shapes
# pour télécharger en préliminaire du cycle IAAC, les fichiers PBF volmineux, au lieu de faire les téléchéargement dans le build de l'image renderer
PBF_VAULT_HOME=/carto/vault

WHEREEVERIWASBEFORE=`pwd`
mkdir -p $PBF_VAULT_HOME


cd $PBF_VAULT_HOME

if [ -f ./$PBF_FILENAME ]; then
   echo "Le fichier if [$PBF_FILENAME] existe déjà : ";
   ls -all ./$PBF_FILENAME
else 
   echo "Téléchargement du fichier [$PBF_FILENAME] ... "
   wget "$PBF_DOWNLOAD_URI"
   echo " Téléchargement du fichier [$PBF_FILENAME] terminé : "
   ls -all ./$PBF_FILENAME
fi

cd $WHEREEVERIWASBEFORE

# create and populate data dir
mkdir -p ${SHAPES_DIR}
mkdir -p ${SHAPES_DIR}/world_boundaries
mkdir -p ${SHAPES_DIR}/simplified-water-polygons-complete-3857
mkdir -p ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land
mkdir -p ${SHAPES_DIR}/water-polygons-split-3857



cd $PBF_VAULT_HOME

if [ -f $PBF_VAULT_HOME/world_boundaries-spherical.tgz ]; then
   echo "Le fichier [$PBF_VAULT_HOME/world_boundaries-spherical.tgz] existe déjà : ";
   ls -all $PBF_VAULT_HOME/world_boundaries-spherical.tgz
else 
   echo "Téléchargement du fichier [$PBF_VAULT_HOME/world_boundaries-spherical.tgz] ... "
   # world_boundaries
   echo "downloading world_boundaries  [${PBF_VAULT_HOME}/world_boundaries-spherical.tgz] into [PBF_VAULT_HOME=$PBF_VAULT_HOME] ..."
   curl -z "${PBF_VAULT_HOME}/world_boundaries-spherical.tgz" -L -o "${PBF_VAULT_HOME}/world_boundaries-spherical.tgz" "https://planet.openstreetmap.org/historical-shapefiles/world_boundaries-spherical.tgz"
   echo " Téléchargement du fichier [$PBF_VAULT_HOME/world_boundaries-spherical.tgz] terminé : "
   ls -all $PBF_VAULT_HOME/world_boundaries-spherical.tgz
fi



# cp f $PBF_VAULT_HOME/world_boundaries-spherical.tgz ${SHAPES_DIR}/world_boundaries-spherical.tgz 
# cf. fin du script (end of script) : cp -Rf $PBF_VAULT_HOME/ ${SHAPES_DIR}/ 


# Je ne vérifie pas l'existence des fichiers *.shp *.shx *.prj *.dnf *.cpg , je me contente de l'existence du zip
# (ça se dézippe, des shapefiles...?)
# I don't check existence of  *.shp *.shx *.prj *.dnf *.cpg files, just rely on zip's
if [ -f $PBF_VAULT_HOME/simplified-water-polygons-complete-3857.zip ]; then
   echo "Le fichier [$PBF_VAULT_HOME/simplified-water-polygons-complete-3857.zip] existe déjà : ";
   ls -all $PBF_VAULT_HOME/simplified-water-polygons-complete-3857.zip
else 
   echo "Téléchargement du fichier [$PBF_VAULT_HOME/simplified-water-polygons-complete-3857.zip] ... "
   # simplified-water-polygons-complete-3857
   echo "downloading simplified-water-polygons-complete-3857..."
   curl -z "${PBF_VAULT_HOME}/simplified-water-polygons-complete-3857.zip" -L -o "${PBF_VAULT_HOME}/simplified-water-polygons-complete-3857.zip" "http://data.openstreetmapdata.com/simplified-water-polygons-complete-3857.zip"
   echo " Téléchargement du fichier [${PBF_VAULT_HOME}/simplified-water-polygons-complete-3857.zip] terminé : "
   ls -all ${PBF_VAULT_HOME}/simplified-water-polygons-complete-3857.zip
fi



# Je ne vérifie pas l'existence des fichiers *.shp *.shx *.prj *.dnf *.cpg , je me contente de l'existence du zip
# (ça se dézippe, des shapefiles...?)
# I don't check existence of  *.shp *.shx *.prj *.dnf *.cpg files, just rely on zip's
if [ -f ${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip ]; then
   echo "Le fichier [${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip] existe déjà : ";
   ls -all ${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip
else 
   echo "Téléchargement du fichier [${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip] ... "
   # ne_110m_admin_0_boundary_lines_land
   echo "downloading ne_110m_admin_0_boundary_lines_land..."
   curl -z ${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip -L -o ${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_boundary_lines_land.zip
   echo " Téléchargement du fichier [${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip] terminé : "
   ls -all ${PBF_VAULT_HOME}/ne_110m_admin_0_boundary_lines_land.zip
fi




# Je ne vérifie pas l'existence des fichiers *.shp *.shx *.prj *.dnf *.cpg , je me contente de l'existence du zip
# (ça se dézippe, des shapefiles...?)
# I don't check existence of  *.shp *.shx *.prj *.dnf *.cpg files, just rely on zip's
if [ -f ${PBF_VAULT_HOME}/water-polygons-split-3857.zip ]; then
   echo "Le fichier [${PBF_VAULT_HOME}/water-polygons-split-3857.zip] existe déjà : ";
   ls -all ${PBF_VAULT_HOME}/water-polygons-split-3857.zip
else 
   echo "Téléchargement du fichier [${PBF_VAULT_HOME}/water-polygons-split-3857.zip] ... "
   # water-polygons-split-3857
   echo "downloading water-polygons-split-3857..."
   curl -z "${PBF_VAULT_HOME}/water-polygons-split-3857.zip" -L -o "${PBF_VAULT_HOME}/water-polygons-split-3857.zip" "http://data.openstreetmapdata.com/water-polygons-split-3857.zip"
   echo " Téléchargement du fichier [${PBF_VAULT_HOME}/water-polygons-split-3857.zip] terminé : "
   ls -all ${PBF_VAULT_HOME}/water-polygons-split-3857.zip
fi



# Je ne vérifie pas l'existence des fichiers *.shp *.shx *.prj *.dnf *.cpg , je me contente de l'existence du zip
# (ça se dézippe, des shapefiles...?)
# I don't check existence of  *.shp *.shx *.prj *.dnf *.cpg files, just rely on zip's
if [ -f ${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip ]; then
   echo "Le fichier [${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip] existe déjà : ";
   ls -all ${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip
else 
   echo "Téléchargement du fichier [${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip] ... "
   # antarctica-icesheet-polygons-3857
   echo "antarctica-icesheet-polygons-3857.zip..."
   curl -z "${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip" -L -o "${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip" "http://data.openstreetmapdata.com/antarctica-icesheet-polygons-3857.zip"
   echo " Téléchargement du fichier [${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip] terminé : "
   ls -all ${PBF_VAULT_HOME}/antarctica-icesheet-polygons-3857.zip
fi



# Je ne vérifie pas l'existence des fichiers *.shp *.shx *.prj *.dnf *.cpg , je me contente de l'existence du zip
# (ça se dézippe, des shapefiles...?)
# I don't check existence of  *.shp *.shx *.prj *.dnf *.cpg files, just rely on zip's
if [ -f ${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip ]; then
   echo "Le fichier [${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip] existe déjà : ";
   ls -all ${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip
else 
   echo "Téléchargement du fichier [${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip] ... "
   # antarctica-icesheet-outlines-3857
   echo "downloading antarctica-icesheet-outlines-3857..."
   curl -z "${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip" -L -o "${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip" "http://data.openstreetmapdata.com/antarctica-icesheet-outlines-3857.zip"
   echo " Téléchargement du fichier [${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip] terminé : "
   ls -all ${PBF_VAULT_HOME}/antarctica-icesheet-outlines-3857.zip
fi



# rm renderer/shapes/*.zip
# rm renderer/shapes/*.tgz
# PBF_VAULT content : 
# -rw-rw-r--. 1 jibl jibl    53921335 Oct 25 20:52 antarctica-icesheet-outlines-3857.zip
# -rw-rw-r--. 1 jibl jibl    52997121 Oct 25 20:42 antarctica-icesheet-polygons-3857.zip
# -rw-rw-r--. 1 jibl jibl       45820 Oct 25 20:41 ne_110m_admin_0_boundary_lines_land.zip
# -rw-rw-r--. 1 jibl jibl 38158221312 Oct 25 18:38 planet-latest.osm.pbf
# -rw-rw-r--. 1 jibl jibl    23696302 Oct 25 20:41 simplified-water-polygons-complete-3857.zip
# -rw-rw-r--. 1 jibl jibl   551960621 Oct 25 20:42 water-polygons-split-3857.zip
# -rw-rw-r--. 1 jibl jibl    52857349 Oct 25 20:38 world_boundaries-spherical.tgz


cd $WHEREEVERIWASBEFORE

cp -f $PBF_VAULT_HOME/antarctica-icesheet-outlines-3857.zip ${SHAPES_DIR}
cp -f $PBF_VAULT_HOME/antarctica-icesheet-polygons-3857.zip ${SHAPES_DIR}
cp -f $PBF_VAULT_HOME/ne_110m_admin_0_boundary_lines_land.zip ${SHAPES_DIR}
cp -f $PBF_VAULT_HOME/simplified-water-polygons-complete-3857.zip ${SHAPES_DIR}
cp -f $PBF_VAULT_HOME/water-polygons-split-3857.zip ${SHAPES_DIR}
cp -f $PBF_VAULT_HOME/world_boundaries-spherical.tgz ${SHAPES_DIR}


cp -Rf $PBF_VAULT_HOME/* ${SHAPES_DIR}

echo "expanding world_boundaries into [PBF_VAULT_HOME=$SHAPES_DIR] ..."
tar -xzf ${SHAPES_DIR}/world_boundaries-spherical.tgz -C ${SHAPES_DIR}/

echo "expanding simplified-water-polygons-complete-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/simplified-water-polygons-complete-3857.zip \
  simplified-water-polygons-complete-3857/simplified_water_polygons.shp \
  simplified-water-polygons-complete-3857/simplified_water_polygons.shx \
  simplified-water-polygons-complete-3857/simplified_water_polygons.prj \
  simplified-water-polygons-complete-3857/simplified_water_polygons.dbf \
  simplified-water-polygons-complete-3857/simplified_water_polygons.cpg \
  -d ${SHAPES_DIR}/
  
echo "expanding ne_110m_admin_0_boundary_lines_land..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land.zip \
  ne_110m_admin_0_boundary_lines_land.shp \
  ne_110m_admin_0_boundary_lines_land.shx \
  ne_110m_admin_0_boundary_lines_land.prj \
  ne_110m_admin_0_boundary_lines_land.dbf \
  -d ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land/
  
echo "expanding water-polygons-split-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/water-polygons-split-3857.zip \
  water-polygons-split-3857/water_polygons.shp \
  water-polygons-split-3857/water_polygons.shx \
  water-polygons-split-3857/water_polygons.prj \
  water-polygons-split-3857/water_polygons.dbf \
  water-polygons-split-3857/water_polygons.cpg \
  -d ${SHAPES_DIR}/

echo "expanding antarctica-icesheet-polygons-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/antarctica-icesheet-polygons-3857.zip \
  antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
  antarctica-icesheet-polygons-3857/icesheet_polygons.shx \
  antarctica-icesheet-polygons-3857/icesheet_polygons.prj \
  antarctica-icesheet-polygons-3857/icesheet_polygons.dbf \
  -d ${SHAPES_DIR}/

echo "expanding antarctica-icesheet-outlines-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/antarctica-icesheet-outlines-3857.zip \
  antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
  antarctica-icesheet-outlines-3857/icesheet_outlines.shx \
  antarctica-icesheet-outlines-3857/icesheet_outlines.prj \
  antarctica-icesheet-outlines-3857/icesheet_outlines.dbf \
  -d ${SHAPES_DIR}/
