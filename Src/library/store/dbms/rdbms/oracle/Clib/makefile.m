CC = cl   
CFLAGS = -Ox -MT -W3 -I$(ORACLE_HOME)\OCI\INCLUDE -I. -c 
#CFLAGS = -Zi -MT -I$(ORACLE_HOME)\OCI\INCLUDE -I. -c 

OBJ = oracle.obj
all:: clean oracle_store.lib

.c.obj:
	$(CC) $(CFLAGS) $<

oracle_store.lib: $(OBJ) oracle.h
		-del $@
		lib -OUT:$@ $(OBJ)  
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\$(ISE_PLATFORM) mkdir ..\..\..\..\spec\msc\$(ISE_PLATFORM)
		if not exist ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib mkdir ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib
		copy $@ ..\..\..\..\spec\msc\$(ISE_PLATFORM)\lib

oracle.obj: oracle.c oracle.h

clean:
	-del *.obj *.lib
