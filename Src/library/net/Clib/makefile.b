AR = tlib 
CC = bcc32
CFLAGS = -O2 -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: net.lib

.c.obb:
	$(CC) -o$@ -c $(CFLAGS) $<

SMODE = network.c networkr.c storable.c

LSRCS = $(SMODE)

OBJS = \
	network.obj \
	networkr.obj \
	storable.obj

local_clean:: remove

all:: net.lib

local_realclean::
	$(RM) net.lib

net.lib: $(OBJS)
	$(RM) $@
	$(AR) $@ /c +networkr.obj +network.obj +storable.obj
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32bcc mkdir ..\spec\w32bcc
	if not exist ..\spec\w32bcc\lib mkdir ..\spec\w32bcc\lib
	copy net.lib ..\spec\w32bcc\lib\net.lib
