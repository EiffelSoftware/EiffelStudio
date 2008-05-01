case $CONFIG in
'')
	if test ! -f $PACKAGING_DIR/config.sh; then
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. $PACKAGING_DIR/config.sh
	;;
esac
case "$O" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
$spitshell > $DEBIAN_DIR/control <<!GROK!THIS!
Source: $PRODUCT
Maintainer: $ise_name <$ise_email>

Package: $PRODUCT
Section: devel
Priority: optional
Architecture: any
Depends: \${shlibs:Depends}
Description: $summary
 TODO: longer description of EiffelStudio


Package: $PRODUCT-doc
Section: doc
Priority: optional
Architecture: all
Depends: 
Description: $summary (Documentation)
 TODO: longer description of Eiffel Documentation
!GROK!THIS!