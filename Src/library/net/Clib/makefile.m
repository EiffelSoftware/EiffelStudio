AR = lib 
CC = cl
CFLAGS = -Ox -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: net.lib

.c.obj:
	$(CC) -o $@ -c $(CFLAGS) $<

SMODE = network.c network_r.c hostname.c syncpoll.c storable.c

LSRCS = $(SMODE)

OBJS = \
	network.obj network_r.obj hostname.obj syncpoll.obj storable.obj

local_clean:: remove

all:: net.lib

local_realclean::
	$(RM) net.lib

net.lib: $(OBJS)
	$(RM) $@
	$(AR) -OUT:$@ $(OBJS) wsock32.lib
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy wnet.lib ..\spec\msc\lib\wnet.lib
