$SPITSHELL > $DEBIAN_DIR/control <<!GROK!THIS!
Source: $PRODUCT
Maintainer: $NAME

Package: $PRODUCT
Section: devel
Priority: optional
Architecture: any
Depends: gcc, libatk1.0-0, libc6, libglib2.0-0, libgtk2.0-0, libgtk2.0-dev, libgtk-3-dev, libpango1.0-0, libx11-6, libxtst-dev, libxtst6, libssl-dev
Recommends: xdg-utils
Description: $SUMMARY
!GROK!THIS!

sed -e "s/^\(.\+\)$/ \1/" -e "s/^$/ ./" $PACKAGING_DIR/description >> $DEBIAN_DIR/control

$SPITSHELL >> $DEBIAN_DIR/control <<!GROK!THIS!
