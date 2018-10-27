#!/bin/bash

# cf. [https://gist.github.com/robert-claypool/e725aa310e0d2b63bbb7]

echo "deb http://apt.postgresql.org/pub/repos/apt/ YOUR_DEBIAN_VERSION_HERE-pgdg main" >> ./pgdg.malitste
sudo cp ./pgdg.list /etc/apt/sources.list.d/pgdg.list

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -
apt-get update -y

# Je suppose que mes chers amis de chez appropriate, ...on bie fait les installations
# sudo apt install postgresql-10
# sudo apt install postgresql-10-postgis-2.4 
# sudo apt install postgresql-10-postgis-scripts


#to get the commandline tools shp2pgsql, raster2pgsql you need to do this
sudo apt install postgis



apt-get update \
    && apt-get install -y --no-install-recommends \
         postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
         postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
         postgis=$POSTGIS_VERSION \
         && rm -rf /var/lib/apt/lists/*