CC = bcc32
CFLAGS = -O2 -c -WC -g0 -w- -DEIF_BORLAND -Ie:\bc5\include\mfc

OBJ = odbc.obj

all:: clean odbc_store.lib 

.c.obj:
	$(CC) $(CFLAGS) $<

odbc_store.lib: odbc.obj odbc.h
		del $@
		tlib $@ /c +odbc.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcc mkdir ..\..\..\..\spec\bcc
		if not exist ..\..\..\..\spec\bcc\lib mkdir ..\..\..\..\spec\bcc\lib
		copy odbc_store.lib ..\..\..\..\spec\bcc\lib

odbc.obj: odbc.c odbc.h

clean:
	del *.obj *.lib
