# Dernière erreur :

```bash
[jibl@pc-100 proto]$ docker logs -f postgis
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
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

Success. You can now start the database server using:


WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
    pg_ctl -D /var/lib/postgresql/data -l logfile start

waiting for server to start....2018-10-27 06:45:24.442 UTC [43] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2018-10-27 06:45:24.483 UTC [44] LOG:  database system was shut down at 2018-10-27 06:45:23 UTC
2018-10-27 06:45:24.489 UTC [43] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/create-app-db-with-postgis-extensions.sh
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh COMMENCE !!!       
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_USER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_DB=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_PASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGUSER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGDATABASE=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [PGHOST=localhost]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPORT=]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_NAME=bddgeoloc]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_NAME=renderer_user]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_PWD=whereischarlie]
 ------------------------------------------------- 
# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ 
Okay, now we run the postgres-specific commands, that trigger postgis extensions installations
Note : we'lldo that (creating the "bddgeoloc" database),  with the first created, surper admin user : "dba_user"
Nevertheless, still logged in PostGreSQL as [dba_user], we will the create the APP's database management user, namely [], and  
the developer will use that user, to operate the bddgeoloc database from his code 
 So, first let(s create the database as a regular PostGresQL database, then we'll extend it to be a plain PostGIS database 
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
psql: could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Network is unreachable
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh TERMINE !!!        
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 

waiting for server to shut down....2018-10-27 06:45:26.227 UTC [43] LOG:  received fast shutdown request
2018-10-27 06:45:26.231 UTC [43] LOG:  aborting any active transactions
2018-10-27 06:45:26.244 UTC [43] LOG:  worker process: logical replication launcher (PID 50) exited with exit code 1
2018-10-27 06:45:26.254 UTC [45] LOG:  shutting down
2018-10-27 06:45:26.416 UTC [43] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2018-10-27 06:45:26.452 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2018-10-27 06:45:26.452 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2018-10-27 06:45:26.471 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2018-10-27 06:45:26.636 UTC [110] LOG:  database system was shut down at 2018-10-27 06:45:26 UTC
2018-10-27 06:45:26.653 UTC [1] LOG:  database system is ready to accept connections
^C
[jibl@pc-100 proto]$ docker exec -it postgis "ping -c 4 localhost"
OCI runtime exec failed: exec failed: container_linux.go:348: starting container process caused "exec: \"ping -c 4 localhost\": executable file not found in $PATH": unknown
[jibl@pc-100 proto]$ docker exec -it postgis sh -c ping -c 4 localhost""
-c: 1: -c: ping: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ping -c 4 localhost"
sh: 1: ping: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ping -c 4 localhost"
sh: 1: ping: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "apt-get install -y net-tools
> ^C
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "apt-get install -y net-tools"
Reading package lists... Done
Building dependency tree       
Reading state information... Done
net-tools is already the newest version (1.60+git20161116.90da8a0-1).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "apt-get install -y net-utils"
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package net-utils
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "apt-get install -y ping"
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package ping
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ping -c 4 localhost"
sh: 1: ping: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "tenet"
sh: 1: tenet: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "telnet"
sh: 1: telnet: not found
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "psql -U dba_user --dbname=postgres -W"Password for user dba_user: 
psql (10.5 (Debian 10.5-2.pgdg90+1))
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 dba_user  | dba_user | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | dba_user | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | dba_user | UTF8     | en_US.utf8 | en_US.utf8 | =c/dba_user          +
           |          |          |            |            | dba_user=CTc/dba_user
 template1 | dba_user | UTF8     | en_US.utf8 | en_US.utf8 | =c/dba_user          +
           |          |          |            |            | dba_user=CTc/dba_user
(4 rows)

postgres=# 
```

