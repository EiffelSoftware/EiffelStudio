CC = bcb32
CFLAGS = -O2 -c -WC -g0 -w- -DEIF_BORLAND
OBJ = odbc.obj

all:: clean odbc_store.lib 

.c.obj:
	$(CC) $(CFLAGS) $<

odbc_store.lib: odbc.obj odbc.h
		del $@
		tlib $@ /c +odbc.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcb mkdir ..\..\..\..\spec\bcb
		if not exist ..\..\..\..\spec\bcb\lib mkdir ..\..\..\..\spec\bcb\lib
		copy odbc_store.lib ..\..\..\..\spec\bcb\lib

odbc.obj: odbc.c odbc.h

clean:
	del *.obj *.lib
