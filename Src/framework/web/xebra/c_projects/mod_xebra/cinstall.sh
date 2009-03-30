apachectl stop
apxs -c -Wc,-ggdb -I$EIFFEL_SRC/C/run-time -I$EIFFEL_SRC/C/run-time/include mod_xebra.c mod_xebra.h
apxs -i mod_xebra.la
apachectl start
