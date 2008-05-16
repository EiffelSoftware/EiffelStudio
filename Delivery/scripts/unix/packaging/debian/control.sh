$SPITSHELL > $DEBIAN_DIR/control <<!GROK!THIS!
Source: $PRODUCT
Maintainer: $NAME

Package: $PRODUCT
Section: devel
Priority: optional
Architecture: any
Depends: \${shlibs:Depends}, gcc, libgtk2.0-dev, libxtst-dev
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
