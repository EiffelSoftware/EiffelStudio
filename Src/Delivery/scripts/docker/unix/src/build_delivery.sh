#!/bin/bash

export DELIV_DIR=$1

# Initialization
export PATH=$PATH:.
export DEFAULT_ORIGO_SVN_ROOT=$SVN_EIFFELSTUDIO_REPO
export DEFAULT_ISE_SVN=$SVN_ISE_REPO/trunk

echo Build delivery $STUDIO_VERSION_MAJOR_MINOR in $DELIV_DIR
echo Use EiffelStudio svn repository: $DEFAULT_ORIGO_SVN_ROOT

# Main
if [ -d "$DELIV_DIR" ]; then
	echo Reuse $DELIV_DIR
else
	echo Create $DELIV_DIR
	mkdir -p $DELIV_DIR
fi
if [ -d "$DELIV_DIR/output" ]; then
	echo Reuse $DELIV_DIR/output
else
	echo Create $DELIV_DIR/output
	mkdir -p $DELIV_DIR/output
fi

if [ -d "$DELIV_DIR/scripts" ]; then
	echo Clean $DELIV_DIR/scripts
	\rm -rf $DELIV_DIR/scripts
fi

echo Build delivery for $ISE_PLATFORM
echo svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO/trunk/Src/Delivery/scripts $DELIV_DIR/scripts
svn checkout --config-option config:miscellany:use-commit-times=yes $SVN_EIFFELSTUDIO_REPO/trunk/Src/Delivery/scripts $DELIV_DIR/scripts

cd $DELIV_DIR/scripts/unix
if [ -f "$DELIV_DIR/output/PorterPackage.tgz" ]; then
	echo Reuse $DELIV_DIR/output/PorterPackage.tgz
	tar xzf "$DELIV_DIR/output/PorterPackage.tgz"
fi
if [ ! -d "PorterPackage" ]; then
	echo Build PorterPackage ...
	./make_delivery
fi
if [ -d "PorterPackage" ]; then
	if [ ! -f "$DELIV_DIR/output/PorterPackage.tgz" ]; then
		tar czvf $DELIV_DIR/output/PorterPackage.tgz PorterPackage
	fi
	cd PorterPackage
	echo Use PorterPackage with ISE_PLATFORM=$ISE_PLATFORM ...
	ls -la
	./compile_exes $ISE_PLATFORM
	./make_images $ISE_PLATFORM
	mv Eiffel*.tar.bz2 $DELIV_DIR/output
else
	echo Missing PorterPackage!
fi

