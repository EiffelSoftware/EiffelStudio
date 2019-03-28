#!/bin/bash

docker rmi local/eiffel-deliv
docker build -t local/eiffel-deliv -f ./dockerfile  .
docker run --rm -it \
	--name=eiffel-deliv-pp \
       	-v `pwd`/var/deliv-output:/home/eiffel/deliv/output \
       	--network host \
	-e SVN_EIFFELSTUDIO_REPO=svn://svn.ise/mirrors/eiffelstudio \
	-e SVN_ISE_REPO=svn://svn.ise/ise_svn \
	-e ONLY_PORTERPACKAGE=true \
	local/eiffel-deliv

