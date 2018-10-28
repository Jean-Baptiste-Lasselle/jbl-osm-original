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
export DOCKER_REGISTRY_NET_HOST_ID=docker.io
export DOCKER_REGISTRY_NET_HOST_ID=docker.kytes.io
export DISTRIBUTOR_ORGANIZATION=kytes
export DISTRIBUTED_PRODUCT_DISTRIBUTION_NAME=postgresql
export DISTRIBUTED_PRODUCT_VERSION_ID=0.0.1

export NOM_DE_MON_IMAGE=$DOCKER_REGISTRY_NET_HOST_ID/$DISTRIBUTOR_ORGANIZATION/$DISTRIBUTED_PRODUCT_DISTRIBUTION_NAME-$POSTGRESQL_VERSION_ID:$DISTRIBUTED_PRODUCT_VERSION_ID

sudo docker build -t $NOM_DE_MON_IMAGE .

# -       - #
# -  RUN  - #
# -       - #
export RESEAU_DOCKER_DEVOPS_TESTS=""
export JEU_OPTIONS=""



# 
# [TESTS] pour chaque test :
# - 
# - Je lance 1 conteneur dans le réseau, différant seulement par les variables d'environnements / build args 

# - Environnement du test
export RESEAU_DOCKER_DEVOPS_TESTS=reseau-tests-devops1
export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_USER=kytes"
export JEU_OPTIONS="$JEU_OPTIONS -e POSTGRES_PASSSWORD=kytes"

# - SETUP 
# - Je créée un réseau docker de type bridge
docker network create --driver bridge $RESEAU_DOCKER_DEVOPS_TESTS
# - J'exéute le test
docker run --name test1-jbl-postgres-docker --network $RESEAU_DOCKER_DEVOPS_TESTS $JEU_OPTIONS -d $NOM_DE_MON_IMAGE
# - TEAR DOWN 
# docker stop test1-jbl-postgres-docker && docker rm test1-jbl-postgres-docker

# Test 1 : me connecter à la BDD avecle client postgresql
docker run -it --rm --network postgres-network postgresondocker:9.3 psql -h postgresondocker -U postgresondocker --password


# !! -> !! FINAL TEARDOWN
# docker rmi $NOM_DE_MON_IMAGE
# sudo docker system prune -f
