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
$spitshell <<!GROK!THIS!
set -e
echo
echo Welcome to the EiffelStudio installer
echo

echo "Do you want to precompile EiffelBase (required to compile examples) ? [y/n]"
read prec_base
echo "Do you want to precompile EiffelVision (might take a while) ? [y/n]"
read prec_vision2

INIT_DIR=`pwd`
export ISE_EIFFEL=""
export ISE_PLATFORM=""

if [ "\$prec_base" = "y" ]; then
	echo Precompile EiffelBase
	cd /usr/lib/$PRODUCT/precomp/spec/unix
	rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs/base*
	/usr/bin/ec -precompile -config base.ecf -c_compile -clean
	/usr/bin/ec -precompile -config base-mt.ecf -c_compile -clean
fi
if [ "\$prec_vision2" = "y" ]; then
	echo Precompile EiffelVision
	cd /usr/lib/$PRODUCT/precomp/spec/unix
	rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs/vision2
	/usr/bin/ec -precompile -config vision2.ecf -c_compile -clean
	/usr/bin/ec -precompile -config vision2-mt.ecf -c_compile -clean
fi

cd $INIT_DIR
!GROK!THIS!