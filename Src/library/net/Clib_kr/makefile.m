AR = lib 
CC = cl
CFLAGS = -Ogityb1 -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: net.lib

.c.obj:
	$(CC) -Fo$@ -c $(CFLAGS) $<

SMODE = network.c network_r.c

LSRCS = $(SMODE)

OBJS = \
	network.obj \
	network_r.obj

local_clean:: remove

all:: net.lib

local_realclean::
	$(RM) net.lib

net.lib: $(OBJS)
	$(RM) $@
	$(AR) /OUT:$@ $(OBJS) wsock32.lib
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32msc mkdir ..\spec\w32msc
	if not exist ..\spec\w32msc\lib mkdir ..\spec\w32msc\lib
	copy net.lib ..\spec\w32msc\lib\net.lib
