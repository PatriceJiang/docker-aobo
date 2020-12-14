#!/bin/bash 

set -x
cd compose
docker-compose up \
    --no-recreate  \
    --detach   

    