précédente : 
```bash
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "/docker-entrypoint-initdb.d/create-app-db-with-postgis-extensions.sh"
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh COMMENCE !!!       
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_USER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_DB=]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_PASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGUSER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGDATABASE=]
 ------------------------------------------------- 
   VERIFICATIONS : [PGHOST=localhost]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPORT=]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_NAME=bddgeoloc]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_NAME=renderer_user]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_PWD=whereischarlie]
 ------------------------------------------------- 
# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ 
Okay, now we run the postgres-specific commands, that trigger postgis extensions installations
Note : we'lldo that (creating the "bddgeoloc" database),  with the first created, surper admin user : "dba_user"
Nevertheless, still logged in PostGreSQL as [dba_user], we will the create the APP's database management user, namely [], and  
the developer will use that user, to operate the bddgeoloc database from his code 
 So, first let(s create the database as a regular PostGresQL database, then we'll extend it to be a plain PostGIS database 
ERROR:  role "renderer_user" already exists
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis.control": No such file or directory
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_topology.control": No such file or directory
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_sfcgal.control": No such file or directory
CREATE EXTENSION
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_tiger_geocoder.control": No such file or directory
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh TERMINE !!!        
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
[jibl@pc-100 proto]$ 

```
J'ai cherché, et pense avoir trouvé quelque chose :
*  D'abord, le message d'erreur à l'exécution de mon script inséré dans le entrypoint postgres, précise que quelqeues fichiers son tattendus, et n'existent pas.
*  Ensuite, j'ai vérifié l'existence de ces fichiers dans mon contneur, et effectivement, ils manquent à l'appel : 

