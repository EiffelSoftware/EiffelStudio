CC = cl
CFLAGS = -MT -c -I$(SYBASE)\include
OBJ = sybase.obj

all:: clean sybase_store.lib

.c.obj:
	$(CC) $(CFLAGS) $<

sybase_store.lib: $(OBJ) sybase.h
		del $@
		lib /OUT:$@ $(OBJ)
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy sybase_store.lib ..\..\..\..\spec\msc\lib

sybase.obj: sybase.c sybase.h

clean:
	del *.obj *.lib
