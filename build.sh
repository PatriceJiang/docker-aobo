#!/bin/bash

echo "Building docker ..."
cd compose
docker build -t pt/aobo .
