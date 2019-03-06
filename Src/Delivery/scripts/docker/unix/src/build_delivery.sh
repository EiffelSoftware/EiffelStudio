#!/bin/bash

export DELIV_DIR=$1
export ORIGO_SVN_REVISION=$SVN_EIFFELSTUDIO_REPO_REVISION

# Initialization
export PATH=$PATH:.
export DEFAULT_ORIGO_SVN_ROOT=$SVN_EIFFELSTUDIO_REPO
export DEFAULT_ISE_SVN=$SVN_ISE_REPO/trunk

echo ONLY_PORTERPACKAGE=$ONLY_PORTERPACKAGE
if [ "$ONLY_PORTERPACKAGE" = "true" ]; then
	echo Build PorterPackage for $STUDIO_VERSION_MAJOR_MINOR in $DELIV_DIR
else
	echo Build delivery $STUDIO_VERSION_MAJOR_MINOR in $DELIV_DIR
fi
echo Use EiffelStudio svn repository: $DEFAULT_ORIGO_SVN_ROOT

# Main
if [ ! -d "$DELIV_DIR" ]; then
	echo Create $DELIV_DIR
	mkdir -p $DELIV_DIR
fi
if [ ! -d "$DELIV_DIR/output" ]; then
	echo Create $DELIV_DIR/output
	mkdir -p $DELIV_DIR/output
fi

if [ -d "$DELIV_DIR/scripts-unix" ]; then
	echo Clean $DELIV_DIR/scripts-unix
	\rm -rf $DELIV_DIR/scripts-unix
fi

echo Build delivery for $ISE_PLATFORM 
echo revision: $ORIGO_SVN_REVISION
echo svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO/trunk/Src/Delivery/scripts/unix $DELIV_DIR/scripts-unix
svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO/trunk/Src/Delivery/scripts/unix $DELIV_DIR/scripts-unix

echo Get revision from source code
if [ ! "$ORIGO_SVN_REVISION" ]; then
	DELIV_REVISION=`$DELIV_DIR/scripts-unix/set_version.sh $DEFAULT_ORIGO_SVN_ROOT`
else
	DELIV_REVISION=$ORIGO_SVN_REVISION
fi
echo Building for revision $DELIV_REVISION

cd $DELIV_DIR/scripts-unix
STUDIO_PORTERPACKAGE_TGZ=$DELIV_DIR/output/PorterPackage-${STUDIO_VERSION_MAJOR_MINOR}.${DELIV_REVISION}.tgz
if [ -f "$STUDIO_PORTERPACKAGE_TGZ" ]; then
	echo Reuse $STUDIO_PORTERPACKAGE_TGZ
	tar xzf "$STUDIO_PORTERPACKAGE_TGZ"
fi
if [ ! -d "PorterPackage" ]; then
	echo Build PorterPackage ...
	./make_delivery
fi
if [ -d "PorterPackage" ]; then
	if [ ! -f "$STUDIO_PORTERPACKAGE_TGZ" ]; then
		tar czvf $STUDIO_PORTERPACKAGE_TGZ PorterPackage
	fi
	if [ "$ONLY_PORTERPACKAGE" == "true" ]; then
		echo PorterPackage is ready: $STUDIO_PORTERPACKAGE_TGZ
	else
		cd PorterPackage
		echo Use PorterPackage with ISE_PLATFORM=$ISE_PLATFORM ...
		ls -la
		./compile_exes $ISE_PLATFORM
		./make_images $ISE_PLATFORM
		mv Eiffel*.tar.bz2 $DELIV_DIR/output
	fi
else
	echo Missing PorterPackage!
fi

