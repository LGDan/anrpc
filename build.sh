#!/bin/bash

IMAGE=lgdan/anrpc
DT=$(date +"%Y%m%d%H%M%S")

docker build . --tag $IMAGE:$DT

docker tag $IMAGE:$DT $IMAGE:latest
