CC = bcc32
CFLAGS = -O2 -c -WC -g0 -w- -DEIF_BORLAND
OBJ = oracle.obj

all:: clean oracle_store.lib 

.c.obj:
	$(CC) $(CFLAGS) $<

oracle_store.lib: oracle.obj oracle.h
		del $@
		tlib $@ /c +oracle.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcc mkdir ..\..\..\..\spec\bcc
		if not exist ..\..\..\..\spec\bcc\lib mkdir ..\..\..\..\spec\bcc\lib
		copy oracle_store.lib ..\..\..\..\spec\bcc\lib

oracle.obj: oracle.c oracle.h

clean:
	del *.obj *.lib
