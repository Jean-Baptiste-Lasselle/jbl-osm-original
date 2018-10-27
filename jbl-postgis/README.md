# DErnière erreur :

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
