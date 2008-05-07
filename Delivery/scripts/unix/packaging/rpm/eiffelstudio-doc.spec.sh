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
$spitshell > $RPM_DIR/eiffelstudio-doc.spec <<!GROK!THIS!
Summary: $summary (Documentation)
Name: $PRODUCT-doc
Version: $VERSION
Release: 1
License: $license
Group: Development/Tools
BuildArch: noarch
Source: $download
URL: $url
Vendor: $ise_name
Packager: $ise_name
BuildRoot: $RPM_DIR/eiffelstudio-doc
%description
!GROK!THIS!

$spitshell $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio-doc.spec

$spitshell >> $RPM_DIR/eiffelstudio-doc.spec <<!GROK!THIS!
%files
/
!GROK!THIS!

