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
Requires: gcc, gtk2-devel, gtk3-devel, /usr/lib/libXtst.so
%description
!GROK!THIS!

$SPITSHELL $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio.spec

$SPITSHELL >> $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

%files
/
!GROK!THIS!

