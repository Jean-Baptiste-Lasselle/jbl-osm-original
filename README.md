
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
 _Michael, If you want an IT job in any out of france company, please, prepare explaining what is really very informative your former company's blog. If that was your Boss from "shine solution" who forced you posting that comment, then get ready to explain what was acutally wrong here . That repo will help you with that. And next timpe, tell your boss to comment with his name, not yours. And Mikael, next you write something stupid in English, about IT, please consider we have an image in other countries, as French Professionals, and wer have duty to stand up for it. Let's not have people think that French engineers are just stupid guys that write anything you ask them to, however stuopid that maybe, okay?_

 ![Mikael Leroy (screenshot commentaire "daddys' advice")](https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original/raw/master/issues-memory/michael_leroy_daddies_pof_advice_nopotification.png)
 
Okay, so let's just switch the oh my god part, and move on todaddys work: Getting what that guy in no way near from getting, i.e. a working renderer service with true scalability
 
### Daddy does BDD/TDDD

Daddy will follow network path, just like this old bed story, "le petit poucet".
So tests, first.
* Question: is `index.html` in nginx container accessible from inside the container, via localhost?
test : 
```bash
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

* Question: is `index.html` in nginx container accessible from outside the container, via `http://$NET_HOST_NAME:80/`, where `NET_HOST_NAME`is the IP address or a domain name associated with the docker host (the machine you installed docker on, Michael) ?
test : 
```bash
docker exec -it carto-proto_web_1 sh -c "curl http://localhost/"
```
result is no : 
```bash
# 
```

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
