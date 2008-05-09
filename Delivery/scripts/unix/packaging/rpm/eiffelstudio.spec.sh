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
$spitshell > $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

%define _topdir $RPM_DIR
%define _tmppath $RPM_DIR/tmp
%define _use_internal_dependency_generator 0

Summary: $summary
Name: $PRODUCT
Version: $VERSION
Release: 1
License: $license
Group: Development/Tools
Source: $download
URL: $url
Vendor: $ise_name
Packager: $ise_name
BuildRoot: $RPM_DIR/eiffelstudio
Requires: gcc, gtk2-devel, /usr/lib/libXtst.so
%description
!GROK!THIS!

$spitshell $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio.spec

$spitshell >> $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

%files
/

%post
set -e

export ISE_EIFFEL=""
export ISE_PLATFOR=""

if [ "x\$DISPLAY" = "x" ]; then
	echo Please run make_install in /usr/share/$PRODUCT to make precompiles
else
	WIZARD=/usr/lib/eiffelstudio-6.2/studio/wizards/others/precompile
        \$WIZARD/spec/unix/wizard \$WIZARD
fi

%preun
set -e

echo Removing precompiles
rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs

!GROK!THIS!

