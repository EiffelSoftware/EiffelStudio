#!/bin/bash

# Setup environment, and remaining installation steps
cd workspace
mkdir home
export HOME=$(pwd)/home
export XDG_DATA_HOME=${HOME}/.local/share
mkdir -p ${XDG_DATA_HOME}

echo Install the dotnet environment
curl -sSL -o dotnet-install.sh https://dot.net/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
export DOTNET_CLI_HOME=${HOME}
export DOTNET_ROOT=${DOTNET_CLI_HOME}/.dotnet
./dotnet-install.sh --version latest --channel 6.0 --install-dir ${DOTNET_ROOT}
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# Build porterpackage
echo User: $(id -u):$(id -g)
echo + SVN_ISE_REPO=$SVN_ISE_REPO
echo + SVN_ISE_BRANCH=$SVN_ISE_BRANCH
echo + SVN_EIFFELSTUDIO_REPO=$SVN_EIFFELSTUDIO_REPO
echo + SVN_EIFFELSTUDIO_REPO_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION
if [ -z "$SVN_EIFFELSTUDIO_BRANCH" ]; then
	export SVN_EIFFELSTUDIO_BRANCH=/trunk
	echo ++SVN_EIFFELSTUDIO_BRANCH=$SVN_EIFFELSTUDIO_BRANCH
else
	echo + SVN_EIFFELSTUDIO_BRANCH=$SVN_EIFFELSTUDIO_BRANCH
fi
echo + INCLUDE_ENTERPRISE=$INCLUDE_ENTERPRISE
echo + ONLY_PORTERPACKAGE=$ONLY_PORTERPACKAGE
echo + MAKE_DELIVERY_ARGS=$MAKE_DELIVERY_ARGS

export DELIV_DIR=$1
echo = DELIV_DIR=$DELIV_DIR
if [ ! -d "$DELIV_DIR" ]; then
	echo Create $DELIV_DIR
	mkdir -p $DELIV_DIR
fi
if [ ! -d "$DELIV_DIR/output" ]; then
	echo Create $DELIV_DIR/output
	mkdir -p $DELIV_DIR/output
fi


echo Install EiffelStudio
if [ -z "$EIFFEL_SETUP_CHANNEL" ]; then
	export EIFFEL_SETUP_CHANNEL=nightly
fi
if [ -d /home/eiffel/Eiffel ]; then
	ls -la  /home/eiffel/Eiffel
else
	mkdir -p /home/eiffel/Eiffel
fi
if [ -d /home/eiffel/Eiffel/${EIFFEL_SETUP_CHANNEL}/studio ]; then
	echo "Already installed!"
else
	echo Installing nighlty release from eiffel.org/setup.
	curl -sSL https://www.eiffel.org/setup/install.sh | bash -s -- --channel ${EIFFEL_SETUP_CHANNEL} --platform ${ISE_PLATFORM} --install-dir /home/eiffel/Eiffel/${EIFFEL_SETUP_CHANNEL} --dir /home/eiffel
fi

# Define Eiffel environment variables
export ISE_EIFFEL=/home/eiffel/Eiffel/${EIFFEL_SETUP_CHANNEL}
export ISE_LIBRARY=$ISE_EIFFEL
export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin

export ORIGO_SVN_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION

echo = ISE_EIFFEL=$ISE_EIFFEL

# Initialization
export PATH=$PATH:.
if [ -z "$SVN_EIFFELSTUDIO_REPO" ]; then
	export SVN_EIFFELSTUDIO_REPO=https://svn.eiffel.com
fi
export DEFAULT_ORIGO_SVN_ROOT=$SVN_EIFFELSTUDIO_REPO
echo DEFAULT_ORIGO_SVN_ROOT=$DEFAULT_ORIGO_SVN_ROOT

# TODO: remove thє following export as this should not be useful...
export DEFAULT_ORIGO_SVN=$DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH
echo DEFAULT_ORIGO_SVN=$DEFAULT_ORIGO_SVN

if [ -z "$SVN_ISE_REPO" ]; then
	export SVN_ISE_REPO=svn://svn.ise/ise_svn
fi
if [ -z "$SVN_ISE_BRANCH" ]; then
	export DEFAULT_ISE_SVN=$SVN_ISE_REPO/trunk
