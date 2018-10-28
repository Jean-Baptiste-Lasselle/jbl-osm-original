#!/bin/bash


export POSTGRESQL_VERSION_ID=9.5.14
#      
# - pourra être remplacé par :
#      
#   +  export POSTGRESQL_VERSION_ID=9.5.14
#      
#   +  export POSTGRESQL_VERSION_ID=9.5.14
#        
#   +  export POSTGRESQL_BUILD_ID=dlkejfjsdf    =>> donc celui-là il permet de retrouver la version exacte du code source
#   +  cc
#    


# might be an IP address, a resolvable (in execution context) domain name
# export DOCKER_REGISTRY_NET_HOST_ID=docker.io
# export DOCKER_REGISTRY_NET_HOST_ID=docker.kytes.io
export DOCKER_REGISTRY_NET_HOST_ID=localhost
export DISTRIBUTOR_ORGANIZATION=kytes
export DISTRIBUTED_PRODUCT_DISTRIBUTION_NAME=postgresql
export DISTRIBUTED_PRODUCT_VERSION_ID=0.0.1
export UNEDERLYING_CONTAINER_OS_IMAGE=ubuntu
export UNEDERLYING_CONTAINER_OS_VERSION=latest
# export NOM_DE_MON_IMAGE=$DOCKER_REGISTRY_NET_HOST_ID/$DISTRIBUTOR_ORGANIZATION/$DISTRIBUTED_PRODUCT_DISTRIBUTION_NAME-$POSTGRESQL_VERSION_ID:$DISTRIBUTED_PRODUCT_VERSION_ID
# But here I play with a DIY local image 
export NOM_DE_MON_IMAGE="$DISTRIBUTOR_ORGANIZATION/$DISTRIBUTED_PRODUCT_DISTRIBUTION_NAME-$POSTGRESQL_VERSION_ID-$UNEDERLYING_CONTAINER_OS_IMAGE"
# Mais pour ces tests, j'utiliserai uniquement le registry local docker : 
NOM_DE_MON_IMAGE="$NOM_DE_MON_IMAGE:$DISTRIBUTED_PRODUCT_VERSION_ID"


sudo docker build -t $NOM_DE_MON_IMAGE .
echo " You now have those images : "
docker images|grep postgres

# -       - #
# -  RUN  - #
# -       - #
export RESEAU_DOCKER_DEVOPS_TESTS=""
export JEU_OPTIONS=""



# 
# -------------------------  [TEST 1] 
# 
# -
# 
# - Je lance 1 conteneur dans le réseau $RESEAU_DOCKER_DEVOPS_TESTS, différant seulement par les
# - variables d'environnements / build args , cf. 'export JEU_OPTIONS='
# 
# - Environnement du test
# 
export RESEAU_DOCKER_DEVOPS_TESTS=reseau-tests-devops1
export NOM_CONTENEUR_TESTRUNNER=test1-jbl-postgres-docker
export JEU_OPTIONS=""
# export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_USER=kytes"
export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_PASSSWORD=kytes"

# 
# - SETUP / JUnit ? ;)
# 
# - Je créée un réseau docker de type bridge
# 
docker network create --driver bridge $RESEAU_DOCKER_DEVOPS_TESTS
# - RUN TEST / J'exéute le test : option " --rm" pou rne pas être importuné par les répertoires créés par Docker Engine


echo "   "
echo " - ==>>> AVANT DOCKER RUN (setup test)"
echo "   "
echo " - "
echo " VERIF : [NOM_CONTENEUR_TESTRUNNER=$NOM_CONTENEUR_TESTRUNNER]"
echo " - "
echo " VERIF : [RESEAU_DOCKER_DEVOPS_TESTS=$RESEAU_DOCKER_DEVOPS_TESTS]"
echo " - "
echo " VERIF : [JEU_OPTIONS=$JEU_OPTIONS]"
echo " - "
echo " VERIF : [NOM_DE_MON_IMAGE=$NOM_DE_MON_IMAGE]"
echo " - "
echo " You currently have those test images : "
docker images|grep postgres
echo "   "
read ATTENDS1

docker run -itd --name $NOM_CONTENEUR_TESTRUNNER --network $RESEAU_DOCKER_DEVOPS_TESTS $JEU_OPTIONS $NOM_DE_MON_IMAGE
# 
# But (TEST RESULT OK) du test : arriver à me connecter à la BDD avec le client postgresql
# 
# d'autres tests : se connecter depuis un autre hôte réseau, un autre conteneur dans le réseau bridge Docker.
#                  comme ma sonde réseau



echo " "
echo " - ==>>> AVANT DOCKER EXEC (run test) "
echo " "
echo " "
echo " - "
echo " Le conteneur créé et lancé avec |docker run] est  : "
docker ps -a|grep $NOM_CONTENEUR_TESTRUNNER
echo " - "
echo " VERIF : [NOM_CONTENEUR_TESTRUNNER=$NOM_CONTENEUR_TESTRUNNER]"
echo " - "
echo " VERIF : [RESEAU_DOCKER_DEVOPS_TESTS=$RESEAU_DOCKER_DEVOPS_TESTS]"
echo " - "
echo " VERIF : [JEU_OPTIONS=$JEU_OPTIONS]"
echo " - "
echo " VERIF : [NOM_DE_MON_IMAGE=$NOM_DE_MON_IMAGE]"
echo " - "
echo " "
read ATTENDS2

clear

echo "  Utilisateur par défaut dans le conteneur : "
docker exec -it $NOM_CONTENEUR_TESTRUNNER whoami
echo "  Authentification auserveur PostGreSQL, en utilsiant le client psql, et avec l'utilisateur admin initial configuré dans le 'docker-compose.yml'  : "
docker exec -it $NOM_CONTENEUR_TESTRUNNER psql -h $NOM_CONTENEUR_TESTRUNNER -U postgres --password

echo " "
echo "  [TEARDOWN] Pour nettoyer l'environnement et relancer ce test (ou le prochain) :  "
echo "  "
echo "      docker stop $NOM_CONTENEUR_TESTRUNNER && docker rm $NOM_CONTENEUR_TESTRUNNER && docker rmi $NOM_DE_MON_IMAGE && docker network rm $RESEAU_DOCKER_DEVOPS_TESTS "
echo "  "
echo "  "

# 
# - 
# - Le test sugéré par ma lecture (manifestement un connexion avec le prmier super-utilisateur créé par PostGreSQL, en fonction des valaeurs des variables d'environnement : 
# - 
# 
# docker run -it --rm --network $RESEAU_DOCKER_DEVOPS_TESTS $NOM_DE_MON_IMAGE psql -h $NOM_CONTENEUR_TESTRUNNER -U postgres --password
# 
# 
# 
# - TEAR DOWN 
# 
# docker stop test1-jbl-postgres-docker && docker rm test1-jbl-postgres-docker
# 



# !! -> !! FINAL TEARDOWN
# docker rmi $NOM_DE_MON_IMAGE
# sudo docker system prune -f
