#!/bin/bash

to_version=$1
curr_year=`date +%Y`

to_version_major=`echo $to_version | cut -d. -f1`
to_version_minor=`echo $to_version | cut -d. -f2`

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
}

function doall_sed {
	for filename in $2*; do
		echo sed -i -e "$1" "$filename" 
		sed -i -e "$1" "$filename" 
	done
}

if [ -z "$EIFFEL_SRC" ]; then export EIFFEL_SRC=$(readlink -n -q -m `pwd`/..) ; fi

echo Update source code to version $to_version.
echo Year=$curr_year
echo EIFFEL_SRC=$EIFFEL_SRC

# $EIFFEL_SRC/Delivery/VERSION
do_sed "s/\<[0-9][0-9][0-9][0-9]\>/$curr_year/g" $EIFFEL_SRC/Delivery/VERSION 
do_sed "s/release [0-9][0-9]\.[0-9][0-9]/release $to_version/g" $EIFFEL_SRC/Delivery/VERSION 

# $EIFFEL_SRC/Delivery/scripts/windows/install/includes/Preprocessors.wxi
do_sed "s/\"[0-9][0-9]\.[0-9][0-9]\"/\"$to_version\"/g" $EIFFEL_SRC/Delivery/scripts/windows/install/includes/Preprocessors.wxi
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/windows/install/includes/Preprocessors.wxi
do_sed "s/EiffelStudio [0-9][0-9]\.[0-9][0-9]/EiffelStudio $to_version/g" $EIFFEL_SRC/Delivery/scripts/windows/install/includes/Preprocessors.wxi

# $EIFFEL_SRC/Delivery/scripts/windows/set_aliases.btm
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/windows/set_aliases.btm

# $EIFFEL_SRC/Delivery/scripts/unix/README.unix
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/unix/README.unix
# $EIFFEL_SRC/Delivery/scripts/unix/make_all
do_sed "s/PorterPackage_[0-9][0-9]\.[0-9][0-9]/PorterPackage_$to_version/g" $EIFFEL_SRC/Delivery/scripts/unix/make_all

# $EIFFEL_SRC/Delivery/scripts/unix/make_for_platform
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/unix/make_for_platform

# $EIFFEL_SRC/Delivery/scripts/unix/make_images
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/unix/make_images

# $EIFFEL_SRC/Delivery/scripts/unix/set_aliases
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/scripts/unix/set_aliases


# $EIFFEL_SRC/Delivery/studio/config/windows/esvars.bat
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/Delivery/studio/config/windows/esvars.bat

# $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing
do_sed "s/Version [0-9][0-9]\.[0-9][0-9]/Version $to_version/g" $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing
do_sed "s/=[0-9][0-9]\.[0-9][0-9]/=to_version/g" $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing

# $EIFFEL_SRC/C/ipc/daemon/env.c
do_sed "s/Eiffel_[0-9][0-9]\.[0-9][0-9]/Eiffel_$to_version/g" $EIFFEL_SRC/C/ipc/daemon/env.c


# $EIFFEL_SRC/C/CONFIGS/*
doall_sed "s/'\.[0-9][0-9]\.[0-9][0-9]'/'\.$to_version'/g" $EIFFEL_SRC/C/CONFIGS/
 
# $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e
do_sed "s/\(major_version: .* = \)[0-9][0-9]/\1$to_version_major/g" $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e
do_sed "s/\(minor_version: .* = \)[0-9][0-9]/\1$to_version_minor/g" $EIFFEL_SRC/framework/environment/interface/eiffel_constants.e

