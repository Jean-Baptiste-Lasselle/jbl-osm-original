# TODO du mataîng

```bash
[jibl@pc-100 carto-proto]$ docker ps -a
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS                   PORTS                                                                          NAMES
54e70ebd507f        carto-proto_renderer                  "/bin/sh -c /entrypo…"   5 minutes ago       Up 5 minutes             0.0.0.0:8080->8080/tcp, 0.0.0.0:9090->9090/tcp                                 carto-proto_renderer_1
129238ac7339        carto-proto_postgis                   "docker-entrypoint.s…"   5 minutes ago       Up 5 minutes             5432/tcp                                                                       carto-proto_postgis_1
c865a16da75a        nginx:1.11-alpine                     "nginx -g 'daemon of…"   5 minutes ago       Up 5 minutes             443/tcp, 0.0.0.0:8888->80/tcp                                                  carto-proto_web_1
[jibl@pc-100 carto-proto]$ more web/index.html 
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
		attribution: 'Map data &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licens
es/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
</script>
</html>
[jibl@pc-100 carto-proto]$ 

```


And that, below, is leaflet code that i know of: (ah ben voilà, quoi)

```javascript
	var map = L.map('map').setView([-37.8130, 144.9484], 14);
	L.tileLayer('http://localhost:8080/{z}/{x}/{y}.png', {
		attribution: 'Map data &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licens
es/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
```
Funny, itlopoks like people working on geoloc with no money happen to know nothing about docker :
A `localhost` mention inside a file inside a mapped docker-compose volume ... 

Interesting...

Let's just say the person work his test on his local laptop, everything localhost, with no docker at all, and then either got asked, or realizing docker is trendy and good word for google referecing, suddenly copy-pasted his code in a dockerfile, after having worked on a 1-day udemy docker tutorial.

Let's see if the guy reacts ;)
(if so, I'lll explain hil for free Ansible Jinja 2 templating, promised ;) )

Ok [let's fix that ](https://github.com/Jean-Baptiste-Lasselle/jbl-osm3)


![I love you  I miss you V.](https://www.youtube.com/watch?v=god7hAPv8f0)


# Utilisation

```bash
export PROVISIONING_HOME=$HOME/carto-proto
cd $HOME
sudo rm -rf $PROVISIONING_HOME
mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
docker-compose down --rmi all 
sudo rm -rf ./data 
sudo rm -rf ./renderer/shapes/ 
chmod +x *.sh 
./download.sh 
docker system prune -f 
docker-compose up -d --build && docker ps -a
```


Commande idempotente en une seule ligne:

```bash
export PROVISIONING_HOME=$HOME/carto-proto && cd $HOME && sudo rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . && docker-compose down --rmi all && sudo rm -rf ./data && sudo rm -rf ./renderer/shapes/ && chmod +x *.sh && ./download.sh && docker system prune -f && docker-compose up -d --build && docker ps -a
```

### Tout détruire 

```bash
sudo rm -rf ./data && sudo rm -rf ./renderer/shapes/  && docker-compose down --rmi all && docker system prune -f
```
### Source infos sympas

https://www.flocondetoile.fr/blog/switch-google-maps-leaflet-and-openstreetmap-geolocation-drupal-8
https://github.com/tilemill-project/tilemill
https://github.com/kosmtik/kosmtik  (oui c'est celui-là)
meileur https://github.com/jimmyrocks/osm-tiles-mapnik
# Dernière erreur

Je n'ai rien d'affiché sur la carte,même si j'essaie de déplacer le curseur, ou is je zoom / dé-zoom...

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
