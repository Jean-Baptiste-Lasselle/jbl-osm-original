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
# export NOM_CONTENEUR_TESTRUNNER=$(cat ./docker-compose.yml|grep container|awk -F ':' '{print $2}')
export NOM_CONTENEUR_TESTRUNNER=$(cat ./.env |grep NOM_CONTENEUR_EXECUTION_TESTS|awk -F '=' '{print $2}')
echo "  "
echo " VERIF ENV. TEST RUN : [NOM_CONTENEUR_TESTRUNNER=$NOM_CONTENEUR_TESTRUNNER] "
echo "  "
docker ps -a |grep $NOM_CONTENEUR_TESTRUNNER
echo "  "
read ATTENDS1

clear

echo "  Utilisateur par défaut dans le conteneur : "
docker exec -it $NOM_CONTENEUR_TESTRUNNER whoami
echo "  Authentification auserveur PostGreSQL, en utilsiant le client psql, et avec l'utilisateur admin initial configuré dans le 'docker-compose.yml'  : "
docker exec -it $NOM_CONTENEUR_TESTRUNNER sh -c "psql -h $NOM_CONTENEUR_TESTRUNNER -U postgres --password"

echo " Vérifions que l'on peut utiliser la varible d'environnement 'PGPASSWORD' pour fixer le contexte d'authentification psql () "
echo " (pour s'authentifier sans saisie interactive de mot de passe) : "
docker exec -it $NOM_CONTENEUR_TESTRUNNER sh -c "export PGPASSWORD=$POSTGRES_PASSWORD && psql -h $NOM_CONTENEUR_TESTRUNNER -U postgres "

# But (TEST RESULT OK) du test : arriver à me connecter à la BDD avec le client postgresql
# 
# d'autres tests : se connecter depuis un autre hôte réseau, un autre conteneur dans le réseau bridge Docker.
#                  comme ma sonde réseau
echo " Your tests logs : "
docker logs $NOM_CONTENEUR_TESTRUNNER

echo " - "
echo " Next test : Press Enter key "
echo " - "
echo "           "
echo " - "
read ATTENDS1
docker-compose down --rmi all
# 
# - TEST TEAR DOWN
# docker-compose down --rmi all > ./teardown.log
# cat ./teardown.log 
# 

echo " - "
echo " You reached last test : Press Enter key to exit test suite "
echo " - "
echo "           "
echo " - "
read ATTENDS1
docker-compose down --rmi all
rm -f ./.env
cp ./.env.clone ./.env
