$SPITSHELL > $SVR_DIR/request <<!GROK!THIS!
#!/bin/sh
set -e

echo
echo "After package is installed, run /usr/share/$PRODUCT/make_install with root privileges to build precompiles"
echo "(Press any key to continue)"
read usrk
echo

!GROK!THIS!

chmod +x $SVR_DIR/request
