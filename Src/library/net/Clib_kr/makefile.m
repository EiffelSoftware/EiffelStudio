AR = lib 
CC = cl
CFLAGS = -Ogityb1 -I$(EIFFEL3)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: network.lmb wnetwork.lmb

.c.obm:
	$(CC) -Fo$@ -c $(CFLAGS) $<

SMODE = network.c networkr.c

LSRCS = $(SMODE)

OBJS = \
	network.obm \
	networkr.obm

WOBJS = \
	wnetwork.obm \
	wnetworkr.obm

wnetwork.c: network.c
	$(RM) wnetwork.c
	$(LN) network.c wnetwork.c


wnetwork.obm: wnetwork.c bitmask.h
	$(CC) -Fo$@ -c $(CFLAGS) -DWORKBENCH $*.c


wnetworkr.c: networkr.c
	$(RM) wnetworkr.c
	$(LN) networkr.c wnetworkr.c

wnetworkr.obm: wnetworkr.c
	$(CC) -Fo$@ -c $(CFLAGS) -DWORKBENCH $*.c


local_clean:: remove

all:: network.lmb

local_realclean::
	$(RM) network.lmb

network.lmb: $(OBJS)
	$(RM) $@
	$(AR) /OUT:$@ networkr.obm network.obm wsock32.lib
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32msc mkdir ..\spec\w32msc
	if not exist ..\spec\w32msc\lib mkdir ..\spec\w32msc\lib
	copy network.lmb ..\spec\w32msc\lib\network.lib

all:: wnetwork.lmb

local_realclean::
	$(RM) wnetwork.lmb

wnetwork.lmb: $(WOBJS)
	$(RM) $@
	$(AR) /OUT:$@ wnetworkr.obm wnetwork.obm wsock32.lib
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32msc mkdir ..\spec\w32msc
	if not exist ..\spec\w32msc\lib mkdir ..\spec\w32msc\lib
	copy wnetwork.lmb ..\spec\w32msc\lib\wnetwork.lib
