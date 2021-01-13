#!/bin/bash

to_version=$1
from_version=$2

if [[ ! $to_version =~ ^[0-9][0-9]\.[0-9][0-9]$ ]]; then
	to_version=`date +%y.%m`
fi

if [[ ! $from_version =~ ^[0-9][0-9]\.[0-9][0-9]$ ]]; then
	from_version="[0-9][0-9]\.[0-9][0-9]"
	#from_version=`date -d "1 month ago" +%y.%m`
fi

curr_year=`date +%Y`

to_version_major=`echo $to_version | cut -d. -f1`
to_version_minor=`echo $to_version | cut -d. -f2`

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
	svn diff "$2"
	echo $2 >> file_to_commit.log
	echo $2 \\ >> commit_changes.sh
	#read -p "Press ENTER key..."
}

function doall_sed {
	for filename in $2*; do
		echo sed -i -e "$1" "$filename" 
		sed -i -e "$1" "$filename" 
		svn diff "$filename"
		echo $filename >> file_to_commit.log
		echo $filename \\ >> commit_changes.sh
	done
}

if [ -z "$EIFFEL_SRC" ]; then export EIFFEL_SRC=$(readlink -n -q -m `pwd`/..) ; fi

echo Update source code from version $from_version to $to_version.
echo Year=$curr_year
echo EIFFEL_SRC=$EIFFEL_SRC
echo  > file_to_commit.log
echo  echo Update to version $to_version > commit_changes.sh
echo  export EIFFEL_SRC=#EIFFEL_SRC >> commit_changes.sh
echo  svn commit \\ >> commit_changes.sh

# $EIFFEL_SRC/Delivery/VERSION
do_sed "s/\<[0-9][0-9][0-9][0-9]\>/$curr_year/g" $EIFFEL_SRC/Delivery/VERSION 
do_sed "s/release [0-9][0-9]\.[0-9][0-9]/release $to_version/g" $EIFFEL_SRC/Delivery/VERSION 

EIF_DELIV_SCRIPTS_DIR=$EIFFEL_SRC/Delivery/scripts

# Deliv scripts
# - windows
do_sed "s/\(STUDIO_VERSION_MAJOR_MINOR\)=[0-9][0-9]\.[0-9][0-9]/\1=$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/set_aliases.btm
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/set_aliases.btm
do_sed "s/[0-9][0-9]\.[0-9][0-9]_deliv/${to_version}_deliv/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/set_aliases.btm

pushd ${EIF_DELIV_SCRIPTS_DIR}/windows
do_sed "s/\r//g" ${EIF_DELIV_SCRIPTS_DIR}/windows/set_new_eiffelstudio_guid.sh
./set_new_eiffelstudio_guid.sh
popd

do_sed "s/\"$from_version\"/\"$to_version\"/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/install/includes/Preprocessors.wxi
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/install/includes/Preprocessors.wxi
do_sed "s/EiffelStudio [0-9][0-9]\.[0-9][0-9]/EiffelStudio $to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/windows/install/includes/Preprocessors.wxi


# - unix
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/README.unix
do_sed "s/PorterPackage_[0-9][0-9]\.[0-9][0-9]/PorterPackage_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/make_all
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/make_for_platform
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/make_images
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/set_aliases
do_sed "s/\(STUDIO_VERSION_MAJOR_MINOR\)=[0-9][0-9]\.[0-9][0-9]/\1=$to_version/g" ${EIF_DELIV_SCRIPTS_DIR}/unix/set_aliases

# $EIFFEL_SRC/Delivery/studio/config/windows/esvars.bat
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/studio/config/windows/esvars.bat

# $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing
do_sed "s/Version [0-9][0-9]\.[0-9][0-9]/Version $to_version/g" $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing
do_sed "s/=[0-9][0-9]\.[0-9][0-9]/=$to_version/g" $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing



# Run-time 
# $EIFFEL_SRC/C/ipc/daemon/env.c
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/C/ipc/daemon/env.c


# $EIFFEL_SRC/C/CONFIGS/*
doall_sed "s/'\.$from_version'/'\.$to_version'/g" $EIFFEL_SRC/C/CONFIGS/

# EiffelStudio project
# $EIFFEL_SRC/Eiffel/Ace/ec.rc
do_sed "s/$from_version\(,0,0\)/$to_version\1/g" $EIFFEL_SRC/Eiffel/Ace/ec.rc
do_sed "s/$from_version\(\.0\.0\)/$to_version\1/g" $EIFFEL_SRC/Eiffel/Ace/ec.rc
do_sed "s/$from_version\(.0\"\)/$to_version\1/g" $EIFFEL_SRC/Eiffel/Ace/ec.rc
do_sed "s/Eiffel Studio [0-9][0-9]\.[0-9][0-9]/Eiffel Studio $to_version/g" $EIFFEL_SRC/Eiffel/Ace/ec.rc
do_sed "s/\"$from_version\"/\"$to_version\"/g" $EIFFEL_SRC/Eiffel/Ace/ec.rc
 
# $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e
do_sed "s/\(major_version: .* = \)[0-9][0-9]/\1$to_version_major/g" $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e
do_sed "s/\(minor_version: .* = \)[0-9][0-9]/\1$to_version_minor/g" $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e

sort -u file_to_commit.log -o file_to_commit.log
sed -i -e  "s~$EIFFEL_SRC~\$EIFFEL_SRC~g" file_to_commit.log

echo  -m \"chore: Updated to $to_version .\"  >> commit_changes.sh

sed -i -e  "s~$EIFFEL_SRC~  \$EIFFEL_SRC~g" commit_changes.sh
sed -i -e  "s~#EIFFEL_SRC~$EIFFEL_SRC~g" commit_changes.sh

echo "Files to commit (in file_to_commit.log):"
cat file_to_commit.log

