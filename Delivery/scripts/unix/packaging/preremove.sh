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
echo Removing precompiles

rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs
!GROK!THIS!