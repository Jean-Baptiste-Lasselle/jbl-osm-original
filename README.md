
![I love you  I miss you V.](https://www.youtube.com/watch?v=god7hAPv8f0)

# TODO du mataîng

selon la doc d'openstreetmap, je dois exécuter aussi (le le gars n'as pas reporté cela dans son `./renderer/Dockerfile`) : 

```bash
./get-shapefiles.sh
```

Automatisation de la récupération du fichier `project.yaml` du projet OSM git cloné dans le conteneur renderer : 

```bash
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ # mkdir -p renderer-of-osm/ && scp jibl@production-docker-host-1.kytes.io:/home/jibl/carto-proto/renderer/project.yaml 
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ mkdir -p renderer-of-osm/ && scp jibl@production-docker-host-1.kytes.io:/home/jibl/carto-proto/renderer/project.yaml 
usage: scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
           [-l limit] [-o ssh_option] [-P port] [-S program]
           [[user@]host1:]file1 ... [[user@]host2:]file2
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ mkdir -p renderer-of-osm/ && scp jibl@production-docker-host-1.kytes.io:/home/jibl/carto-proto/renderer/project.yaml  .
jibl@production-docker-host-1.kytes.io's password: 
project.yaml                                                                                                                                                100%  107KB  23.0MB/s   00:00    
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ ls -all
total 44727644
drwxr-xr-x  4 jibl jibl        4096 Oct 22 13:56 .
drwxr-xr-x 41 jibl jibl        4096 Oct 22 11:55 ..
-rw-r--r--  1 jibl jibl     1376256 Oct 22 12:01 australia-oceania-latest.osm.bz2
-rw-r--r--  1 jibl jibl   633086720 Oct 22 00:08 australia-oceania-latest.osm.pbf
drwxr-xr-x  5 jibl jibl        4096 Oct 22 11:56 openstreetmap-carto
-rw-r--r--  1 jibl jibl 45166498303 Oct 18 04:06 planet-latest.osm.pbf
-rw-r--r--  1 jibl jibl      109892 Oct 22 13:56 project.yaml
drwxr-xr-x  2 jibl jibl        4096 Oct 22 13:56 renderer-of-osm
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ mv project.yaml ./renderer-of-osm/
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ # ssh jibl@production-docker-host-1.kytes.io < copier-fichier-du-conteneur-vers-dockhost.sh
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ vi ./copier-fichier-du-conteneur-vers-dockhost.sh
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ cat ./copier-fichier-du-conteneur-vers-dockhost.sh 
#!/bin/bash
docker cp rendereurpoulet:/openstreetmap-carto/project.yaml ./renderer/
jibl@pc-alienware-jib:~/OSM_mes_pretelechargements$ 

```

# Utilisation

```bash
export PBF_VAULT_HOME=$(pwd)/carto-vault
export PROVISIONING_HOME=$HOME/carto-proto 
cd $HOME && sudo rm -rf $PROVISIONING_HOME 
mkdir -p $PROVISIONING_HOME 
cd $PROVISIONING_HOME 
git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . 
# copy of all big PBF' files to docker-compose mapped directory ./postgis/ 
# it is mmapped inside postgis container to PBF 's HOme directory, cf. $DOWNLOADED_PBF_FILES_HOME './postgis/Dockerfile' 
cp $PBF_VAULT_HOME/*.pbf ./postgis
chmod +x *.sh 
./download.sh 
./set-underneath-vm-overcomit-config.sh 
docker system prune -f 
docker-compose up -d --build 
docker ps -a
```


Commande idempotente en une seule ligne:

```bash
export PBF_VAULT_HOME=$(pwd)/carto-vault && export PROVISIONING_HOME=$HOME/carto-proto && cd $HOME && sudo rm -rf $PROVISIONING_HOME && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original" . && cp $PBF_VAULT_HOME/*.pbf ./renderer && docker-compose down --rmi all && chmod +x *.sh && ./download.sh && ./set-underneath-vm-overcomit-config.sh && docker system prune -f && docker-compose up -d --build && docker ps -a
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
