#!/bin/bash

#docker-compose -f docker-compose-pp.yml build
#docker-compose -f docker-compose-pp.yml up


docker rmi local/eiffel-deliv-ent
docker build -t local/eiffel-deliv-ent -f ./dockerfile  .
docker run --rm -it \
	--name=eiffel-deliv-ent-pp \
       	-v `pwd`/var/deliv-output:/home/eiffel/deliv/output \
       	--network host \
	-e ONLY_PORTERPACKAGE=true \
	-e INCLUDE_ENTERPRISE=true \
	-e SVN_EIFFELSTUDIO_REPO=svn://svn.ise/mirrors/eiffelstudio \
	-e SVN_ISE_REPO=svn://svn.ise/ise_svn \
	local/eiffel-deliv-ent

	#-e EIFFEL_SETUP_CHANNEL=18.11.102592 \
	#-e SVN_ISE_BRANCH=/tags/Eiffel_18.11 \
	#-e SVN_EIFFELSTUDIO_BRANCH=/tags/Eiffel_18.11/R1 \


