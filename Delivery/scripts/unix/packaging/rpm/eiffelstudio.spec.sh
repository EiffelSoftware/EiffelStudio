$SPITSHELL > $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

%define _topdir $RPM_DIR
%define _tmppath $RPM_DIR/tmp
%define _use_internal_dependency_generator 0

Summary: $SUMMARY
Name: $PRODUCT
Version: $VERSION
Release: 1
License: $LICENSE
Group: Development/Tools
Source: $DOWNLOAD
URL: $URL
Vendor: $NAME
Packager: $NAME
BuildRoot: $RPM_DIR/eiffelstudio
Requires: gcc, gtk2-devel, /usr/lib/libXtst.so
%description
!GROK!THIS!

$SPITSHELL $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio.spec

$SPITSHELL >> $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

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

