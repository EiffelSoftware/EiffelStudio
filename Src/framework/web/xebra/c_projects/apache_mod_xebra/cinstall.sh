~/xebra/httpd/bin/apachectl stop
~/xebra/httpd/bin/apxs -c -Wc,-ggdb -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
sudo ~/xebra/httpd/bin/apxs -i mod_xebra.la
~/xebra/httpd/bin/apachectl start
