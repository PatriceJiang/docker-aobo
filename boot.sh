#!/bin/bash 

set -x

docker run \
    -d \
    -p 80:80 \
    -v mount/data:/data
    pt/test1
    