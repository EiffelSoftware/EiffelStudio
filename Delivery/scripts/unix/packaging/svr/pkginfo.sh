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
$spitshell > $SVR_DIR/pkginfo <<!GROK!THIS!
PKG="$UNIX_NAME"
NAME="EiffelStudio $MAJOR_NUMBER.$MINOR_NUMBER"
ARCH="`uname -p`"
VERSION="$VERSION"
VENDOR="$ise_name"
CATEGORY="application"
DESC="$summary"
CLASSES="none"
DISPLAY=""
BASE_PREC=""
VISION2_PREC=""
!GROK!THIS!
