SHELL = /bin/sh
CC = cc
CFLAGS = -O   -DWORKBENCH -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include
LDFLAGS = 
LIBS = -lnsl -lm
MAKE = make
MV = /bin/mv
RANLIB = :
RM = /bin/rm -f

.c.o:
	$(CC) $(CFLAGS) -c $<

all: test

test: main.o
	$(CC) -o test main.o EIFGEN/W_code/libtest.a -lm
