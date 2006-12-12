AR = $(ISE_EIFFEL)\BCC55\bin\tlib 
CC = $(ISE_EIFFEL)\BCC55\bin\bcc32
CFLAGS = -O2 -I$(ISE_EIFFEL)\studio\spec\windows\include -I$(ISE_EIFFEL)\BCC55\include -I..\include -L$(ISE_EIFFEL)\BCC55\lib 
LN = copy
MAKE = make
RANLIB = echo
RM = -del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: clean nls_locale.lib

.c.obj:
	$(CC) -c $(CFLAGS) $<

SMODE = nls_locale.c

LSRCS = $(SMODE)

OBJS = \
	nls_locale.obj

clean:
	$(RM) *.obj

nls_locale.lib: $(OBJS)
	$(RM) $@
	$(AR) $@ +nls_locale.obj
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\windows mkdir ..\spec\windows
	if not exist ..\spec\windows\lib mkdir ..\spec\windows\lib
	if not exist ..\spec\windows\lib\bcb mkdir ..\spec\windows\lib\bcb
	copy nls_locale.lib ..\spec\windows\lib\bcb\nls_locale.lib
