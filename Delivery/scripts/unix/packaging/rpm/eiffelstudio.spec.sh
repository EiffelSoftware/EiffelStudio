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
Summary: $summary
Name: $PRODUCT
Version: $VERSION
Release: 1
License: $license
Group: Development/Tools
Source: $download
URL: $url
Vendor: $ise_name
Packager: $ise_name <$ise_email>
BuildRoot: $RPM_DIR/eiffelstudio
%description
!GROK!THIS!

$spitshell $PACKAGING_DIR/description >> $RPM_DIR/eiffelstudio.spec

$spitshell >> $RPM_DIR/eiffelstudio.spec <<!GROK!THIS!

%files
/

%post
`sh $PACKAGING_DIR/postinstall.sh`

%preun
`sh $PACKAGING_DIR/preremove.sh`
!GROK!THIS!

