AR = tlib
CC = bcc32
CFLAGS = -O2 -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
MAKE = make
RANLIB = echo
RM = del
MV = copy

all:: clean support.lib

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJECTS = ext_internal.obj append_substr.obj

support.lib: $(OBJECTS)
	$(RM) $@
	$(AR) $@ /c +ext_internal.obj +append_substr.obj
	if not exist ..\..\spec mkdir ..\..\spec
	if not exist ..\..\spec\bcc mkdir ..\..\spec\bcc
	if not exist ..\..\spec\bcc\lib mkdir ..\..\spec\bcc\lib
	$(MV) $@ ..\..\spec\bcc\lib\$@

clean:
	$(RM) support.lib $(OBJECTS)
