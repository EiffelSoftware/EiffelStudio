
# set the include path found by configure
INCLUDES = $(all_includes) -I/home/fabioz/local/eiffel_src/64dev/C/run-time \
	-I/home/fabioz/local/eiffel_src/64dev/C/run-time/include

# the library search path.
bin_PROGRAMS = client server
server_SOURCES = server.c xebrasockets.c xebrasockets.h
client_SOURCES = client.c xebrasockets.c xebrasockets.h
AM_CFLAGS = -g