```bash
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "/docker-entrypoint-initdb.d/create-app-db-with-postgis-extensions.sh"
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh COMMENCE !!!       
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_USER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_DB=]
 ------------------------------------------------- 
   VERIFICATIONS : [POSTGRES_PASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGUSER=dba_user]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPASSWORD=firstcutisthedeppest]
 ------------------------------------------------- 
   VERIFICATIONS : [PGDATABASE=]
 ------------------------------------------------- 
   VERIFICATIONS : [PGHOST=localhost]
 ------------------------------------------------- 
   VERIFICATIONS : [PGPORT=]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_NAME=bddgeoloc]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_NAME=renderer_user]
 ------------------------------------------------- 
   VERIFICATIONS : [APP_DB_USER_PWD=whereischarlie]
 ------------------------------------------------- 
# - dependency management : installing PostGIS 2.5.x, which requires PostGres 9.4 or higher, see : http://postgis.net/docs/manual-2.5/ 
Okay, now we run the postgres-specific commands, that trigger postgis extensions installations
Note : we'lldo that (creating the "bddgeoloc" database),  with the first created, surper admin user : "dba_user"
Nevertheless, still logged in PostGreSQL as [dba_user], we will the create the APP's database management user, namely [], and  
the developer will use that user, to operate the bddgeoloc database from his code 
 So, first let(s create the database as a regular PostGresQL database, then we'll extend it to be a plain PostGIS database 
ERROR:  role "renderer_user" already exists
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis.control": No such file or directory
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_topology.control": No such file or directory
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_sfcgal.control": No such file or directory
CREATE EXTENSION
ERROR:  could not open extension control file "/usr/share/postgresql/9.5/extension/postgis_tiger_geocoder.control": No such file or directory
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
 ----+|+--------++|--------|++--------+|+--------++|--------|++--------+|+---- 
        JBL SCRIPT create-app-db-with-postgis-extensions.sh TERMINE !!!        
 ----++|--------+|+--------|++--------++|--------+|+--------|++--------+|+---- 
 ----+|+--------+|+--------+|+--------+|+--------+|+--------+|+--------+|+---- 
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ls -allh /usr/share/postgresql/9.35extension/"
ls: cannot access '/usr/share/postgresql/9.35extension/': No such file or directory
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ls -allh /usr/share/postgresql/9.5/extension/"
total 880K
drwxr-xr-x. 2 root root 8.0K Oct 16 05:07 .
drwxr-xr-x. 1 root root   36 Oct 16 05:07 ..
-rw-r--r--. 1 root root 1.5K Aug  7 11:50 adminpack--1.0.sql
-rw-r--r--. 1 root root  176 Aug  7 11:50 adminpack.control
-rw-r--r--. 1 root root  249 Aug  7 11:50 autoinc--1.0.sql
-rw-r--r--. 1 root root  149 Aug  7 11:50 autoinc.control
-rw-r--r--. 1 root root  250 Aug  7 11:50 autoinc--unpackaged--1.0.sql
-rw-r--r--. 1 root root  25K Aug  7 11:50 btree_gin--1.0.sql
-rw-r--r--. 1 root root  160 Aug  7 11:50 btree_gin.control
-rw-r--r--. 1 root root 9.9K Aug  7 11:50 btree_gin--unpackaged--1.0.sql
-rw-r--r--. 1 root root 3.7K Aug  7 11:50 btree_gist--1.0--1.1.sql
-rw-r--r--. 1 root root  40K Aug  7 11:50 btree_gist--1.1.sql
-rw-r--r--. 1 root root  163 Aug  7 11:50 btree_gist.control
-rw-r--r--. 1 root root  21K Aug  7 11:50 btree_gist--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.4K Aug  7 11:50 chkpass--1.0.sql
-rw-r--r--. 1 root root  150 Aug  7 11:50 chkpass.control
-rw-r--r--. 1 root root  635 Aug  7 11:50 chkpass--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.1K Aug  7 11:50 citext--1.0--1.1.sql
-rw-r--r--. 1 root root  13K Aug  7 11:50 citext--1.1.sql
-rw-r--r--. 1 root root  158 Aug  7 11:50 citext.control
-rw-r--r--. 1 root root 9.6K Aug  7 11:50 citext--unpackaged--1.0.sql
-rw-r--r--. 1 root root 7.7K Aug  7 11:50 cube--1.0.sql
-rw-r--r--. 1 root root  142 Aug  7 11:50 cube.control
-rw-r--r--. 1 root root 3.2K Aug  7 11:50 cube--unpackaged--1.0.sql
-rw-r--r--. 1 root root  419 Aug  7 11:50 dblink--1.0--1.1.sql
-rw-r--r--. 1 root root 5.7K Aug  7 11:50 dblink--1.1.sql
-rw-r--r--. 1 root root  170 Aug  7 11:50 dblink.control
-rw-r--r--. 1 root root 2.8K Aug  7 11:50 dblink--unpackaged--1.0.sql
-rw-r--r--. 1 root root  711 Aug  7 11:50 dict_int--1.0.sql
-rw-r--r--. 1 root root  158 Aug  7 11:50 dict_int.control
-rw-r--r--. 1 root root  493 Aug  7 11:50 dict_int--unpackaged--1.0.sql
-rw-r--r--. 1 root root  694 Aug  7 11:50 dict_xsyn--1.0.sql
-rw-r--r--. 1 root root  179 Aug  7 11:50 dict_xsyn.control
-rw-r--r--. 1 root root  488 Aug  7 11:50 dict_xsyn--unpackaged--1.0.sql
-rw-r--r--. 1 root root 3.1K Aug  7 11:50 earthdistance--1.0.sql
-rw-r--r--. 1 root root  202 Aug  7 11:50 earthdistance.control
-rw-r--r--. 1 root root  959 Aug  7 11:50 earthdistance--unpackaged--1.0.sql
-rw-r--r--. 1 root root  475 Aug  7 11:50 file_fdw--1.0.sql
-rw-r--r--. 1 root root  155 Aug  7 11:50 file_fdw.control
-rw-r--r--. 1 root root 1.5K Aug  7 11:50 fuzzystrmatch--1.0.sql
-rw-r--r--. 1 root root  175 Aug  7 11:50 fuzzystrmatch.control
-rw-r--r--. 1 root root 1.1K Aug  7 11:50 fuzzystrmatch--unpackaged--1.0.sql
-rw-r--r--. 1 root root  279 Aug  7 11:50 hstore--1.0--1.1.sql
-rw-r--r--. 1 root root 1.2K Aug  7 11:50 hstore--1.1--1.2.sql
-rw-r--r--. 1 root root  525 Aug  7 11:50 hstore--1.2--1.3.sql
-rw-r--r--. 1 root root  13K Aug  7 11:50 hstore--1.3.sql
-rw-r--r--. 1 root root  158 Aug  7 11:50 hstore.control
-rw-r--r--. 1 root root 5.4K Aug  7 11:50 hstore--unpackaged--1.0.sql
-rw-r--r--. 1 root root  273 Aug  7 11:50 insert_username--1.0.sql
-rw-r--r--. 1 root root  170 Aug  7 11:50 insert_username.control
-rw-r--r--. 1 root root  282 Aug  7 11:50 insert_username--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.1K Aug  7 11:50 intagg--1.0.sql
-rw-r--r--. 1 root root  119 Aug  7 11:50 intagg.control
-rw-r--r--. 1 root root  468 Aug  7 11:50 intagg--unpackaged--1.0.sql
-rw-r--r--. 1 root root  11K Aug  7 11:50 intarray--1.0.sql
-rw-r--r--. 1 root root  176 Aug  7 11:50 intarray.control
-rw-r--r--. 1 root root 6.7K Aug  7 11:50 intarray--unpackaged--1.0.sql
-rw-r--r--. 1 root root  65K Aug  7 11:50 isn--1.0.sql
-rw-r--r--. 1 root root  160 Aug  7 11:50 isn.control
-rw-r--r--. 1 root root  24K Aug  7 11:50 isn--unpackaged--1.0.sql
-rw-r--r--. 1 root root  708 Aug  7 11:50 lo--1.0.sql
-rw-r--r--. 1 root root  126 Aug  7 11:50 lo.control
-rw-r--r--. 1 root root  314 Aug  7 11:50 lo--unpackaged--1.0.sql
-rw-r--r--. 1 root root  18K Aug  7 11:50 ltree--1.0.sql
-rw-r--r--. 1 root root  155 Aug  7 11:50 ltree.control
-rw-r--r--. 1 root root 7.9K Aug  7 11:50 ltree--unpackaged--1.0.sql
-rw-r--r--. 1 root root  261 Aug  7 11:50 moddatetime--1.0.sql
-rw-r--r--. 1 root root  165 Aug  7 11:50 moddatetime.control
-rw-r--r--. 1 root root  266 Aug  7 11:50 moddatetime--unpackaged--1.0.sql
-rw-r--r--. 1 root root  560 Aug  7 11:50 pageinspect--1.0--1.1.sql
-rw-r--r--. 1 root root  562 Aug  7 11:50 pageinspect--1.1--1.2.sql
-rw-r--r--. 1 root root 2.0K Aug  7 11:50 pageinspect--1.2--1.3.sql
-rw-r--r--. 1 root root 4.1K Aug  7 11:50 pageinspect--1.3.sql
-rw-r--r--. 1 root root  173 Aug  7 11:50 pageinspect.control
-rw-r--r--. 1 root root 1.1K Aug  7 11:50 pageinspect--unpackaged--1.0.sql
-rw-r--r--. 1 root root  508 Aug  7 11:50 pg_buffercache--1.0--1.1.sql
-rw-r--r--. 1 root root  780 Aug  7 11:50 pg_buffercache--1.1.sql
-rw-r--r--. 1 root root  157 Aug  7 11:50 pg_buffercache.control
-rw-r--r--. 1 root root  351 Aug  7 11:50 pg_buffercache--unpackaged--1.0.sql
-rw-r--r--. 1 root root  307 Aug  7 11:50 pgcrypto--1.0--1.1.sql
-rw-r--r--. 1 root root  483 Aug  7 11:50 pgcrypto--1.1--1.2.sql
-rw-r--r--. 1 root root 5.1K Aug  7 11:50 pgcrypto--1.2.sql
-rw-r--r--. 1 root root  137 Aug  7 11:50 pgcrypto.control
-rw-r--r--. 1 root root 2.4K Aug  7 11:50 pgcrypto--unpackaged--1.0.sql
-rw-r--r--. 1 root root  871 Aug  7 11:50 pg_freespacemap--1.0.sql
-rw-r--r--. 1 root root  160 Aug  7 11:50 pg_freespacemap.control
-rw-r--r--. 1 root root  375 Aug  7 11:50 pg_freespacemap--unpackaged--1.0.sql
-rw-r--r--. 1 root root  461 Aug  7 11:50 pg_prewarm--1.0.sql
-rw-r--r--. 1 root root  139 Aug  7 11:50 pg_prewarm.control
-rw-r--r--. 1 root root  651 Aug  7 11:50 pgrowlocks--1.0--1.1.sql
-rw-r--r--. 1 root root  541 Aug  7 11:50 pgrowlocks--1.1.sql
-rw-r--r--. 1 root root  152 Aug  7 11:50 pgrowlocks.control
-rw-r--r--. 1 root root  273 Aug  7 11:50 pgrowlocks--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.3K Aug  7 11:50 pg_stat_statements--1.0--1.1.sql
-rw-r--r--. 1 root root 1.4K Aug  7 11:50 pg_stat_statements--1.1--1.2.sql
-rw-r--r--. 1 root root 1.5K Aug  7 11:50 pg_stat_statements--1.2--1.3.sql
-rw-r--r--. 1 root root 1.4K Aug  7 11:50 pg_stat_statements--1.3.sql
-rw-r--r--. 1 root root  191 Aug  7 11:50 pg_stat_statements.control
-rw-r--r--. 1 root root  449 Aug  7 11:50 pg_stat_statements--unpackaged--1.0.sql
-rw-r--r--. 1 root root  400 Aug  7 11:50 pgstattuple--1.0--1.1.sql
-rw-r--r--. 1 root root 1.5K Aug  7 11:50 pgstattuple--1.1--1.2.sql
-rw-r--r--. 1 root root 1.1K Aug  7 11:50 pgstattuple--1.2--1.3.sql
-rw-r--r--. 1 root root 3.6K Aug  7 11:50 pgstattuple--1.3.sql
-rw-r--r--. 1 root root  147 Aug  7 11:50 pgstattuple.control
-rw-r--r--. 1 root root  457 Aug  7 11:50 pgstattuple--unpackaged--1.0.sql
-rw-r--r--. 1 root root  536 Aug  7 11:50 pg_trgm--1.0--1.1.sql
-rw-r--r--. 1 root root 5.3K Aug  7 11:50 pg_trgm--1.1.sql
-rw-r--r--. 1 root root  177 Aug  7 11:50 pg_trgm.control
-rw-r--r--. 1 root root 4.2K Aug  7 11:50 pg_trgm--unpackaged--1.0.sql
-rw-r--r--. 1 root root  332 Aug  7 11:50 plpgsql--1.0.sql
-rw-r--r--. 1 root root  179 Aug  7 11:50 plpgsql.control
-rw-r--r--. 1 root root  381 Aug  7 11:50 plpgsql--unpackaged--1.0.sql
-rw-r--r--. 1 root root  507 Aug  7 11:50 postgres_fdw--1.0.sql
-rw-r--r--. 1 root root  172 Aug  7 11:50 postgres_fdw.control
-rw-r--r--. 1 root root  343 Aug  7 11:50 refint--1.0.sql
-rw-r--r--. 1 root root  169 Aug  7 11:50 refint.control
-rw-r--r--. 1 root root  314 Aug  7 11:50 refint--unpackaged--1.0.sql
-rw-r--r--. 1 root root 7.6K Aug  7 11:50 seg--1.0.sql
-rw-r--r--. 1 root root  172 Aug  7 11:50 seg.control
-rw-r--r--. 1 root root 2.8K Aug  7 11:50 seg--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.2K Aug  7 11:50 sslinfo--1.0.sql
-rw-r--r--. 1 root root  146 Aug  7 11:50 sslinfo.control
-rw-r--r--. 1 root root  846 Aug  7 11:50 sslinfo--unpackaged--1.0.sql
-rw-r--r--. 1 root root 2.2K Aug  7 11:50 tablefunc--1.0.sql
-rw-r--r--. 1 root root  174 Aug  7 11:50 tablefunc.control
-rw-r--r--. 1 root root 1.2K Aug  7 11:50 tablefunc--unpackaged--1.0.sql
-rw-r--r--. 1 root root  274 Aug  7 11:50 tcn--1.0.sql
-rw-r--r--. 1 root root  134 Aug  7 11:50 tcn.control
-rw-r--r--. 1 root root  486 Aug  7 11:50 timetravel--1.0.sql
-rw-r--r--. 1 root root  156 Aug  7 11:50 timetravel.control
-rw-r--r--. 1 root root  394 Aug  7 11:50 timetravel--unpackaged--1.0.sql
-rw-r--r--. 1 root root  16K Aug  7 11:50 tsearch2--1.0.sql
-rw-r--r--. 1 root root  313 Aug  7 11:50 tsearch2.control
-rw-r--r--. 1 root root 8.9K Aug  7 11:50 tsearch2--unpackaged--1.0.sql
-rw-r--r--. 1 root root  327 Aug  7 11:50 tsm_system_rows--1.0.sql
-rw-r--r--. 1 root root  186 Aug  7 11:50 tsm_system_rows.control
-rw-r--r--. 1 root root  327 Aug  7 11:50 tsm_system_time--1.0.sql
-rw-r--r--. 1 root root  192 Aug  7 11:50 tsm_system_time.control
-rw-r--r--. 1 root root  854 Aug  7 11:50 unaccent--1.0.sql
-rw-r--r--. 1 root root  157 Aug  7 11:50 unaccent.control
-rw-r--r--. 1 root root  766 Aug  7 11:50 unaccent--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.4K Aug  7 11:50 uuid-ossp--1.0.sql
-rw-r--r--. 1 root root  163 Aug  7 11:50 uuid-ossp.control
-rw-r--r--. 1 root root  853 Aug  7 11:50 uuid-ossp--unpackaged--1.0.sql
-rw-r--r--. 1 root root 1.9K Aug  7 11:50 xml2--1.0.sql
-rw-r--r--. 1 root root  208 Aug  7 11:50 xml2.control
-rw-r--r--. 1 root root 1.4K Aug  7 11:50 xml2--unpackaged--1.0.sql
[jibl@pc-100 proto]$ docker exec -it postgis sh -c "ls -allh /usr/share/postgresql/9.5/extension/"|grep postgis_topology.control
[jibl@pc-100 proto]$ 
```
