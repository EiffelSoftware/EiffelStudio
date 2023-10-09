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
		export SVN_EIFFELSTUDIO_REPO_REVISION=$1
	fi
fi

var_dir=`pwd`/var

if [ "$include_enterprise" = "true" ]; then
	edition_name="ent"
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
		sh ./share_delivery $dn "" "$msg"
	else
		echo Folder $dn was not shared.
	fi
}

share_deliv_file()
{
	fn=$1
	msg="$2"
	k=$3
	if [ -e "./share_delivery" ]; then
		sh ./share_delivery $fn $k "$msg"
	else
		echo File $fn was not shared.
	fi
}


if [ "$SVN_EIFFELSTUDIO_REPO_REVISION" = "" ]; then
	export SVN_EIFFELSTUDIO_REPO_REVISION=HEAD
fi

echo "===================================="
echo "= Build the $edition_name PorterPackage ======"
echo "===================================="
sh ./build_porterpackage.sh
if [ -e "$output_dir/last_revision_built" ]; then
	deliv_revision=`head -n 1 $output_dir/last_revision_built`
	porterpackage_tar=$output_dir/$deliv_revision/PorterPackage_${deliv_revision}.tar
	if [ -e "$porterpackage_tar" ]; then
		pp_filesize=$(stat -c%s "$porterpackage_tar")
		if (( $pp_filesize < 50000000 )); then
			echo "ERROR: File size of $porterpackage_tar sounds too small to be valid (size=$pp_filesize), stop delivery!"
			rm "$porterpackage_tar"
		else
			if [ "$include_enterprise" = "true" ]; then
				echo "Sharing the $edition_name PorterPackage (including enterprise) to (ent)"
				share_deliv_file $output_dir/${deliv_revision}/PorterPackage_${deliv_revision}.tar "New $edition_name Porterpackage for revision ${deliv_revision}" ent
			else if [ "$edition_name" = "ent" ]; then
				echo "Sharing the $edition_name PorterPackage to (ent)"
				share_deliv_file $output_dir/${deliv_revision}/PorterPackage_${deliv_revision}.tar "New $edition_name Porterpackage for revision ${deliv_revision}" ${edition_name}
			else
				echo "Sharing the $edition_name PorterPackage to (std)"
				share_deliv_file $output_dir/${deliv_revision}/PorterPackage_${deliv_revision}.tar "New $edition_name Porterpackage for revision ${deliv_revision}" ${edition_name}
			fi
		fi
	fi
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

