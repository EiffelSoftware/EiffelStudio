CC = $(ISE_EIFFEL)\BCC55\bin\bcc32
AR = $(ISE_EIFFEL)\BCC55\bin\tlib
CFLAGS = -O2 -WC -g0 -w- -I$(ISE_EIFFEL)\bench\spec\$(ISE_PLATFORM)\include -I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib

OBJ = odbc.obj

all:: clean odbc_store.lib 

.c.obj:
	$(CC) -c $(CFLAGS) $<

odbc_store.lib: odbc.obj odbc.h
		-del $@
		$(AR) $@ +odbc.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcb mkdir ..\..\..\..\spec\bcb
		if not exist ..\..\..\..\spec\bcb\lib mkdir ..\..\..\..\spec\bcb\lib
		copy odbc_store.lib ..\..\..\..\spec\bcb\lib

odbc.obj: odbc.c odbc.h

clean:
	-del *.obj
