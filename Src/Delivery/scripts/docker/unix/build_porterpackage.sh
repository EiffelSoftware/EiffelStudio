#!/bin/bash

if [ -z "$SVN_EIFFELSTUDIO_REPO_REVISION" ]; then
        SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

var_dir=`pwd`/var

if [ "$include_enterprise" = "true" ]; then
	output_dir=$var_dir/ent
else
	output_dir=$var_dir/standard
fi
mkdir -p $output_dir
docker_image_name=local/eiffel-deliv-porterpackage
docker rmi ${docker_image_name}

docker build -t ${docker_image_name} -f ./porterpackage/dockerfile porterpackage

if [ -d "$var_dir/eiffel" ]; then
	echo Use Eiffel installation from $var_dir/eiffel/...
        t_docker_vol_opts="-v $var_dir/eiffel:/home/eiffel/Eiffel"
fi
if [ -z "$SVN_ISE_REPO" ]; then
	SVN_ISE_REPO=svn://svn.ise/ise_svn
fi
if [ -z "$SVN_EIFFELSTUDIO_REPO" ]; then
        SVN_EIFFELSTUDIO_REPO=svn://svn.ise/mirrors/eiffelstudio
fi
if [ -z "$make_delivery_args" ]; then
        make_delivery_args=
fi
echo Use EiffelStudio repo $SVN_EIFFELSTUDIO_REPO
echo Use ISE repo $SVN_ISE_REPO

docker run --rm \
        --name=eiffel-deliv-pp \
        -v $output_dir:/home/eiffel/deliv/output \
        ${t_docker_vol_opts} \
        --network host \
        -e SVN_ISE_REPO=$SVN_ISE_REPO \
        -e SVN_ISE_BRANCH=$SVN_ISE_BRANCH \
        -e SVN_EIFFELSTUDIO_REPO=$SVN_EIFFELSTUDIO_REPO \
        -e SVN_EIFFELSTUDIO_REPO_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION \
        -e SVN_EIFFELSTUDIO_BRANCH=$SVN_EIFFELSTUDIO_BRANCH \
		-e INCLUDE_ENTERPRISE=$include_enterprise \
		-e MAKE_DELIVERY_ARGS=$make_delivery_args \
		-e USER_ID=$(id -u) \
		-e USER_GID=$(id -g) \
		--user $(id -u):$(id -g) \
        ${docker_image_name}

#docker rmi ${docker_image_name}

