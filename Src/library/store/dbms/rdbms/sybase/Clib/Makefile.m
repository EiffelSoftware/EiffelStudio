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
		if not exist ..\..\..\..\spec\msc\$(ISE_PLATFORM) mkdir ..\..\..\..\spec\msc\$(ISE_PLATFORM)
		if not exist ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib mkdir ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib
		copy $@ ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib

sybase.obj: sybase.c sybase.h

clean:
	del *.obj *.lib
