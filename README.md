
![I love you  I miss you V.](https://www.youtube.com/watch?v=god7hAPv8f0)

# passe-chaud

Effectivement, [retirer la mention `localhost` du fichier de configuration `./renderer/map_data/config.json`](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/issues/8) a bien inféré un changeement dans les logs du renderer :+1: 

J'observe cependant, que j'ai toujours une erreur, pour la connexion à  "`:8090`".
Observez aussi la mention `starting renderer`, juste après la mention `DB successfully created, waiting for restart`




```bash
[jibl@pc-100 proto]$ docker logs -f rendereurpoulet
 ------------------------------------------------------------------------------------------- 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_USER=renderer_user] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_DB=bddgeoloc] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_DB_HOST=postgis] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_PASSWORD=whereischarlie] 
 VERIFICATION RENDERER ENNTRYPOINT : [PGUSER=renderer_user] 
 VERIFICATION RENDERER ENNTRYPOINT  : [PGPASSWORD=whereischarlie] 
 ------------------------------------------------------------------------------------------- 
  
 ----- 
 VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB_HOST=postgis]
 VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB_PORT_NO=5432]
 VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_DB=bddgeoloc]
 VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_USER=renderer_user]
 VERIF JBL dans complie_style.sh de monsieur catactrophe aka 'domman84' [MAPNIK_POSTGRES_PASSWORD=whereischarlie]
 ----- 
  
DB successfully created, waiting for restart
Starting renderer
2018/10/28 03:16:18 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9090
2018/10/28 03:16:18 app.go:267: [INFO] Serving monitoring xml data on %s... :9090
2018/10/28 03:16:18 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9080
2018/10/28 03:16:18 app.go:267: [INFO] Serving monitoring xml data on %s... :9080
2018/10/28 03:16:18 renderselector.go:209: [DEBUG] ping error %v dial tcp :8090: getsockopt: connection refused
2018/10/28 03:16:18 renderselector.go:117: [DEBUG] '%v' is %v :8090 Offline
2018/10/28 03:16:18 main.go:118: [INFO] Starting on %s... :8080
2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v Exception: Postgis Plugin: FATAL:  password authentication failed for user "renderer_user"

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v 

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v Connection string: 'host=postgis port=5432 dbname=bddgeoloc user=renderer_user connect_timeout=4'

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v   encountered during parsing of layer 'landcover-low-zoom' in Layer at line 334 of '/openstreetmap-carto/stylesheet.xml'

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v Exception: Postgis Plugin: FATAL:  password authentication failed for user "renderer_user"

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v 

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v Connection string: 'host=postgis port=5432 dbname=bddgeoloc user=renderer_user connect_timeout=4'

2018/10/28 03:16:19 render.go:35: [ERROR] Render child error: %v   encountered during parsing of layer 'landcover-low-zoom' in Layer at line 334 of '/openstreetmap-carto/stylesheet.xml'

2018/10/28 03:16:19 main.go:91: [CRITICAL] Failed to create tile server: Failed to create some renders: [Invalid read uint64: EOF Invalid read uint64: EOF]
2018/10/28 03:16:48 renderselector.go:209: [DEBUG] ping error %v dial tcp :8090: getsockopt: connection refused
2018/10/28 03:16:48 renderselector.go:117: [DEBUG] '%v' is %v :8090 Offline
2018/10/28 03:17:18 renderselector.go:209: [DEBUG] ping error %v dial tcp :8090: getsockopt: connection refused
2018/10/28 03:17:18 renderselector.go:117: [DEBUG] '%v' is %v :8090 Offline
2018/10/28 03:17:48 renderselector.go:209: [DEBUG] ping error %v dial tcp :8090: getsockopt: connection refused
2018/10/28 03:17:48 renderselector.go:117: [DEBUG] '%v' is %v :8090 Offline
2018/10/28 03:18:18 renderselector.go:209: [DEBUG] ping error %v dial tcp :8090: getsockopt: connection refused
2018/10/28 03:18:18 renderselector.go:117: [DEBUG] '%v' is %v :8090 Offline
^C
[jibl@pc-100 proto]$ 
```


Désormais, hormis ce mystérieux échec de connexion à `:8090`, le seul problème problème qui reste est un erreur d'authentification du serveur GOPNIK, au serveur PostGreSQL. Ce ne sont ni le mot de passe, ou le nom d'utilisateur, dont le conteneur `renderer` fait usage pour s'authentifier à PostGreSQL, qui posent problème.
Ce qui pose problème, c'est que je n'arrive pas à crééer l'utilisateur que je souahaite, et je ne VEUX PAS, utilsier le premier super-admoin, pour authentifier une appliation parmi d'autres dans un SI.


Et c'est logique, puisque je suis en train de résoudre ce dernier problème, en reconstruisantt de zéro mon stack postgresql / postgis dockerisé (les images et Dockerfiles trouvées dans les repos et doc parcourues présntent souvent le problème de référencer la 'latest', et bien evidemment,  12 mois plus tard, on obtient un plantage.
Exemple : dans le [fichier dockerfile suggéré par la documentation Docker](), et que otu ce petit monde semble utiliser sans se poser de question, on un `FROM ubuntu`. Sauf que `python-software-properties` n'existe plus sur les repository Ubuntu des releases >= 12.04, et pas de chance, aujourd'hui on est bien plus loin que la rrelease 12.04, dans les latest publiée par Ubuntu.


# À regarder

https://affinitybridge.com/blog/server-side-mapping

Là je vais avoir quelques combinaisons à tester, une fois débarrassé des dernières erreurs de la version en cours 


* appel d'unwebservice geoloc / meteo avec promises et meteorjs : 

https://www.youtube.com/watch?v=KLQFFeVHI8s



# Dernière erreur

```bash
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS                            PORTS                                                                          NAMES
d7de061dcbcc        carto-proto_renderer          "/bin/sh -c /entrypo…"   2 seconds ago       Up Less than a second             0.0.0.0:8080->8080/tcp, 0.0.0.0:8090->8090/tcp, 0.0.0.0:9090->9090/tcp         rendereurpoulet
22bcfec38a3a        carto-proto_postgis           "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds (health: starting)   5432/tcp                                                                       postgis
61d971c85f60        nginx:1.11-alpine             "nginx -g 'daemon of…"   3 seconds ago       Up 2 seconds                      443/tcp, 0.0.0.0:8888->80/tcp                                                  carto-proto_web_1
5a7c86a2cd3c        nginx                         "nginx -g 'daemon of…"   5 days ago          Up 14 hours                       80/tcp, 0.0.0.0:1222->322/tcp, 0.0.0.0:1443->7443/tcp, 0.0.0.0:801->8030/tcp   marguerite_reverseproxy
fc3e83c41a29        marguerite/meteor-ide:1.0.0   "/bin/sh -c $WORKSPA…"   5 days ago          Up 14 hours (healthy)             0.0.0.0:6000->6000/tcp                                                         ide_meteor_marguerite
d5701330a0f2        marguerite/mongo:1.0.0        "docker-entrypoint.s…"   5 days ago          Up 14 hours (unhealthy)           0.0.0.0:27018->27017/tcp                                                       ide_mongo_marguerite
[jibl@pc-100 carto-proto]$ docker exec -it postgis sh -c "psql -U renderer-user -d gis"psql (9.5.14)
Type "help" for help.

gis=# \q
[jibl@pc-100 carto-proto]$ docker logs -f postgis
LOG:  database system was shut down at 2018-10-22 21:06:36 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  database system is ready to accept connections
LOG:  autovacuum launcher started
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
FATAL:  role "root" does not exist
^C
```
me suis débarassé de l'erreur root causée par lecheckhealth, et il me reste : 

```bash
[jibl@pc-100 carto-proto]$ docker logs -f postgis
LOG:  database system was shut down at 2018-10-22 21:59:16 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  database system is ready to accept connections
LOG:  autovacuum launcher started
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;


```

J'ai trouvé : 

![pb avec les data et project.mml](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/raw/master/issues-memory/probleme_data_project_mml.png)

Et là: ce qui est  en cause, ce n'est pas la validité du project.mml, dont je pense qu'il a été copié sans aucun changment au travers des 2 repos que j'ai du travaerser, pour retrouver `openstreetmap-carto`.
Donc ce qui est en cause est simple, il s'agit des commandes osm2pgsql inscrites dans le dockerfile postgis :
* Il n'y a qu'une seule instruction, et elle utilise l'option `--style`, mais absolument pas l'option `--create` ,
* Hors la doc de `osm2pgsql` indique clairement (`./README.md` racine ) qu'une ["invocation typique"](https://github.com/openstreetmap/osm2pgsql/blob/master/README.md#usage)  de `osm2pgsql` utilise l'option `--create`, et que cette option créée les tables postgesql suivantes :
  * `planet_osm_point`
  * `planet_osm_line`
  * `planet_osm_roads`
  * `planet_osm_polygon` (Hey, Oh My! The exact table name mentionend in my error logs !  :) :100: )
