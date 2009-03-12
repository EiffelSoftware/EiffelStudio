
# set the include path found by configure
INCLUDES = $(all_includes) -I$(APACHE_SRC)/include/ \
	-I/usr/include/apr-1.0 -I$(EIFFEL_SRC)/C/run-time/ \
	-I$(EIFFEL_SRC)/C/run-time/include/

# the library search path.
lib_LTLIBRARIES = mod_xebra.la
mod_xebra_la_LDFLAGS = -avoid-version -module
mod_xebra_la_SOURCES = mod_xebra.c xebrasockets.c xebrasockets.h
AM_CFLAGS = -DLINUX=2 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -D_REENTRANT -pthread
