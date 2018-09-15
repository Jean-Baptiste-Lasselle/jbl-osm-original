# Utilisation

```bash
mkdir -p osm-fleuri
cd osm-fleuri
git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . 
sudo rm -rf ./data && sudo rm -rf ./renderer/shapes/ 
chmod +x *.sh 
./download.sh && docker-compose down --rmi all 
docker system prune -f 
docker-compose up -d --build && docker ps -a
```


Commande idempotente en une seule ligne:

```bash
mkdir -p coquelicot && cd coquelicot && git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . && sudo rm -rf ./data && sudo rm -rf ./renderer/shapes/ && chmod +x *.sh && ./download.sh && docker-compose down --rmi all && docker system prune -f && docker-compose up -d --build && docker ps -a
```

# Dernière erreur

Des fichiers atendus par le build de l'image Docker du nginx, manquent:

```baash
 ---> Running in 04ffb3903a00
Cloning into 'openstreetmap-carto'...
Removing intermediate container 04ffb3903a00
 ---> 9ffe2f0eff0e
Step 6/17 : WORKDIR /openstreetmap-carto
 ---> Running in ee0df701002c
Removing intermediate container ee0df701002c
 ---> 2c19f3f15635
Step 7/17 : ADD shapes/ data/
 ---> 7982dc512e18
Step 8/17 : RUN shapeindex --shape_files     data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp     data/water-polygons-split-3857/water_polygons.shp     data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp     data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp     data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp
 ---> Running in a07f0367421f
max tree depth:8
split ratio:0.55
processing data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp
error : file data/simplified-water-polygons-complete-3857/simplified_water_polygons.shp does not exist
processing data/water-polygons-split-3857/water_polygons.shp
error : file data/water-polygons-split-3857/water_polygons.shp does not exist
processing data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp
error : file data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp does not exist
processing data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp
error : file data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp does not exist
processing data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp
error : file data/ne_110m_admin_0_boundary_lines_land/ne_110m_admin_0_boundary_lines_land.shp does not exist
done!
Removing intermediate container a07f0367421f
```
Et d'autre part, le serveur PostGIS interrompt son exécution, avec un code d'erreur 1, voci les logs du conteneur `postgis`  : 

```bash
$ docker logs melbourne-map_postgis_1
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
creating template1 database in /var/lib/postgresql/data/base/1 ... ok
initializing pg_authid ... ok
initializing dependencies ... ok
creating system views ... ok
loading system objects' descriptions ... ok
creating collations ... ok
creating conversions ... ok
creating dictionaries ... ok
setting privileges on built-in objects ... ok
creating information schema ... ok
loading PL/pgSQL server-side language ... ok
vacuuming database template1 ... ok
copying template1 to template0 ... ok
copying template1 to postgres ... ok
syncing data to disk ... ok

Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start


WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
****************************************************
WARNING: No password has been set for the database.
         This will allow anyone with access to the
         Postgres port to access your database. In
         Docker's default configuration, this is
         effectively any other container on the same
         system.

         Use "-e POSTGRES_PASSWORD=password" to set
         it in "docker run".
****************************************************
waiting for server to start....LOG:  database system was shut down at 2018-08-17 02:19:03 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  autovacuum launcher started
LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE

ALTER ROLE


/usr/local/bin/docker-entrypoint.sh: sourcing /docker-entrypoint-initdb.d/postgis.sh
CREATE DATABASE
UPDATE 1
Loading PostGIS extensions into template_postgis
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
Loading PostGIS extensions into gis
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
osm2pgsql version 0.92.0 (64 bit id space)

Using built-in tag processing pipeline
Using projection SRS 3857 (Spherical Mercator)
Setting up table: planet_osm_point
Setting up table: planet_osm_line
Setting up table: planet_osm_polygon
Setting up table: planet_osm_roads
Allocating memory for dense node cache
Allocating dense node cache in one big chunk
Allocating memory for sparse node cache
Sharing dense sparse
Node-cache: cache=800MB, maxblocks=12800*65536, allocation method=11
Mid: pgsql, scale=100 cache=800
Setting up table: planet_osm_nodes
Setting up table: planet_osm_ways
Setting up table: planet_osm_rels

Reading in file: /Melbourne.osm.pbf
Using PBF parser.
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_point, line 1
STATEMENT:  COPY planet_osm_point (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","capital","construction","covered","culvert","cutting","denomination","disused","ele","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","poi","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tunnel","water","waterway","wetland","width","wood","z_order",tags,way) FROM STDIN
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_line, line 1
STATEMENT:  COPY planet_osm_line (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","construction","covered","culvert","cutting","denomination","disused","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tracktype","tunnel","water","waterway","wetland","width","wood","z_order","way_area",tags,way) FROM STDIN
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_point (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","capital","construction","covered","culvert","cutting","denomination","disused","ele","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","poi","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tunnel","water","waterway","wetland","width","wood","z_order",tags,way) FROM STDIN
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_roads, line 1
STATEMENT:  COPY planet_osm_roads (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","construction","covered","culvert","cutting","denomination","disused","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tracktype","tunnel","water","waterway","wetland","width","wood","z_order","way_area",tags,way) FROM STDIN
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_line (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","construction","covered","culvert","cutting","denomination","disused","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tracktype","tunnel","water","waterway","wetland","width","wood","z_order","way_area",tags,way) FROM STDIN
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_roads (osm_id,"access","addr:housename","addr:housenumber","addr:interpolation","admin_level","aerialway","aeroway","amenity","area","barrier","bicycle","brand","bridge","boundary","building","construction","covered","culvert","cutting","denomination","disused","embankment","foot","generator:source","harbour","highway","historic","horse","intermittent","junction","landuse","layer","leisure","lock","man_made","military","motorcar","name","natural","office","oneway","operator","place","population","power","power_source","public_transport","railway","ref","religion","route","service","shop","sport","surface","toll","tourism","tower:type","tracktype","tunnel","water","waterway","wetland","width","wood","z_order","way_area",tags,way) FROM STDIN
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_nodes, line 1
STATEMENT:  COPY planet_osm_nodes FROM STDIN;
	
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_nodes FROM STDIN;
	
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_ways, line 1
STATEMENT:  COPY planet_osm_ways FROM STDIN;
	
node cache: stored: 0(-nan%), storage efficiency: -nan% (dense blocks: 0, sparse nodes: 0), hit rate: -nan%
Osm2pgsql failed due to ERROR: Open failed for '/Melbourne.osm.pbf': No such file or directory
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_ways FROM STDIN;
	
ERROR:  unexpected message type 0x58 during COPY from stdin
CONTEXT:  COPY planet_osm_rels, line 1
STATEMENT:  COPY planet_osm_rels FROM STDIN;
	
LOG:  could not send data to client: Broken pipe
STATEMENT:  COPY planet_osm_rels FROM STDIN;

```
Il semblerait que cette erreur soit connue, et due à un timeout: le télchargement des données est trop long. Il est trop long parce que les données sont de très gros volume, et non parce qu'il y a un problème réseau.


