AR = tlib 
CC = bcc32
CFLAGS = -O2 -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: network.lbb wnetwork.lbb

.c.obb:
	$(CC) -o$@ -c $(CFLAGS) $<

SMODE = network.c networkr.c

LSRCS = $(SMODE)

OBJS = \
	network.obb \
	networkr.obb

WOBJS = \
	wnetwork.obb \
	wnetworkr.obb

wnetwork.c: network.c
	$(RM) wnetwork.c
	$(LN) network.c wnetwork.c


wnetwork.obb: wnetwork.c bitmask.h
	$(CC) -o$@ -c $(CFLAGS) -DWORKBENCH $*.c


wnetworkr.c: networkr.c
	$(RM) wnetworkr.c
	$(LN) networkr.c wnetworkr.c

wnetworkr.obb: wnetworkr.c
	$(CC) -o$@ -c $(CFLAGS) -DWORKBENCH $*.c


local_clean:: remove

all:: network.lbb

local_realclean::
	$(RM) network.lbb

network.lbb: $(OBJS)
	$(RM) $@
	$(AR) $@ /c +networkr.obb +network.obb
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32bcc mkdir ..\spec\w32bcc
	if not exist ..\spec\w32bcc\lib mkdir ..\spec\w32bcc\lib
	copy network.lbb ..\spec\w32bcc\lib\network.lib

all:: wnetwork.lbb

local_realclean::
	$(RM) wnetwork.lbb

wnetwork.lbb: $(WOBJS)
	$(RM) $@
	$(AR) $@ /c +wnetworkr.obb +wnetwork.obb
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32bcc mkdir ..\spec\w32bcc
	if not exist ..\spec\w32bcc\lib mkdir ..\spec\w32bcc\lib
	copy wnetwork.lbb ..\spec\w32bcc\lib\wnetwork.lib
