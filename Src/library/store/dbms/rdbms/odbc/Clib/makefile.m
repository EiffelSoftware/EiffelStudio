CC = cl
CFLAGS = -c -Ox -W3 -I$(ISE_EIFFEL)\bench\spec\$(ISE_PLATFORM)\include
OBJ = odbc.obj

all:: clean odbc_store.lib

.c.obj:
	$(CC) $(CFLAGS) $<

odbc_store.lib: $(OBJ) odbc.h
		-del $@
		lib /OUT:$@ $(OBJ)
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy odbc_store.lib ..\..\..\..\spec\msc\lib

odbc.obj: odbc.c odbc.h

clean:
	-del *.obj *.lib
