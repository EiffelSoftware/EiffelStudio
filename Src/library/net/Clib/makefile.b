AR = tlib 
CC = bcc32
CFLAGS = -O2 -I$(EIFFEL5)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: clean net.lib

.c.obj:
	$(CC) -c $(CFLAGS) $<

SMODE = network.c network_r.c hostname.c syncpoll.c storable.c

LSRCS = $(SMODE)

OBJS = \
	network.obj \
	network_r.obj \
	hostname.obj \
	syncpoll.obj \
	storable.obj

clean:
	$(RM) *.obj

net.lib: $(OBJS)
	$(RM) $@
	$(AR) $@ /c +network_r.obj +network.obj +hostname.obj +syncpoll.obj +storable.obj
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\bcc mkdir ..\spec\bcc
	if not exist ..\spec\bcc\lib mkdir ..\spec\bcc\lib
	copy net.lib ..\spec\bcc\lib\net.lib
