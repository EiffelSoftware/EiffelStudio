AR = $(ISE_EIFFEL)\BCC55\bin\tlib 
CC = $(ISE_EIFFEL)\BCC55\bin\bcc32
CFLAGS = -O2 -I$(ORACLE_HOME)\OCI\INCLUDE
OBJ = oracle.obj

all:: clean oracle_store.lib 

.c.obj:
	$(CC) -c $(CFLAGS) $<

oracle_store.lib: $(OBJ)
		-del $@
		$(AR) $@ +oracle.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcb mkdir ..\..\..\..\spec\bcb
		if not exist ..\..\..\..\spec\bcb\lib mkdir ..\..\..\..\spec\bcb\lib
		copy oracle_store.lib ..\..\..\..\spec\bcb\lib

oracle.obj: oracle.c oracle.h

clean:
	-del *.obj
