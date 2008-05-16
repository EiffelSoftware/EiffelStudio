
# Requirements when running make_unix_layout or make_*_package
if [ ! "$ISE_EIFFEL" ]; then
        echo '$ISE_EIFFEL not defined. Cannot continue'
        exit 1
fi

if [ ! "$ISE_PLATFORM" ]; then
        echo '$ISE_PLATFORM not defined. Cannot continue'
        exit 1
fi
echo "ISE_EIFFEL: $ISE_EIFFEL"
echo "ISE_PLATFORM: $ISE_PLATFORM"

# Extract EiffelStudio version
EC="$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec -version"
eval "$EC" > /dev/null
export VERSION=`$EC | sed "s/^[A-Za-z ]*\([0-9][0-9\.]*\).*/\1/"`
echo "VERSION: $VERSION"

# Common variables
MAJOR_NUMBER=`echo $VERSION | sed "s/^\([0-9]\).*/\1/"`
MINOR_NUMBER=`echo $VERSION | sed "s/^[0-9].\([0-9]\).*/\1/"`
PRODUCT=eiffelstudio-$MAJOR_NUMBER.$MINOR_NUMBER
PRODUCT_VERSION=$MAJOR_NUMBER$MINOR_NUMBER
UNIX_NAME=eiffelstudio-$PRODUCT_VERSION
LOG=`pwd`$0.log
PACKAGING_DIR=`pwd`/packaging
DEBIAN_DIR=$PACKAGING_DIR/debian
RPM_DIR=$PACKAGING_DIR/rpm
SVR_DIR=$PACKAGING_DIR/svr
DOCS_DIR=/usr/share/doc/$PRODUCT/docs
SUMMARY="EiffelStudio Integrated Development Environment"
NAME="Eiffel Software Inc. (http://www.eiffel.com)"
LICENSE=GPL
URL=http://www.eiffel.com
DOWNLOAD=http://download.origo.ethz.ch/download
KEY=A03DDC5C

# Shell
SPITSHELL='cat'
