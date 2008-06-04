$SPITSHELL > $DEBIAN_DIR/control <<!GROK!THIS!
Source: $PRODUCT
Maintainer: $NAME

Package: $PRODUCT
Section: devel
Priority: optional
Architecture: any
Depends: gcc, libatk1.0-0, libc6, libglib2.0-0, libgtk2.0-0, libgtk2.0-dev, libpango1.0-0, libx11-6, libxtst-dev, libxtst6
Description: $SUMMARY
!GROK!THIS!

sed -e "s/^\(.\+\)$/ \1/" -e "s/^$/ ./" $PACKAGING_DIR/description >> $DEBIAN_DIR/control

$SPITSHELL >> $DEBIAN_DIR/control <<!GROK!THIS!


Package: $PRODUCT-doc
Section: doc
Priority: optional
Architecture: all
Depends: 
Description: $SUMMARY (Documentation)
!GROK!THIS!

sed -e "s/^\(.\+\)$/ \1/" -e "s/^$/ ./" $PACKAGING_DIR/description >> $DEBIAN_DIR/control