else
	export DEFAULT_ISE_SVN=$SVN_ISE_REPO$SVN_ISE_BRANCH
fi
echo = DEFAULT_ISE_SVN=$DEFAULT_ISE_SVN

echo Build PorterPackage in $DELIV_DIR
echo Use EiffelStudio svn url: $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH
echo Use ISE svn url: $DEFAULT_ISE_SVN

# Main
export DELIV_WORKSPACE=/home/eiffel/workspace

# save setup in setup.rc for convenience
echo export ISE_EIFFEL=$ISE_EIFFEL > ${DELIV_WORKSPACE}/setup.rc
echo export ISE_PLATFORM=$ISE_PLATFORM >> ${DELIV_WORKSPACE}/setup.rc
echo export DOTNET_ROOT=$DOTNET_ROOT >> ${DELIV_WORKSPACE}/setup.rc
echo export PATH=$PATH >> ${DELIV_WORKSPACE}/setup.rc

if [ -d "$DELIV_WORKSPACE/tmp" ]; then
	echo Clean $DELIV_WORKSPACE/tmp
	\rm -rf $DELIV_WORKSPACE/tmp
fi

echo Build delivery for $ISE_PLATFORM
echo revision: $ORIGO_SVN_REVISION
echo svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO$SVN_EIFFELSTUDIO_BRANCH/Src/Delivery/scripts/unix $DELIV_WORKSPACE/tmp
svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO$SVN_EIFFELSTUDIO_BRANCH/Src/Delivery/scripts/unix $DELIV_WORKSPACE/tmp

echo Get revision from source code
if [ ! "$ORIGO_SVN_REVISION" ]; then
	DELIV_REVISION=`$DELIV_WORKSPACE/tmp/set_version.sh $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH`
else
	if [ "$ORIGO_SVN_REVISION" = "HEAD" ]; then
		DELIV_REVISION=`$DELIV_WORKSPACE/tmp/set_version.sh $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH`
	else
		DELIV_REVISION=$ORIGO_SVN_REVISION
	fi
fi

echo Building for revision $DELIV_REVISION
DELIV_OUTPUT=$DELIV_DIR/output/${DELIV_REVISION}

# Clean previous porterpackage building
if [ -e "${DELIV_DIR}/output/last_revision_built" ]; then
	\rm -f $DELIV_DIR/output/last_revision_built
fi
if [ -d "${DELIV_OUTPUT}" ]; then
	\rm -rf ${DELIV_OUTPUT}
fi

# Create output folder
mkdir -p ${DELIV_OUTPUT}

DELIV_LOGDIR=$DELIV_OUTPUT/${DELIV_REVISION}_pp_logs/
if [ -d "$DELIV_LOGDIR" ]; then
	\rm -rf "$DELIV_LOGDIR"
fi
mkdir -p "$DELIV_LOGDIR"

cd $DELIV_WORKSPACE/tmp
STUDIO_PORTERPACKAGE_TAR=$DELIV_OUTPUT/PorterPackage_${DELIV_REVISION}.tar
if [ -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
	echo Reuse $STUDIO_PORTERPACKAGE_TAR
	tar xf "$STUDIO_PORTERPACKAGE_TAR"
fi
if [ ! -d "PorterPackage" ]; then
	if [ "$INCLUDE_ENTERPRISE" == "true" ]; then
		echo Build Standard+Enterprise PorterPackage ...
		./make_delivery all $MAKE_DELIVERY_ARGS
	else
		echo Build Standard PorterPackage ...
		./make_delivery $MAKE_DELIVERY_ARGS
	fi
	echo Copy log files to $DELIV_LOGDIR
	cp *.log $DELIV_LOGDIR/.
fi
if [ -d "PorterPackage" ]; then
	if [ ! -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
		echo Create tar archive $STUDIO_PORTERPACKAGE_TAR .
		tar cvf $STUDIO_PORTERPACKAGE_TAR PorterPackage
	fi
	echo PorterPackage is ready: $STUDIO_PORTERPACKAGE_TAR
	ls -la $DELIV_OUTPUT
	echo ${DELIV_REVISION} > $DELIV_DIR/output/last_revision_built
	echo content of $DELIV_DIR/output/
	ls -la $DELIV_DIR/output/
else
	echo Missing PorterPackage!
fi
