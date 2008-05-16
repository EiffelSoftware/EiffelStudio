$SPITSHELL > $SVR_DIR/preremove <<!GROK!THIS!
#!/bin/sh
set -e

echo Removing precompiles
rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs

exit 0;

!GROK!THIS!

chmod +x $SVR_DIR/preremove
