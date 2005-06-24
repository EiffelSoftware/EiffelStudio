CC = cl
CFLAGS = -c -Ox -MT -W3 -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include
IL_CFLAGS = -c -Ox -MT -DEIF_IL_DLL -W3 -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include
OBJ = odbc.obj
IL_OBJ = il_odbc.obj

all:: clean odbc_store.lib il_odbc_store.lib
	del *.obj *.lib

.c.obj:
	$(CC) $(CFLAGS) $<

odbc_store.lib: $(OBJ) odbc.h
		-del $@
		lib /OUT:$@ $(OBJ)
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy $@ ..\..\..\..\spec\msc\lib

il_odbc_store.lib: $(IL_OBJ) odbc.h
		-del $@
		lib /OUT:$@ $(IL_OBJ)
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy $@ ..\..\..\..\spec\msc\lib

il_odbc.obj: odbc.c
	$(CC) $(IL_CFLAGS) -Fo$@ -c $?

clean:
	-del *.obj *.lib
