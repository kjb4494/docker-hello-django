#!/bin/bash
VERSION=$1
IMAGE="asia.gcr.io/hsgitlab-777/hello-world"
CONTAINER_NAME="hello-world"

docker pull $IMAGE:$VERSION
docker run --restart always --name $CONTAINER_NAME-$VERSION -d -v /tmp:/tmp --log-driver=gcplogs $IMAGE:$VERSION
docker stop $(docker ps -a -q | awk "NR>1")
docker rm $(docker ps -a -q | awk "NR>1")
