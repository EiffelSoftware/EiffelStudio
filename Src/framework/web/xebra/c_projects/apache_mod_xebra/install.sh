sudo ../../httpd/bin/apachectl stop
../../httpd/bin/apxs -c -Wc,-ggdb -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
sudo ../../httpd/bin/bin/apxs -i mod_xebra.la
sudo ../../httpd/bin/apachectl start