En effet, Je cite la [documentation officielle `osm2pgsql`](https://github.com/openstreetmap/osm2pgsql/blob/master/README.md#usage) : 
  > A basic invocation to load the data into the database gis for rendering would be
  
  > `osm2pgsql --create --database gis data.osm.pbf`
  
  > This will load the data from `data.osm.pbf` into the `planet_osm_point`, `planet_osm_line`, `planet_osm_roads`, and `planet_osm_polygon` tables.

Donc, je vais utiliser l'instruction de la forme : 


  > When importing a large amount of data such as the complete planet, a typical command line would be
  
  > `osm2pgsql -c -d gis --slim -C <cache size> --flat-nodes <flat nodes> planet-latest.osm.pbf`
	
  > where
  
  >     `<cache size>` is about 75% of memory in MiB, to a maximum of about 30000. Additional RAM will not be used.
  >     `<flat nodes>` is a location where a 36GiB+ file can be saved.

et vérifier si cette fois , ma table `planet_osm_point` existe bel et bien.

### Essai 1 : `osm2pgsql --create /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER -k --slim /australia-oceania-latest.osm.pbf `




```bash
[jibl@pc-100 carto-proto]$ docker logs -f postgis
LOG:  database system was shut down at 2018-10-22 22:43:29 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  database system is ready to accept connections
LOG:  autovacuum launcher started
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;
ERROR:  relation "planet_osm_polygon" does not exist at character 651
STATEMENT:  SELECT ST_SRID("way") AS srid FROM (SELECT
	    way, name, way_pixels,
	    COALESCE(wetland, landuse, "natural") AS feature
	  FROM (SELECT
	      way, COALESCE(name, '') AS name,
	      ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,
	      ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",
	      ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,
	      way_area/NULLIF(0::real*0::real,0) AS way_pixels
	    FROM planet_osm_polygon
	    WHERE (landuse IN ('forest', 'military')
	      OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))
	      AND way_area > 0.01*0::real*0::real
	      AND building IS NULL
	    ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC
	  ) AS features
	) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;
^C                
[jibl@pc-100 carto-proto]$ docker logs -f rendereurpoulet
 ------------------------------------------------------------------------------------------- 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_USER=renderer-user] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_DB=gis] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_DB_HOST=postgis] 
 VERIFICATION RENDERER ENNTRYPOINT : [MAPNIK_POSTGRES_PASSWORD=whereischarlie] 
 VERIFICATION RENDERER ENNTRYPOINT : [PGUSER=renderer-user] 
 VERIFICATION RENDERER ENNTRYPOINT  : [PGPASSWORD=whereischarlie] 
 ------------------------------------------------------------------------------------------- 
DB successfully created, waiting for restart
Starting renderer
2018/10/23 16:09:26 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9090
2018/10/23 16:09:26 app.go:267: [INFO] Serving monitoring xml data on %s... :9090
2018/10/23 16:09:26 app.go:266: [INFO] Serving debug data (/debug/vars) on %s... :9080
2018/10/23 16:09:26 app.go:267: [INFO] Serving monitoring xml data on %s... :9080
2018/10/23 16:09:26 renderselector.go:209: [DEBUG] ping error %v dial tcp 127.0.0.1:8090: getsockopt: connection refused
2018/10/23 16:09:26 renderselector.go:117: [DEBUG] '%v' is %v localhost:8090 Offline
2018/10/23 16:09:26 main.go:118: [INFO] Starting on %s... :8080
2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v Exception: ERROR:  relation "planet_osm_polygon" does not exist

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v LINE 10:     FROM planet_osm_polygon

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v                   ^

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v 

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v Full sql was: 'SELECT ST_SRID("way") AS srid FROM (SELECT

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     way, name, way_pixels,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     COALESCE(wetland, landuse, "natural") AS feature

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   FROM (SELECT

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       way, COALESCE(name, '') AS name,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       way_area/NULLIF(0::real*0::real,0) AS way_pixels

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     FROM planet_osm_polygon

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     WHERE (landuse IN ('forest', 'military')

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       AND way_area > 0.01*0::real*0::real

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       AND building IS NULL

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   ) AS features

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v ) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;'

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   encountered during parsing of layer 'landcover-low-zoom' in Layer at line 334 of '/openstreetmap-carto/stylesheet.xml'

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v Exception: ERROR:  relation "planet_osm_polygon" does not exist

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v LINE 10:     FROM planet_osm_polygon

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v                   ^

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v 

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v Full sql was: 'SELECT ST_SRID("way") AS srid FROM (SELECT

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     way, name, way_pixels,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     COALESCE(wetland, landuse, "natural") AS feature

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   FROM (SELECT

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       way, COALESCE(name, '') AS name,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('landuse_' || (CASE WHEN landuse IN ('forest', 'military') THEN landuse ELSE NULL END)) AS landuse,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('natural_' || (CASE WHEN "natural" IN ('wood', 'sand', 'scree', 'shingle', 'bare_rock') THEN "natural" ELSE NULL END)) AS "natural",

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       ('wetland_' || (CASE WHEN "natural" IN ('wetland', 'mud') THEN (CASE WHEN "natural" IN ('mud') THEN "natural" ELSE wetland END) ELSE NULL END)) AS wetland,

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       way_area/NULLIF(0::real*0::real,0) AS way_pixels

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     FROM planet_osm_polygon

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     WHERE (landuse IN ('forest', 'military')

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       OR "natural" IN ('wood', 'wetland', 'mud', 'sand', 'scree', 'shingle', 'bare_rock'))

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       AND way_area > 0.01*0::real*0::real

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v       AND building IS NULL

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v     ORDER BY CASE WHEN layer~E'^-?\\d+$' AND length(layer)<10 THEN layer::integer ELSE 0 END, way_area DESC

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   ) AS features

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v ) AS landcover_low_zoom WHERE "way" IS NOT NULL LIMIT 1;'

2018/10/23 16:09:28 render.go:35: [ERROR] Render child error: %v   encountered during parsing of layer 'landcover-low-zoom' in Layer at line 334 of '/openstreetmap-carto/stylesheet.xml'

2018/10/23 16:09:28 main.go:91: [CRITICAL] Failed to create tile server: Failed to create some renders: [Invalid read uint64: EOF Invalid read uint64: EOF]
2018/10/23 16:09:56 renderselector.go:209: [DEBUG] ping error %v dial tcp 127.0.0.1:8090: getsockopt: connection refused
2018/10/23 16:09:56 renderselector.go:117: [DEBUG] '%v' is %v localhost:8090 Offline
2018/10/23 16:10:26 renderselector.go:209: [DEBUG] ping error %v dial tcp 127.0.0.1:8090: getsockopt: connection refused
2018/10/23 16:10:26 renderselector.go:117: [DEBUG] '%v' is %v localhost:8090 Offline
^C
[jibl@pc-100 carto-proto]$ 
```

Résultat : négatif

### Essai 2 : `osm2pgsql --create --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U $POSTGRES_USER --slim -C 4096 /australia-oceania-latest.osm.pbf`

J'ai eut cette petite envie de test, parce que manifestement, `/openstreetmap-carto/openstreetmap-carto.style` est l'arguement de l'option `--style`

```bash
logs
```
Résultat: , donc je vais essayer avec une syntaxe indqiuée par la doc officielle `osm2pgsql`, et avec une surce de données PBF reconnue par le projet `osm2pgsql`. Quand je maîtriserai la syntaxe, sans me soucier de l'intégrité des données, je me mettrai à analyser les données elles-mêmes.
 


### Essai 3 : `osm2pgsql --create --database gis /australia-oceania-latest.osm.pbf`

```bash
logs
```

Résultat: ,

J'ajoute un test, qui me permettra de vérifier l'existence d'une table PostGreSQL / PostGIS :  

```bash
export POSTGRES_USER=renderer-user
export POSTGRES_PASSWD=whereischarlie
export DATABASE_NAME=gis
export TABLE_NAME=
echo "SELECT * FROM $TABLE_NAME LIMIT 5;" >> ./requete-test-sql.sql
export PGPASSWORD=$POSTGRES_PASSWD
psql -U $POSTGRES_USER -d $DATABASE_NAME < ./requete-test-sql.sql
```


### Essai 4 : `osm2pgsql -U $POSTGRES_USER --create --flat-nodes --style /openstreetmap-carto/openstreetmap-carto.style --database gis /australia-oceania-latest.osm.pbf`

```bash
logs
```

Résultat: ,

J'ajoute un test, qui me permettra de vérifier l'existence d'une table PostGreSQL / PostGIS :  

```bash
export POSTGRES_USER=renderer-user
export POSTGRES_PASSWD=whereischarlie
export DATABASE_NAME=gis
export TABLE_NAME=
echo "SELECT * FROM $TABLE_NAME LIMIT 5;" >> ./requete-test-sql.sql
export PGPASSWORD=$POSTGRES_PASSWD
psql -U $POSTGRES_USER -d $DATABASE_NAME < ./requete-test-sql.sql
```


### Essai 4bis : `osm2pgsql -U $POSTGRES_USER --create --flat-nodes --slim --drop --style /openstreetmap-carto/openstreetmap-carto.style --database gis /australia-oceania-latest.osm.pbf`

```bash
logs
```

Résultat: ,

J'ajoute un test, qui me permettra de vérifier l'existence d'une table PostGreSQL / PostGIS :  

```bash
export POSTGRES_USER=renderer-user
export POSTGRES_PASSWD=whereischarlie
export DATABASE_NAME=gis
export TABLE_NAME=
echo "SELECT * FROM $TABLE_NAME LIMIT 5;" >> ./requete-test-sql.sql
export PGPASSWORD=$POSTGRES_PASSWD
psql -U $POSTGRES_USER -d $DATABASE_NAME < ./requete-test-sql.sql
```


### Essai 5 : `osm2pgsql -U $POSTGRES_USER --create --flat-nodes --slim --drop --style /openstreetmap-carto/openstreetmap-carto.style --database gis /australia-oceania-latest.osm.pbf`

```bash
logs
```

Résultat: ,

J'ajoute un test, qui me permettra de vérifier l'existence d'une table PostGreSQL / PostGIS :  

```bash
export POSTGRES_USER=renderer-user
export POSTGRES_PASSWD=whereischarlie
export DATABASE_NAME=gis
export TABLE_NAME=
echo "SELECT * FROM $TABLE_NAME LIMIT 5;" >> ./requete-test-sql.sql
export PGPASSWORD=$POSTGRES_PASSWD
psql -U $POSTGRES_USER -d $DATABASE_NAME < ./requete-test-sql.sql
```

# Essai 6 : `osm2pgsql -U $POSTGRES_USER --create --flat-nodes --extra-attributes --slim --drop --style /openstreetmap-carto/openstreetmap-carto.style --database gis /australia-oceania-latest.osm.pbf`

 
* En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#database-options]  : 
> 
> " This should only be used on full planet imports or very large extracts (e.g. Europe) but in 
> those situations offers significant space savings and speed increases, particularly on mechanical
> drives. The file takes approximately 8 bytes * maximum node ID, or about 23 GiB, regardless of the size of the extract. "

 Je vais utiliser l'options `--flat-nodes`, parce que j'importe la terre entière, ici un fichier de 42 Go quand même...

* En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#middle-layer-options] : 
> 
> " A --slim --drop import is generally the fastest way to import the planet if updates are not required. "
> 
 Je vais utiliser aussi la combinaison d'options ` --slim --drop`
 
* En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#output-columns-options] : 
> 
> " --style specifies the location of the style file. This defines what columns are created, what tags denote #
>  areas, and what tags can be ignored. The default.style contains more documentation on this file. "
> 
 Je vais utiliser l'option : 
   ` --style /openstreetmap-carto/openstreetmap-carto.style " pour appliquer le style d'openstreemp carto`
 Remarquez que je reprends le ficheir de style provenant du git clone du repo de ce cher 'dooman84'
* En vertu de [https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md#column-options] : 
> 
> " `--extra-attributes` :  creates pseudo-tags with OSM meta-data like user, last edited, and changeset. 
>     These also need to be added to the style file. "
> 
 Je vais utiliser l'option `--extra-attributes`, le premier test retour que je ferais consistera à enlever cette option. En effet, que se passe-t-il si le fichier de stle ne comprend pas une définition du modèle de méta-données utilisateur OSM, compatible avec celui supposé dans les données importées (le fichier PBF) ?

`osm2pgsql -U $POSTGRES_USER --create --flat-nodes --extra-attributes --slim --drop --style /openstreetmap-carto/openstreetmap-carto.style --database gis /australia-oceania-latest.osm.pbf`



# TODO du mataîng

# Utilisation

### Initialisation IAAC 

```bash
export PBF_VAULT_HOME=/carto/vault
export PROVISIONING_HOME=/carto/proto 
cd /carto && sudo rm -rf $PROVISIONING_HOME 
mkdir -p $PROVISIONING_HOME 
cd $PROVISIONING_HOME 
git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . 
# copy of all big PBF' files to docker-compose mapped directory ./postgis/ 
# it is mmapped inside postgis container to PBF 's Home directory, cf. $DOWNLOADED_PBF_FILES_HOME './postgis/Dockerfile' 
# cp $PBF_VAULT_HOME/*.pbf ./postgis
chmod +x *.sh 
./download.sh 
./set-underneath-vm-overcomit-config.sh 
docker system prune -f 
docker-compose up -d --build 
docker ps -a
```
_overcommit config _

  OS' RAM Memory mamangement configuration, especially designed for Mapnik's execution (so First things first, we'll need
  Kubernetes cluster nodes labelled renderers : those nodes, and only those among K8s cluster, will have that special OS RAM 
  Memory configuration. Eventually,we will have a kickstart config plus terraform recipe for 
  provisioning those 'renderer-nodes' Il faut se faire des kickstart (puis terraform) pour provisionner des 
  VMs avec terraform, spécialement configuraes overcommit, et elles seront labelisées etiquettées 'renderer' dans mon
  cluster kubernetes. Dans mon cluster Kubernetes, d'autres nodes, seront provisionnés sans cette configuration overcommit
  de la mémoire RAM niveau hôte Docker. kubeadm à bientôt 

Commande en une seule ligne : 

```bash
export PBF_VAULT_HOME=/carto/vault && export PROVISIONING_HOME=/carto/proto && cd /carto && sudo rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . && docker-compose down --rmi all && chmod +x *.sh && ./download.sh && ./set-underneath-vm-overcomit-config.sh && docker system prune -f && docker-compose up -d --build && docker ps -a
```

retiré : `&& cp $PBF_VAULT_HOME/*.pbf ./postgis`

### IAAC

Commande idempotente en une multi-ligne (en clair) : 

```bash
docker-compose down --rmi all 
cd ..
export PBF_VAULT_HOME=/carto/vault
export PROVISIONING_HOME=/carto/proto 
cd /carto && sudo rm -rf $PROVISIONING_HOME 
mkdir -p $PROVISIONING_HOME 
cd $PROVISIONING_HOME 
git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . 
# copy of all big PBF' files to docker-compose mapped directory ./postgis/ 
# it is mmapped inside postgis container to PBF 's HOme directory, cf. $DOWNLOADED_PBF_FILES_HOME './postgis/Dockerfile' 
# cp $PBF_VAULT_HOME/*.pbf ./postgis
chmod +x *.sh 
./download.sh 
./set-underneath-vm-overcomit-config.sh 
docker system prune -f 
docker-compose up -d --build 
docker ps -a
```

Commande idempotente en une seule ligne:

```bash
docker-compose down --rmi all && cd .. && export PBF_VAULT_HOME=/carto/vault && export PROVISIONING_HOME=/carto/proto && cd  /carto && sudo rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . && docker-compose down --rmi all && chmod +x *.sh && ./download.sh && ./set-underneath-vm-overcomit-config.sh && docker system prune -f && docker-compose up -d --build && docker ps -a
```


### Source infos sympas

https://www.flocondetoile.fr/blog/switch-google-maps-leaflet-and-openstreetmap-geolocation-drupal-8
https://github.com/tilemill-project/tilemill
https://github.com/kosmtik/kosmtik  (oui c'est celui-là)
meileur https://github.com/jimmyrocks/osm-tiles-mapnik


# Dernière erreur

Je n'ai rien d'affiché sur la carte,même si j'essaie de déplacer le curseur, ou is je zoom / dé-zoom...


# Alors ça s'est marrant dans un README.md

Vous n'avez rien remarqué? Mais si regardez bien (Where is [charlie](https://shinesolutions.com/2016/12/30/generating-high-res-maps-with-mapnik-and-docker/)? Look closer at the picture. closer, you're almost there) :

* Dans le `README.md` du gars, je cite (quoting [this guy's `./README.md`](https://github.com/dooman87/melbourne-map) :

> It will take a while for a first start (up to 10 mins) because of DB import.

(Okay)

> You will know that renderer is ready to use when see logs like this:
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

Heum.. Heu hey guy, when you read `error [...] connection refused` in a software's logs (you know it's different from yuour users' shell's STDOUT, but nevermind), it acually means that there has been a problem, man, not that _everything 's okay, and the softwware is ready to use_


Maybe next week I'l end up thanking that guy for everything not working, and the only feature he was pushing forward
 [in his article (clustering an OSM rendrer)](https://shinesolutions.com/2016/12/30/generating-high-res-maps-with-mapnik-and-docker/) will turn to just bring me a prooof taht this guys was comppletely lying on that article, just to get job interviews with people who don't understand tehcniques, or selling low cost "website" to small buisness comppanies (poor them, and no, that guy wouldn't pass any interview in any company that's got a devops inside).
 Oh, sorry,it's a French stupid company (we have a big corruption problem in France, making the business, a little pointless here, and which is why I don'nt work in France) , let me give a piece of help to a yougn nice guy from France, before I get into Dad gets to repair your mess on sunday :

![Mikael Leroy (screencshot commentaire "very informative")](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/raw/master/issues-memory/michael_leroy_daddies_pof_advice.png)
 _Michael, If you want an IT job in any out of france company, please, prepare explaining what is really very informative in your former company's blog. If that was your Boss from "shine solution" who forced you posting that comment, then get ready to explain what was acutally wrong here. That repo will help you with that. And next time, tell your boss to comment with his name, not yours, or explain him it has no added value to write quick stupid things, it will end up with an article like that on github. And Mikael, next you consider accepting your namle mentiobned as author of something stupid in English, please consider as well we have an image in other countries, as French Professionals: Don't we have a duty to stand up for it? Let's not have people think that French engineers are just stupid guys that write anything you ask them to, regardless from how stupid that may be?_

 ![Mikael Leroy (screenshot commentaire "daddys' advice")](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/raw/master/issues-memory/michael_leroy_daddies_pof_advice_nopotification.png)
 
Okay, so let's just switch the oh my god part, and move on todaddys work: Getting what that guy in no way near from getting, i.e. a working renderer service with true scalability
 
### Daddy does BDD/TDD, oy!

Daddy will follow network path, just like this old bed story, "le petit poucet".
So tests, first.
* Question: is `index.html` in nginx container accessible from inside the container, via localhost?
test : 
```bash
docker exec -it carto-proto_web_1 sh -c "apk update -y && apk add net-tools curl"
docker exec -it carto-proto_web_1 sh -c "curl http://localhost/"
```
result is yes : 
```bash
[jibl@pc-100 carto-proto]$ docker exec -it carto-proto_web_1 sh -c "apk update -y && apk add net-tools curl "
apk: unrecognized option: y
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/APKINDEX.tar.gz
v3.4.6-316-g63ea6d0 [http://dl-cdn.alpinelinux.org/alpine/v3.4/main]
v3.4.6-160-g14ad2a3 [http://dl-cdn.alpinelinux.org/alpine/v3.4/community]
OK: 5987 distinct packages available
(1/6) Installing ca-certificates (20161130-r0)
(2/6) Installing libssh2 (1.7.0-r0)
(3/6) Installing libcurl (7.60.0-r1)
(4/6) Installing curl (7.60.0-r1)
(5/6) Installing mii-tool (1.60_git20140218-r0)
(6/6) Installing net-tools (1.60_git20140218-r0)
Executing busybox-1.24.2-r13.trigger
Executing ca-certificates-20161130-r0.trigger
OK: 56 MiB in 30 packages
[jibl@pc-100 carto-proto]$ docker exec -it carto-proto_web_1 sh -c "curl http://rendereurpoulet:8080/"
curl: (7) Failed to connect to rendereurpoulet port 8080: Connection refused
[jibl@pc-100 carto-proto]$ docker exec -it carto-proto_web_1 sh -c "ping rendereurpoulet"
PING rendereurpoulet (172.21.0.4): 56 data bytes
64 bytes from 172.21.0.4: seq=0 ttl=64 time=0.131 ms
64 bytes from 172.21.0.4: seq=1 ttl=64 time=0.244 ms
64 bytes from 172.21.0.4: seq=2 ttl=64 time=0.293 ms
^C
--- rendereurpoulet ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.131/0.222/0.293 ms
[jibl@pc-100 carto-proto]$ docker exec -it carto-proto_web_1 sh -c "curl http://localhost/"
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.css" />
	<script type="text/javascript" src="http://cdn.leafletjs.com/leaflet-0.7.1/leaflet.js"></script>
	<style type="text/css">
		html, body, #map {
			width: 100%;
			height: 100%;
			margin: 0 !important;
			overflow: hidden;
		}
	</style>
</head>

<body>
<div id="map"></div>
</body>

<script type="text/javascript">

	var map = L.map('map').setView([-37.8130, 144.9484], 14);
	L.tileLayer('http://localhost:8080/{z}/{x}/{y}.png', {
		attribution: 'Map data &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
</script>
</html>
[jibl@pc-100 carto-proto]$ 
```

* Question: Is `./index.html` in nginx container accessible from outside the container, via `http://$NET_HOST_NAME:80/`, where `NET_HOST_NAME` is the IP address or a domain name associated with the docker host (the machine you installed docker on, Michael) ?
test (because default listen port in nginx is 80, and given the mapped volume in `./docker-compose.yml`, for `web` service based on nginx/alpine image, we expect nginx to serve  `./index.html` on 80 : 
```bash
curl http://localhost:80/
```
result is no : 

```bash
[jibl@pc-100 carto-proto]$ curl http://localhost:80/
curl: (7) Failed connect to localhost:80; Connection refused
[jibl@pc-100 carto-proto]$ 

```

fix  : map any port number `XXXX` to port 80 inside nginx container, instead of 8888 to 8080

* Question: Is it possible to reach `renderer` container from within the `web` container ?

test : 
```bash
docker exec -it rendereurpoulet sh -c "apk update -y && apk add apt-utils net-tools curl"
docker exec -it carto-proto_web_1 sh -c "curl http://rendereurpoulet:8080/"
```

test (using a postgis client to test DAtabase connexion, not an http protocol) : 
```bash
# https://wiki.debian.org/PostgreSql

docker exec -it rendereurpoulet sh -c "apt-get update -y && apt-get install -y apt-utils net-tools curl"
docker exec -it rendereurpoulet sh -c "apt-get update -y && apt-get install -y postgresql-client"
docker exec -it rendereurpoulet sh -c "apt-get install -y postgresql-client"

# docker exec -it rendereurpoulet sh -c "curl http://carto-proto_postgis:5432/"
```
result, answer is yes : 

```bash
[jibl@pc-100 carto-proto]$ docker exec -it rendereurpoulet sh -c "apt-get update -y && apt-get install -y postgresql-client"
Ign http://archive.ubuntu.com trusty InRelease
Get:1 http://archive.ubuntu.com trusty-updates InRelease [65.9 kB]
Get:2 http://archive.ubuntu.com trusty-security InRelease [65.9 kB]
Get:3 http://archive.ubuntu.com trusty Release.gpg [933 B]
Get:4 http://archive.ubuntu.com trusty Release [58.5 kB]
Get:5 http://archive.ubuntu.com trusty-updates/main Sources [524 kB]
Get:6 http://archive.ubuntu.com trusty-updates/restricted Sources [6449 B]
Get:7 http://archive.ubuntu.com trusty-updates/universe Sources [268 kB]
Get:8 http://archive.ubuntu.com trusty-updates/main amd64 Packages [1387 kB]
Get:9 http://archive.ubuntu.com trusty-updates/restricted amd64 Packages [21.4 kB]
Get:10 http://archive.ubuntu.com trusty-updates/universe amd64 Packages [634 kB]
Get:11 http://archive.ubuntu.com trusty-security/main Sources [212 kB]
Get:12 http://archive.ubuntu.com trusty-security/restricted Sources [5050 B]
Get:13 http://archive.ubuntu.com trusty-security/universe Sources [104 kB]
Get:14 http://archive.ubuntu.com trusty-security/main amd64 Packages [967 kB]
Get:15 http://archive.ubuntu.com trusty-security/restricted amd64 Packages [18.1 kB]
Get:16 http://archive.ubuntu.com trusty-security/universe amd64 Packages [338 kB]
Get:17 http://archive.ubuntu.com trusty/main Sources [1335 kB]
Get:18 http://archive.ubuntu.com trusty/restricted Sources [5335 B]
Get:19 http://archive.ubuntu.com trusty/universe Sources [7926 kB]
Get:20 http://archive.ubuntu.com trusty/main amd64 Packages [1743 kB]
Get:21 http://archive.ubuntu.com trusty/restricted amd64 Packages [16.0 kB]
Get:22 http://archive.ubuntu.com trusty/universe amd64 Packages [7589 kB]
Fetched 23.3 MB in 5s (4187 kB/s)                        
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  libpq-dev libpq5 postgresql-client-9.3 postgresql-client-common
Suggested packages:
  postgresql-doc-9.3 postgresql-9.3
The following NEW packages will be installed:
  postgresql-client postgresql-client-9.3 postgresql-client-common
The following packages will be upgraded:
  libpq-dev libpq5
2 upgraded, 3 newly installed, 0 to remove and 174 not upgraded.
Need to get 1047 kB of archives.
After this operation, 3224 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu/ trusty-updates/main libpq-dev amd64 9.3.24-0ubuntu0.14.04 [140 kB]
Get:2 http://archive.ubuntu.com/ubuntu/ trusty-updates/main libpq5 amd64 9.3.24-0ubuntu0.14.04 [78.5 kB]
Get:3 http://archive.ubuntu.com/ubuntu/ trusty-updates/main postgresql-client-common all 154ubuntu1.1 [25.4 kB]
Get:4 http://archive.ubuntu.com/ubuntu/ trusty-updates/main postgresql-client-9.3 amd64 9.3.24-0ubuntu0.14.04 [797 kB]
Get:5 http://archive.ubuntu.com/ubuntu/ trusty-updates/main postgresql-client all 9.3+154ubuntu1.1 [5048 B]
Fetched 1047 kB in 0s (7013 kB/s)            
(Reading database ... 40968 files and directories currently installed.)
Preparing to unpack .../libpq-dev_9.3.24-0ubuntu0.14.04_amd64.deb ...
Unpacking libpq-dev (9.3.24-0ubuntu0.14.04) over (9.3.15-0ubuntu0.14.04) ...
Preparing to unpack .../libpq5_9.3.24-0ubuntu0.14.04_amd64.deb ...
Unpacking libpq5 (9.3.24-0ubuntu0.14.04) over (9.3.15-0ubuntu0.14.04) ...
Selecting previously unselected package postgresql-client-common.
Preparing to unpack .../postgresql-client-common_154ubuntu1.1_all.deb ...
Unpacking postgresql-client-common (154ubuntu1.1) ...
Selecting previously unselected package postgresql-client-9.3.
Preparing to unpack .../postgresql-client-9.3_9.3.24-0ubuntu0.14.04_amd64.deb ...
Unpacking postgresql-client-9.3 (9.3.24-0ubuntu0.14.04) ...
Selecting previously unselected package postgresql-client.
Preparing to unpack .../postgresql-client_9.3+154ubuntu1.1_all.deb ...
Unpacking postgresql-client (9.3+154ubuntu1.1) ...
Setting up libpq5 (9.3.24-0ubuntu0.14.04) ...
Setting up libpq-dev (9.3.24-0ubuntu0.14.04) ...
Setting up postgresql-client-common (154ubuntu1.1) ...
Setting up postgresql-client-9.3 (9.3.24-0ubuntu0.14.04) ...
update-alternatives: using /usr/share/postgresql/9.3/man/man1/psql.1.gz to provide /usr/share/man/man1/psql.1.gz (psql.1.gz) in auto mode
Setting up postgresql-client (9.3+154ubuntu1.1) ...
Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
[jibl@pc-100 carto-proto]$ docker exec -it rendereurpoulet sh -c "psql -h postgis -p 5432"
psql: FATAL:  role "root" does not exist
[jibl@pc-100 carto-proto]$ docker exec -it rendereurpoulet sh -c "psql -u postgis -h postgis -p 5432"
/usr/lib/postgresql/9.3/bin/psql: invalid option -- 'u'
Try "psql --help" for more information.
[jibl@pc-100 carto-proto]$ docker exec -it rendereurpoulet sh -c "psql -U postgis -h postgis -p 5432"
psql: FATAL:  role "postgis" does not exist
[jibl@pc-100 carto-proto]$ 
```
Indeed, `FATAL:  role "postgis" does not exist` means postgresql DID answer: a NO answer, IS, an answer (aka I don't know what's the valid user in use by renderer, and I don't care about that question, I care about renderer being able to talk to postgis).
SO you can reach postgis container from renderer container.

But Daddy always cares (cf. `./docker-compose.yml` , see ` - POSTGRES_DB=gis` + `postgis/initdb-postgis.sh` , see `# Perform all actions as $POSTGRES_USER`) : 
test
```bash
export POSTGRES_USER=???but... wait ....daddy's thinking... No???!!! t
docker exec -it rendereurpoulet sh -c "psql -U $POSTGRES_USER -h postgis -p 5432"
```
result : 
Daddy checked all files, and it appears that postgis image is based on [this base docker image](https://hub.docker.com/r/mdillon/postgis/).

Okay daddy, but wtf ..? Well Boy, as [mentionned in its docuemntation](), this base image expects you to set an environment variable, namely `POSTGRES_USER`, when you run a container instance. And the valeu you set, will be the name of the postgis user the `osm2pgsql` executable is gonna use (cf. your own coment in `postgis/initdb-postgis.sh` : `# Perform all actions as $POSTGRES_USER`).

And guess what? there's no `POSTGRES_USER` mention in the `./docker-compose.yml`.
Okay go fix that, dad.
K done, so now test is (successful) :

```bahs
[jibl@pc-100 carto-proto]$ docker exec -it rendereurpoulet sh -c "psql -d gis -U renderer-user -h postgis -p 5432"
psql (9.3.24, server 9.5.14)
WARNING: psql major version 9.3, server major version 9.5.
         Some psql features might not work.
Type "help" for help.

gis=# 

```



* Question : What does the well konwn `pg_isready` say, on its behalf?
test
test : 
```bash
# docker exec -it postgis sh -c "apk update -y && apk add apt-utils net-tools curl"
docker exec -it postgis sh -c "pg_isready"
```
result (everything 's fine) : 
```bash
[jibl@pc-100 carto-proto]$ docker exec -it postgis sh -c "pg_isready"
/var/run/postgresql:5432 - accepting connections
[jibl@pc-100 carto-proto]$ 

```


**Alright, now daddy has a better overview**
* A, everything is up n running on the software level (all apps up n running)
* B, network is end-toend tested, and everything just neat
* C, now that Daddy thinks about it, Daddy remembers he tried to compute Australia all night long with mom threatening to throw alienware out, and Daddy found there has been a [problem during Australia's *.PBF files processing](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/issues/3) : could it be that, which explains why Daddy has no tiles displaying on his leaflet map?

So daddy is going to spin up an import / process cycle automation, which he will then, be able to TDD / BDD test :
Daddy knows how to test a sofware, so If Daddys boss ask Daddy to test something, Daddy turns that thing into a software, (infrastructure as code), and suddenly boum, daddy can test the thing for boss with all those good old and well-sharped testing methods and tools.

We're almost there, my young apprentice. Be patient. Do not under-assess the power of the force in universe : 

Okay, Australia is big, but lets try the import again ?

```bash
export DADDYS_HOME=daddys-pbf-imports-tests
mkdir $DADDYS_HOME
cd $DADDYS_HOME
wget https://s3.amazonaws.com/metro-extracts.mapzen.com/melbourne_australia.osm.pbf

```



# Le filesystem de l'instance OS dans laquelle tourne Mapnik 

Selon [cette source officielle Redhat](https://access.redhat.com/articles/3129891) : 

> The XFS File System
> 
> XFS is a robust and mature 64-bit journaling file system that supports very large files and file systems on a single host. It is the default file system in Red Hat Enterprise Linux 7. Journaling ensures file system integrity after system crashes (for example, due to power outages) by keeping a record of file system operations that can be replayed when the system is restarted and the file system remounted. XFS was originally developed in the early 1990s by SGI and has a long history of running on extremely large servers and storage arrays. XFS supports a wealth of features including the following:
> 
>     Delayed allocation
>     Dynamically allocated inodes
>     B-tree indexing for scalability of free space management
>     Ability to support a large number of concurrent operations
>     Extensive run-time metadata consistency checking
>     Sophisticated metadata read-ahead algorithms
>     Tightly integrated backup and restore utilities
>     Online defragmentation
>     Online filesystem growing
>     Comprehensive diagnostics capabilities
>     Scalable and fast repair utilities
>     Optimizations for streaming video workloads
> 
> While XFS scales to exabytes, Red Hat’s maximum supported XFS file system image is 100TB for Red Hat Enterprise Linux 5, 300TB for Red Hat Enterprise Linux 6, and 500TB for Red Hat Enterprise Linux 7. Given its long history in environments that require high performance and scalability, it is not surprising that XFS is routinely measured as one of the highest performing file systems on large systems with enterprise workloads. For instance, a large system would be one with a relatively high number of CPUs, multiple HBAs, and connections to external disk arrays. XFS also performs well on smaller systems that have a multi-threaded, parallel I/O workload. XFS has a relatively poor performance for single threaded, metadata-intensive workloads, for example, a workload that creates or deletes large numbers of small files in a single thread.
> 
> For detailed information about the size limits of filesystem, files, and directories, see the File systems and storage section of the Red Hat Enterprise Linux technology capabilities and limits article.

RHEL 6 => CentOS 7 (upstream project)

Donc théoriquement, 'jai une limite de 300 Tera Bytes de disuque dur, par instance CentOS 7

Mais :

> XFS has a relatively poor performance for single threaded, metadata-intensive workloads, for example, a workload that creates or deletes large numbers of small files in a single thread
 Alors, es-ce que Mapnik exécute des threads qui "crééent ou détruisent beaucoup de petits fichiers, ayant de grosse charges de méta-données?"
  Séparons la question en trois : 
  * es-ce que Mapnik exécute des threads qui "crééent beaucoup de petits fichiers, ayant de grosse charges de méta-données?"
  * es-ce que Mapnik exécute des threads qui "détruisent beaucoup de petits fichiers, ayant de grosse charges de méta-données?"
  * es-ce que Mapnik exécute des threads qui _à la fois_ "crééent et détruisent beaucoup de petits fichiers, ayant de grosse charges de méta-données?"
 
 Les réponses à ces questions seront consolidées : 
 
 * par des tests sur le présent prototype
 * revues des documentations Mapnik
 * revue des sources d'information non-officielles (repos github, et autres publications)
 
 
 



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
