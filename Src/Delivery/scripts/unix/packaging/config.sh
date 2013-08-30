#!/bin/sh
set -e

if [ $# != 2 ]; then
	echo Usage: config.sh platform source
	exit 1
fi

ISE_PLATFORM=$1
ISE_EIFFEL=$2

echo \$ISE_EIFFEL: $ISE_EIFFEL
echo \$ISE_PLATFORM: $ISE_PLATFORM

# Extract EiffelStudio version
EC="$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec -version"
eval "$EC" > /dev/null
export VERSION=`$EC | sed "s/^[A-Za-z ]*\([0-9][0-9\.]*\).*/\1/"`
echo \$VERSION: $VERSION

# Common variables
MAJOR_NUMBER=`echo $VERSION | sed "s/^\([0-9]*\).*/\1/"`
MINOR_NUMBER=`echo $VERSION | sed "s/^[0-9]*.\([0-9]*\).*/\1/"`
RELEASE=$MAJOR_NUMBER.$MINOR_NUMBER
RELEASE_SUFFIX=-$RELEASE
VERSION_SUFFIX=-$VERSION
PRODUCT=eiffelstudio$RELEASE_SUFFIX
# Unix name can not contain a dot
UNIX_NAME=eiffelstudio-$MAJOR_NUMBER$MINOR_NUMBER
PACKAGING_DIR=`pwd`/packaging
DEBIAN_DIR=$PACKAGING_DIR/debian
RPM_DIR=$PACKAGING_DIR/rpm
SVR_DIR=$PACKAGING_DIR/svr
DOCS_DIR=/usr/share/doc/$PRODUCT/docs
SUMMARY="EiffelStudio Integrated Development Environment"
NAME="Eiffel Software Inc. <manus@eiffel.com>"
LICENSE=GPL
URL=http://www.eiffel.com
DOWNLOAD=http://download.origo.ethz.ch/download
KEY=A03DDC5C
PASS_PHRASE=""

# Shell
SPITSHELL='cat'
