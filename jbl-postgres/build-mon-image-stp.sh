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

sudo docker build -t $NOM_DE_MON_IMAGE:9.3 .
