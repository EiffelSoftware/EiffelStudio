SHELL = /bin/sh
CC= cc
AR = ar rc
CFLAGS = -O   -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include
LDFLAGS = 
LIBS = -lsocket -lnsl -lm
MAKE = make
MKDEP = : $(DPFLAGS) --
MV = /usr/5bin/mv
RANLIB = :
RM = /usr/5bin/rm -f

.c.o:
	$(CC) $(CFLAGS) -D$(PLATFORM) -c $<

OBJECTS = datetime.o

libdatetime.a: $(OBJECTS)
	mkdir -p ../spec/$(PLATFORM)/lib
	$(RM) $@
	$(AR) $@ $(OBJECTS)
	$(MV) $@ ../spec/$(PLATFORM)/lib
	$(RANLIB) ../spec/$(PLATFORM)/lib/$@
#	$(MAKE) clean

clean:
	$(RM) libdatetime.a $(OBJECTS) config.sh Makefile