# Melbourne map

Provides a configuration to launch your own retina ready map renderer.

## Run it

```
$ ./download.sh
$ docker-compose build
$ docker-compose up
```

It will take a while for a first start (up to 10 mins) because of DB import.
You will know that renderer is ready to use when see logs like this:

```
postgis_1   | LOG:  autovacuum launcher started
renderer_1  | Starting renderer
renderer_1  | 2016/12/27 23:34:30 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9080
renderer_1  | 2016/12/27 23:34:30 app.go:267: [INFO] Serving monitoring xml data on %s... :9080
renderer_1  | 2016/12/27 23:34:30 renderselector.go:209: [DEBUG] ping error %v dial tcp 127.0.0.1:8090: getsockopt: connection refused
renderer_1  | 2016/12/27 23:34:30 renderselector.go:117: [DEBUG] '%v' is %v localhost:8090 Offline
renderer_1  | 2016/12/27 23:34:30 main.go:118: [INFO] Starting on %s... :8080
renderer_1  | 2016/12/27 23:34:30 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9090
renderer_1  | 2016/12/27 23:34:30 app.go:267: [INFO] Serving monitoring xml data on %s... :9090
renderer_1  | 2016/12/27 23:34:35 main.go:95: [INFO] Done in %v seconds 4.84147165
renderer_1  | 2016/12/27 23:34:35 main.go:103: [INFO] Starting on %s... :8090
```

Then you can open example in your favourite web browser:
```
http://localhost:8888
```
The initial rendering may take 10-30 seconds, after which you will see a fabulous map of Melbourne city.


## Renders other areas

You will need to update postgis image to render other city/area:

* Update postgis/Dockerfile by adding different pbf file to container
```
wget https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf
```
* Update postgis/initdb-postgis.sh to use a new file
```
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /melbourne_australia.osm.pbf
```

## Using custom style

This project is using [forked version](https://github.com/dooman87/openstreetmap-carto) of 
 [openstreetmap-carto style](https://github.com/gravitystorm/openstreetmap-carto) that
 optimised for hi-res displays.

There are two places that you have to tweak to use different style:

* postgis/initdb-postgis.sh is using style during DB import (--style option):
```
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /melbourne_australia.osm.pbf
```
* renderer/map_data/config.json defines style on line 72:
```
"Cmd": ["/gopnik/bin/gopnikslave", 
"-stylesheet", "/openstreetmap-carto/stylesheet.xml", 
"-pluginsPath", "/usr/lib/mapnik/2.2/input", 
"-fontsPath", "/usr/share/fonts", "-scaleFactor", "2"],
```

## Update database
You can update database by removing data volume and restart containers:
```
$ ./clean.sh
$ docker-compose up
```
