#!/bin/bash

docker container stop $(docker container ls -a -q) &

docker container rm $(docker container ls -a -q) &
 
docker image rm $(docker image ls -a -q) &
 
docker volume rm $(docker volume ls -q) &
 
docker network rm $(docker network ls -q) &

docker system prune -a -f --volumes
