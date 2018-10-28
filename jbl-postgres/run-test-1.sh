#!/bin/bash

# -> Un processus /bin/bash est donc l'environnement d'exécution du test

# What I test here :
# ...
# 
# 


# - TEST ENV. CLEAN UP
docker-compose down --rmi all

# - TEST SETUP
# I have setup my stup resources (of test `N` in `./tests-resources/N/`, where N=1, 2, 3 ...

cp ./.env ./.env.clone
rm -f ./.env
cp ./tests-resources/1/.env ./.env
docker-compose up -d

# - TEST RUN
# What I expect as the result test :
# ...
# 
# 

# export NOM_CONTENEUR_TESTRUNNER=test1-jbl-postgres-docker
export NOM_CONTENEUR_TESTRUNNER=$(cat ./docker-compose.yml|grep container|awk -F ':' '{print $2}')
echo "  "
echo " VERIF ENV. TEST RUN : [NOM_CONTENEUR_TESTRUNNER=$NOM_CONTENEUR_TESTRUNNER] "
echo "  "
export JEU_OPTIONS=""
export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_USER=$POSTGRES_USER"
export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_PASSSWORD=$POSTGRES_PASSSWORD"

# - TEST TEAR DOWN
docker-compose down --rmi all

rm -f ./.env
cp ./.env.clone ./.env
