apachectl stop
apxs -c -Wc,-ggdb -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
apxs -i mod_xebra.la
apachectl start
