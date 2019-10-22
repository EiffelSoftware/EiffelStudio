#!/bin/bash

#####################
# Optional settings #
#####################

#include_enterprise=true

include_64bits="true"
#include_64bits="false"
include_32bits="true"
#include_32bits="false"

#export SVN_EIFFELSTUDIO_REPO_REVISION=103046
#export SVN_ISE_BRANCH=/branches/Eiffel_19.11
#export SVN_EIFFELSTUDIO_BRANCH=/branches/Eiffel_19.11

#################################
# Do not modify following lines #
#################################
var_dir=`pwd`/var

if "$include_enterprise" = "true"; then
	output_dir=$var_dir/ent
else
	output_dir=$var_dir/gpl
fi
if [ ! -e $output_dir ]; then
	mkdir $output_dir
fi

share_deliv_folder()
{
	dn=$1
	msg="$2"
	if [ -e "./share_delivery" ]; then
		./share_delivery $dn "$msg"
	else
		echo Folder $dn was not shared.
	fi
}


if [ "$SVN_EIFFELSTUDIO_REPO_REVISION" = "" ]; then
	set SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

echo "===================================="
echo "= Build the GPL PorterPackage ======"
echo "===================================="
sh ./build_gpl_porterpackage.sh
if [ -e "$output_dir/last_revision_built" ]; then
	deliv_revision=`head -n 1 $output_dir/last_revision_built`
	porterpackage_tar=$output_dir/$deliv_revision/PorterPackage_${deliv_revision}.tar
	share_deliv_folder $output_dir/${deliv_revision} "New Porterpackage for revision ${deliv_revision}"
	if [ -e "$porterpackage_tar" ]; then
		if [ "$include_64bits" = "true" ]; then
			echo "===================================="
			echo "= Build the GPL 64bits ============="
			echo "===================================="
			sh ./build_gpl_images_from.sh $porterpackage_tar $output_dir/${deliv_revision} 64
			share_deliv_folder $output_dir/${deliv_revision} "New linux-x86-64 release for revision ${deliv_revision}"
		fi

		if [ "$include_32bits" = "true" ]; then
			echo "===================================="
			echo "= Build the GPL 32bits ============="
			echo "===================================="
			sh ./build_gpl_images_from.sh $porterpackage_tar $output_dir/${deliv_revision} 32
			share_deliv_folder $output_dir/${deliv_revision} "New linux-x86 release for revision ${deliv_revision}"
		fi 
	else
		echo ERROR: missing porterpackage "$porterpackage_tar" !
	fi
else
	echo ERROR: issue with previous porterpackage building! 
fi

