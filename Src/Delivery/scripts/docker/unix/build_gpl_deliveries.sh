#!/bin/bash

#####################
# Optional settings #
#####################

include_64bits="true"
#include_64bits="false"
include_32bits="true"
#include_32bits="false"
#set SVN_EIFFELSTUDIO_REPO_REVISION=103046

#################################
# Do not modify following lines #
#################################

share_deliv_folder()
{
	dn=$1
	msg=$2
	if [ -e "./share_delivery" ]; then
		./share_delivery $dn $msg
	else
		echo Folder $dn was not shared.
	fi
}

var_dir=`pwd`/var

if [ "$SVN_EIFFELSTUDIO_REPO_REVISION" = "" ]; then
	set SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

echo "===================================="
echo "= Build the GPL PorterPackage ======"
echo "===================================="
sh ./build_gpl_porterpackage.sh
if [ -e "$var_dir/deliv-output/last_revision_built" ]; then
	deliv_revision=`head -n 1 $var_dir/deliv-output/last_revision_built`
	porterpackage_tar=$var_dir/deliv-output/$deliv_revision/PorterPackage_${deliv_revision}.tar
	share_deliv_folder $var_dir/deliv-output/${deliv_revision} "New Porterpackage for revision ${deliv_revision}"
	if [ -e "$porterpackage_tar" ]; then
		if [ "$include_64bits" = "true" ]; then
			echo "===================================="
			echo "= Build the GPL 64bits ============="
			echo "===================================="
			sh ./build_gpl_images_from.sh $porterpackage_tar $var_dir/deliv-output/${deliv_revision} 64
			share_deliv_folder $var_dir/deliv-output/${deliv_revision} "New linux-x86-64 release for revision ${deliv_revision}"
		fi

		if [ "$include_32bits" = "true" ]; then
			echo "===================================="
			echo "= Build the GPL 32bits ============="
			echo "===================================="
			sh ./build_gpl_images_from.sh $porterpackage_tar $var_dir/deliv-output/${deliv_revision} 32
			share_deliv_folder $var_dir/deliv-output/${deliv_revision} "New linux-x86 release for revision ${deliv_revision}"
		fi 
	else
		echo ERROR: missing porterpackage "$porterpackage_tar" !
	fi
else
	echo ERROR: mssue with previous porterpackage building! 
fi

