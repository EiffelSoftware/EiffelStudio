#!/bin/bash

export DELIV_DIR=$1
export DELIV_PORTERPACKAGE_TAR=$2

echo Build delivery ${DELIV_PORTERPACKAGE_TAR} DELIV_DIR=$DELIV_DIR

if [ ! -d "$DELIV_DIR" ]; then
	echo Create $DELIV_DIR
	mkdir -p $DELIV_DIR
fi


cd $DELIV_DIR
STUDIO_PORTERPACKAGE_TAR=$DELIV_PORTERPACKAGE_TAR
if [ -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
	tar xf "$STUDIO_PORTERPACKAGE_TAR"
fi
if [ -d "PorterPackage" ]; then
	# Get revision!
	DELIV_REVISION=`grep -s "FILE_SVN_REVISION=" PorterPackage/set_aliases | head -1 | sed -e 's/FILE_SVN_REVISION=\([0-9][0-9]*\).*/\1/'`

	echo - Platform: $ISE_PLATFORM 
	echo - Revision: $DELIV_REVISION
	DELIV_IMAGE_OUTPUT=$DELIV_DIR/image/
	if [ ! -d "${DELIV_IMAGE_OUTPUT}" ]; then
		mkdir -p ${DELIV_IMAGE_OUTPUT}
	fi

	# Initialization
	export PATH=$PATH:.

	DELIV_LOGDIR=$DELIV_IMAGE_OUTPUT/${DELIV_REVISION}_${ISE_PLATFORM}_logs
	if [ -d "$DELIV_LOGDIR" ]; then
		\rm -rf "$DELIV_LOGDIR"
	fi
	mkdir -p "$DELIV_LOGDIR"

	cd PorterPackage
	echo Use PorterPackage with ISE_PLATFORM=$ISE_PLATFORM ...
	ls -la
	./compile_exes $ISE_PLATFORM
	./make_images $ISE_PLATFORM
	cp compile.log $DELIV_LOGDIR/.
	mv Eiffel*.tar.bz2 $DELIV_IMAGE_OUTPUT/.
else
	echo Missing or bad PorterPackage $DELIV_PORTERPACKAGE_TAR !
fi

