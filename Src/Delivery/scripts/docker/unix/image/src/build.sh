#!/bin/bash

# Delivery building

export DELIV_WS_DIR=$1
export DELIV_PORTERPACKAGE_TAR=$2
export DELIV_IMAGE_OUTPUT=$3

if [ ! -d "$DELIV_WS_DIR" ]; then
	echo Create $DELIV_WS_DIR
	mkdir -p $DELIV_WS_DIR
fi


# Setup environment, and remaining installation steps

cd $DELIV_WS_DIR
echo Install dotnet environment
curl -sSL -o dotnet-install.sh https://dot.net/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
export DOTNET_CLI_HOME=${HOME}
export DOTNET_ROOT=${DOTNET_CLI_HOME}/.dotnet
./dotnet-install.sh --version latest --channel 6.0 --install-dir $(DOTNET_ROOT)
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools



echo Build delivery ${DELIV_PORTERPACKAGE_TAR} DELIV_WS_DIR=$DELIV_WS_DIR

cd $DELIV_WS_DIR
STUDIO_PORTERPACKAGE_TAR=$DELIV_PORTERPACKAGE_TAR
if [ -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
	tar xf "$STUDIO_PORTERPACKAGE_TAR"
fi
if [ -d "PorterPackage" ]; then
	# Get revision!
	DELIV_REVISION=`grep -s "FILE_SVN_REVISION=" PorterPackage/set_aliases | head -1 | sed -e 's/FILE_SVN_REVISION=\([0-9][0-9]*\).*/\1/'`

	echo - Platform: $ISE_PLATFORM
	echo - Revision: $DELIV_REVISION
	if [ ! -d "${DELIV_IMAGE_OUTPUT}" ]; then
		mkdir -p ${DELIV_IMAGE_OUTPUT}
	fi

	# Initialization
	export PATH=$PATH:.

	# save setup in setup.rc for convenience
	echo export ISE_EIFFEL=$ISE_EIFFEL > ${DELIV_WS_DIR}/setup.rc
	echo export ISE_PLATFORM=$ISE_PLATFORM >> ${DELIV_WS_DIR}/setup.rc
	echo export DOTNET_ROOT=$DOTNET_ROOT >> ${DELIV_WS_DIR}/setup.rc
	echo export PATH=$PATH >> ${DELIV_WS_DIR}/setup.rc

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

