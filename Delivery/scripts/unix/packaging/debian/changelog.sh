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
$spitshell > $DEBIAN_DIR/changelog <<!GROK!THIS!
$PRODUCT ($VERSION-1) optional; urgency=low

  * Added Changelog for compliance with debian rules.

 -- $ise_name <$ise_email>  `date -R`
!GROK!THIS!
