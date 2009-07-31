sudo ../../httpd/bin/apachectl stop
../../httpd/bin/apxs -c -Wc,-ggdb mod_xebra.c mod_xebra.h
../../httpd/bin/apxs -i mod_xebra.la
sudo ../../httpd/bin/apachectl start
