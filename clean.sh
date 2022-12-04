#!/bin/bash
# Run for sudo or whith 

docker container stop $(docker container ls -a -q) 

docker container rm $(docker container ls -a -q) 

docker system prune -a -f --volumes
