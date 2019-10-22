#!/bin/bash

if [ "$SVN_EIFFELSTUDIO_REPO_REVISION" = "" ]; then
        set SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

var_dir=`pwd`/var
docker_image_name=local/eiffel-deliv-porterpackage-ent
docker rmi ${docker_image_name}
docker build -t ${docker_image_name} -f ./porterpackage/dockerfile porterpackage
if [ -d "$var_dir/eiffel" ]; then
	echo Use Eiffel installation from $var_dir/eiffel/...
        t_docker_vol_opts="-v $var_dir/eiffel:/home/eiffel/Eiffel"
fi
docker run --rm \
        --name=eiffel-deliv-pp-ent \
        -v $var_dir/ent:/home/eiffel/deliv/output \
        ${t_docker_vol_opts} \
        --network host \
        -e SVN_ISE_REPO=svn://svn.ise/ise_svn \
        -e SVN_ISE_BRANCH=$SVN_ISE_BRANCH \
        -e SVN_EIFFELSTUDIO_REPO=svn://svn.ise/mirrors/eiffelstudio \
        -e SVN_EIFFELSTUDIO_REPO_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION \
        -e SVN_EIFFELSTUDIO_BRANCH=$SVN_EIFFELSTUDIO_BRANCH \
	-e INCLUDE_ENTERPRISE=true \
        ${docker_image_name}
#docker rmi ${docker_image_name}


	#-e EIFFEL_SETUP_CHANNEL=18.11.102592 \
	#-e SVN_ISE_BRANCH=/tags/Eiffel_18.11 \
	#-e SVN_EIFFELSTUDIO_BRANCH=/tags/Eiffel_18.11/R1 \


