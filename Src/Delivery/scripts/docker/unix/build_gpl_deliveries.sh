#!/bin/bash

#docker ps -a | awk '{ print $1,$2 }' | grep eiffel_deliv | awk '{print $1 }' | xargs -I {} docker rm {}
docker ps -a -q --filter=ancestor=unix_eiffel_deliv | xargs -I {} docker rm {}

docker rmi unix_eiffel_deliv
docker rmi unix_eiffel_deliv_32bits

docker-compose -f docker-compose.yml up --build
docker-compose -f docker-compose-32bits.yml up --build

