CC = cl   
CFLAGS = -I$(ORACLE_HOME)\OCI80\INCLUDE -I. -D_DLL -D_MT -c 
OBJ = oracle.obj
all:: clean oracle_store.lib

.c.obj:
	$(CC) $(CFLAGS) $<

oracle_store.lib: $(OBJ) oracle.h
		del $@
		lib /NODEFAULTLIB:libc Msvcrt.lib /OUT:$@ $(OBJ)  
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy oracle_store.lib ..\..\..\..\spec\msc\lib

oracle.obj: oracle.c oracle.h

clean:
	del *.obj *.lib
