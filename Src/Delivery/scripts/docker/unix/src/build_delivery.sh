#!/bin/bash

export DELIV_DIR=$1
if [ ! -d "$DELIV_DIR" ]; then
	echo Create $DELIV_DIR
	mkdir -p $DELIV_DIR
fi
if [ ! -d "$DELIV_DIR/output" ]; then
	echo Create $DELIV_DIR/output
	mkdir -p $DELIV_DIR/output
fi

echo DELIV_DIR=$DELIV_DIR

echo Install EiffelStudio
if [ -z "$EIFFEL_SETUP_CHANNEL" ]; then
	export EIFFEL_SETUP_CHANNEL=nightly
fi
if [ -d /home/eiffel/Eiffel-${EIFFEL_SETUP_CHANNEL}/studio ]; then
	echo "Already installed!"
else
	curl -sSL https://www.eiffel.org/setup/install.sh | bash -s -- --channel ${EIFFEL_SETUP_CHANNEL} --platform ${ISE_PLATFORM} --install-dir /home/eiffel/Eiffel-${EIFFEL_SETUP_CHANNEL} --dir /home/eiffel
fi

# Define Eiffel environment variables
export ISE_EIFFEL=/home/eiffel/Eiffel-${EIFFEL_SETUP_CHANNEL}
export ISE_LIBRARY=$ISE_EIFFEL
export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin


export ORIGO_SVN_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION
if [ -z "$SVN_EIFFELSTUDIO_BRANCH" ]; then 
	export SVN_EIFFELSTUDIO_BRANCH=/trunk
fi

echo SVN_EIFFELSTUDIO_BRANCH=$SVN_EIFFELSTUDIO_BRANCH
echo SVN_ISE_BRANCH=$SVN_ISE_BRANCH
echo ONLY_PORTERPACKAGE=$ONLY_PORTERPACKAGE
echo INCLUDE_ENTERPRISE=$INCLUDE_ENTERPRISE

# Initialization
export PATH=$PATH:.
if [ ! -z "$SVN_EIFFELSTUDIO_REPO" ]; then
	export DEFAULT_ORIGO_SVN_ROOT=$SVN_EIFFELSTUDIO_REPO
fi
if [ ! -r "$SVN_ISE_REPO" ]; then
	if [ -z "$SVN_ISE_BRANCH" ]; then
		export DEFAULT_ISE_SVN=$SVN_ISE_REPO/trunk
	else
		export DEFAULT_ISE_SVN=$SVN_ISE_REPO$SVN_ISE_BRANCH
	fi
	echo DEFAULT_ISE_SVN=$DEFAULT_ISE_SVN
fi


if [ "$ONLY_PORTERPACKAGE" = "true" ]; then
	echo Build PorterPackage in $DELIV_DIR
else
	echo Build delivery in $DELIV_DIR
fi
echo Use EiffelStudio svn repository: $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH

# Main

if [ -d "$DELIV_DIR/scripts-unix" ]; then
	echo Clean $DELIV_DIR/scripts-unix
	\rm -rf $DELIV_DIR/scripts-unix
fi

echo Build delivery for $ISE_PLATFORM 
echo revision: $ORIGO_SVN_REVISION
echo svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO$SVN_EIFFELSTUDIO_BRANCH/Src/Delivery/scripts/unix $DELIV_DIR/scripts-unix
svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO$SVN_EIFFELSTUDIO_BRANCH/Src/Delivery/scripts/unix $DELIV_DIR/scripts-unix

echo Get revision from source code
if [ ! "$ORIGO_SVN_REVISION" ]; then
	DELIV_REVISION=`$DELIV_DIR/scripts-unix/set_version.sh $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH`
else
	if [ "$ORIGO_SVN_REVISION" = "HEAD" ]; then
		DELIV_REVISION=`$DELIV_DIR/scripts-unix/set_version.sh $DEFAULT_ORIGO_SVN_ROOT$SVN_EIFFELSTUDIO_BRANCH`
	else
		DELIV_REVISION=$ORIGO_SVN_REVISION
	fi
fi

echo Building for revision $DELIV_REVISION
DELIV_OUTPUT=$DELIV_DIR/output/${DELIV_REVISION}
mkdir -p ${DELIV_OUTPUT}
echo ${DELIV_REVISION} > $DELIV_DIR/output/last_revision_built

DELIV_LOGDIR=$DELIV_OUTPUT/${DELIV_REVISION}_${ISE_PLATFORM}_logs/
if [ -d "$DELIV_LOGDIR" ]; then
	\rm -rf "$DELIV_LOGDIR"
fi
mkdir -p "$DELIV_LOGDIR"

cd $DELIV_DIR/scripts-unix
STUDIO_PORTERPACKAGE_TAR=$DELIV_OUTPUT/PorterPackage_${DELIV_REVISION}.tar
if [ -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
	echo Reuse $STUDIO_PORTERPACKAGE_TAR
	tar xf "$STUDIO_PORTERPACKAGE_TAR"
fi
if [ ! -d "PorterPackage" ]; then
	if [ "$INCLUDE_ENTERPRISE" == "true" ]; then
		echo Build Standard+Enterprise PorterPackage ...
		./make_delivery all
	else
		echo Build Standard PorterPackage ...
		./make_delivery
	fi
	cp *.log $DELIV_LOGDIR/.
	cp */*.log $DELIV_LOGDIR/.
fi
if [ -d "PorterPackage" ]; then
	if [ ! -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
		tar cvf $STUDIO_PORTERPACKAGE_TAR PorterPackage
	fi
	if [ "$ONLY_PORTERPACKAGE" == "true" ]; then
		echo PorterPackage is ready: $STUDIO_PORTERPACKAGE_TAR
	else
		cd PorterPackage
		echo Use PorterPackage with ISE_PLATFORM=$ISE_PLATFORM ...
		ls -la
		./compile_exes $ISE_PLATFORM
		./make_images $ISE_PLATFORM
		cp *.log $DELIV_LOGDIR/.
		mv Eiffel*.tar.bz2 $DELIV_OUTPUT/.
	fi
else
	echo Missing PorterPackage!
fi

