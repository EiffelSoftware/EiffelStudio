AR = lib 
CC = cl
CFLAGS = -nologo -Ox -I$(EIFFEL5)\bench\spec\$(PLATFORM)\include
LN = copy
MAKE = make
RANLIB = echo
RM = del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: clean net.lib

.c.obj:
	$(CC) -o $@ -c $(CFLAGS) $<

SMODE = network.c network_r.c hostname.c syncpoll.c storable.c

LSRCS = $(SMODE)

OBJS = \
	network.obj network_r.obj hostname.obj syncpoll.obj storable.obj

clean:
	del *.obj

net.lib: $(OBJS)
	$(RM) $@
	$(AR) -OUT:$@ $(OBJS)
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib\$@
