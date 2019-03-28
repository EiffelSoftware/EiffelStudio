#!/bin/bash

include_32bits="true"
#include_32bits="false"

echo Build the GPL PorterPackage
sh ./build_gpl_porterpackage.sh

echo Build the GPL 64bits 
docker run --rm -it --name=eiffel-deliv-64bits \
       	-v `pwd`/var/deliv-output:/home/eiffel/deliv/output \
       	--network host \
	local/eiffel-deliv

if [ "$include_32bits" == "true" ]; then
	echo Build the GPL 32bits 
	docker rmi local/eiffel-deliv-32bits
	docker build -t local/eiffel-deliv-32bits -f ./dockerfile-32bits  .
	docker run --rm -it --name=eiffel-deliv-32bits \
		-v `pwd`/var/deliv-output:/home/eiffel/deliv/output \
		--network host \
		local/eiffel-deliv-32bits

fi

echo Share delivery output
./share_delivery.sh `pwd`/var/deliv-output

#docker ps -a | awk '{ print $1,$2 }' | grep eiffel_deliv | awk '{print $1 }' | xargs -I {} docker rm {}
#docker ps -a -q --filter=ancestor=unix_eiffel_deliv | xargs -I {} docker rm {}

#docker rmi unix_eiffel_deliv
#docker rmi unix_eiffel_deliv_32bits

#docker-compose -f docker-compose.yml up --build
#docker-compose -f docker-compose-32bits.yml up --build

