
# set the include path found by configure
INCLUDES = $(all_includes) -I/home/fabioz/cprojects/sockettest2/src \
	-I/usr/include/apr-1.0 -I/home/fabioz/local/apache_src/include \
	-I/usr/local/home/fabioz/eiffel_src/64dev/C/run-time/include/ -I/usr/local/home/fabioz/eiffel_src/64dev/C/run-time \
	-I/usr/include/apr-1.0

# the library search path.
lib_LTLIBRARIES = mod_xebra.la
mod_xebra_la_LDFLAGS = -avoid-version -module
mod_xebra_la_SOURCES = mod_xebra.c xebrasockets.c
AM_CFLAGS = -DLINUX=2 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -D_REENTRANT -pthread
