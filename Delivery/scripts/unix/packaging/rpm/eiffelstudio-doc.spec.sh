$SPITSHELL > $RPM_DIR/eiffelstudio-doc.spec <<!GROK!THIS!

%define _topdir $RPM_DIR
%define _tmppath $RPM_DIR/tmp
%define _use_internal_dependency_generator 0

Summary: $SUMMARY (Documentation)
Name: $PRODUCT-doc
Version: $VERSION
Release: 1
License: $LICENSE
Group: Development/Tools
BuildArch: noarch
Source: $DOWNLOAD
URL: $URL
Vendor: $NAME
Packager: $NAME
BuildRoot: $RPM_DIR/eiffelstudio-doc
%description
!GROK!THIS!

$SPITSHELL $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio-doc.spec

$SPITSHELL >> $RPM_DIR/eiffelstudio-doc.spec <<!GROK!THIS!
%files
/
!GROK!THIS!

