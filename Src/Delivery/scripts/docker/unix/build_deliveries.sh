#!/bin/bash

#####################
# Optional settings #
#####################

#export SVN_EIFFELSTUDIO_REPO_REVISION=103046
#export SVN_ISE_BRANCH=/branches/Eiffel_19.12
#export SVN_EIFFELSTUDIO_BRANCH=/branches/Eiffel_19.12


#include_enterprise=true

#include_64bits="true"
#include_64bits="false"
#include_32bits="true"
#include_32bits="false"

#################################
# Do not modify following lines #
#################################
if test -z "$SVN_EIFFELSTUDIO_REPO_REVISION" 
then
	if ! test -z "$1" 
	then
		set SVN_EIFFELSTUDIO_REPO_REVISION=$1
	fi
fi

var_dir=`pwd`/var

if [ "$include_enterprise" = "true" ]; then
	edition_name="ENT"
	output_dir=$var_dir/ent
else
	edition_name="standard"
	output_dir=$var_dir/standard
fi

echo include_enterprise=$include_enterprise
echo edition_name=$edition_name


if [ ! -e $output_dir ]; then
	mkdir $output_dir
fi

share_deliv_folder()
{
	dn=$1
	msg="$2"
	if [ -e "./share_delivery" ]; then
		sh ./share_delivery $dn "$msg"
	else
		echo Folder $dn was not shared.
	fi
}


if [ "$SVN_EIFFELSTUDIO_REPO_REVISION" = "" ]; then
	set SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

echo "===================================="
echo "= Build the $edition_name PorterPackage ======"
echo "===================================="
sh ./build_porterpackage.sh
if [ -e "$output_dir/last_revision_built" ]; then
	deliv_revision=`head -n 1 $output_dir/last_revision_built`
	porterpackage_tar=$output_dir/$deliv_revision/PorterPackage_${deliv_revision}.tar
	share_deliv_folder $output_dir/${deliv_revision} "New $edition_name Porterpackage for revision ${deliv_revision}"
	if [ -e "$porterpackage_tar" ]; then
		if [ "$include_64bits" = "true" ]; then
			echo "===================================="
			echo "= Build the $edition_name 64bits ============="
			echo "===================================="
			sh ./build_images_from.sh $porterpackage_tar $output_dir/${deliv_revision} 64 $edition_name
			share_deliv_folder $output_dir/${deliv_revision} "New $edition_name linux-x86-64 release for revision ${deliv_revision}"
		fi

		if [ "$include_32bits" = "true" ]; then
			echo "===================================="
			echo "= Build the $edition_name 32bits ============="
			echo "===================================="
			sh ./build_images_from.sh $porterpackage_tar $output_dir/${deliv_revision} 32 $edition_name
			share_deliv_folder $output_dir/${deliv_revision} "New $edition_name linux-x86 release for revision ${deliv_revision}"
		fi 
	else
		echo ERROR: missing porterpackage "$porterpackage_tar" !
	fi
else
	echo ERROR: issue with previous porterpackage building! 
fi

