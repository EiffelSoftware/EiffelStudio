AR= tlib
CC = bcc32
CFLAGS = -O2 -DEIF_BORLAND -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LIBS = 
MAKE = make
MV = copy
RANLIB = echo
RM = del

all:: clean datetime.lib

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJECTS = datetime.obj

datetime.lib: $(OBJECTS)
	$(RM) $@
	$(AR) $@ /c + datetime.obj
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\bcc mkdir ..\spec\bcc
	if not exist ..\spec\bcc\lib mkdir ..\spec\bcc\lib
	$(MV) $@ ..\spec\bcc\lib

clean:
	$(RM) datetime.lib $(OBJECTS)
