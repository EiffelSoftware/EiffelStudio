AR = lib
CC = cl
CTAGS = ctags
CFLAGS = -Zi -MDd -nologo  -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
MAKE = nmake
RANLIB = echo
RM = del
MV = copy

all:: clean support.lib

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJECTS = ext_internal.obj append_substr.obj

support.lib: $(OBJECTS)
	$(RM) $@
	$(AR) -DEBUGTYPE:BOTH -OUT:$@ $(OBJECTS)
	if not exist ..\..\spec mkdir ..\..\spec
	if not exist ..\..\spec\msc mkdir ..\..\spec\msc
	if not exist ..\..\spec\msc\lib mkdir ..\..\spec\msc\lib
	$(MV) $@ ..\..\spec\msc\lib\$@

clean:
	$(RM) support.lib $(OBJECTS)
