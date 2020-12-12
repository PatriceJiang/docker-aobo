#!/bin/bash

echo "Building docker ..."

docker build -t pt/test1 . \
    --build-args dbrootpwd=Outbook@577817 \
    --build-args secondary_domain=csaz.outbook.cc \
