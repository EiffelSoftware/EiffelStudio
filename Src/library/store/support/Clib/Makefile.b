AR = $(ISE_EIFFEL)\BCC55\bin\tlib.exe
CC = $(ISE_EIFFEL)\BCC55\bin\bcc32.exe
CFLAGS = -O2 -I$(ISE_EIFFEL)\bench\spec\$(ISE_PLATFORM)\include -I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib
RANLIB = echo
RM = -del
MV = copy

all:: clean support.lib

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJECTS = ext_internal.obj append_substr.obj

support.lib: $(OBJECTS)
	$(RM) $@
	$(AR) $@ +ext_internal.obj +append_substr.obj
	if not exist ..\..\spec mkdir ..\..\spec
	if not exist ..\..\spec\bcb mkdir ..\..\spec\bcb
	if not exist ..\..\spec\bcb\lib mkdir ..\..\spec\bcb\lib
	$(MV) $@ ..\..\spec\bcb\lib\$@

clean:
	$(RM) support.lib $(OBJECTS)
