AR = lib 
CC = cl
CFLAGS = -Ogityb1 -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: network.lmb wnetwork.lmb

.c.obm:
	$(CC) -Fo$@ -c $(CFLAGS) $<

SMODE = network.c network_r.c

LSRCS = $(SMODE)

OBJS = \
	network.obm \
	network_r.obm

WOBJS = \
	wnetwork.obm \
	wnetwork_r.obm

wnetwork.c: network.c
	$(RM) wnetwork.c
	$(LN) network.c wnetwork.c


wnetwork.obm: wnetwork.c bitmask.h
	$(CC) -Fo$@ -c $(CFLAGS) -DWORKBENCH $*.c


wnetwork_r.c: network_r.c
	$(RM) wnetwork_r.c
	$(LN) network_r.c wnetwork_r.c

wnetwork_r.obm: wnetwork_r.c
	$(CC) -Fo$@ -c $(CFLAGS) -DWORKBENCH $*.c


local_clean:: remove

all:: network.lmb

local_realclean::
	$(RM) network.lmb

network.lmb: $(OBJS)
	$(RM) $@
	$(AR) /OUT:$@ network_r.obm network.obm wsock32.lib
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
	$(AR) /OUT:$@ wnetwork_r.obm wnetwork.obm wsock32.lib
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\w32msc mkdir ..\spec\w32msc
	if not exist ..\spec\w32msc\lib mkdir ..\spec\w32msc\lib
	copy wnetwork.lmb ..\spec\w32msc\lib\wnetwork.lib
