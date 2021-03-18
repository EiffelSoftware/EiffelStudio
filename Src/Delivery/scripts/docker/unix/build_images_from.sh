#!/bin/bash

porterpackage_archive=$1
image_output=$2
deliv_platform=$3
edition_name=$4
case $deliv_platform in
	64)
		deliv_platform="64bits"
		;;
	linux-x86-64)
		deliv_platform="64bits"
		;;
	32)
		deliv_platform="32bits"
		;;
	linux-x86)
		deliv_platform="32bits"
		;;
	*)
		deliv_platform="64bits"
		;;
esac

echo Build the $edition_name for ${deliv_platform}  
echo  - from $porterpackage_archive
echo  - output $image_output

if [ -e "$porterpackage_archive" ]; then
	if [ -d "$image_output" ]; then

		docker_image_name=local/eiffel-deliv-image-${deliv_platform}
		     
		docker rmi $docker_image_name 
		docker build -t $docker_image_name -f ./image/dockerfile-${deliv_platform} image
		docker run --rm \
			--name=eiffel-deliv-img-${deliv_platform} \
			-v ${image_output}:/home/eiffel/deliv/image \
			-v ${porterpackage_archive}:/home/eiffel/deliv/porterpackage.tar \
			-e PORTERPACKAGE_TAR=/home/eiffel/deliv/porterpackage.tar \
			--network host \
			--user $(id -u):$(id -g) \
			${docker_image_name}
		#docker rmi $docker_image_name 
	else
		echo ERROR: bad output folder ${image_output} !
	fi
else
	echo ERROR: missing porterpackage ${porterpackage_archive} 
fi

