CC = $(ISE_EIFFEL)\BCC55\bin\bcc32
AR = $(ISE_EIFFEL)\BCC55\bin\tlib
CFLAGS = -O2 -WC -g0 -w- -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib
IL_CFLAGS = -O2 -WC -DEIF_IL_DLL -g0 -w- -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib

OBJ = odbc.obj
IL_OBJ = il_odbc.obj

all:: clean odbc_store.lib il_odbc_store.lib
	del *.obj *.lib

.c.obj:
	$(CC) -c $(CFLAGS) $<

odbc_store.lib: $(OBJ) odbc.h
		-del $@
		$(AR) $@ +odbc.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcb mkdir ..\..\..\..\spec\bcb
		if not exist ..\..\..\..\spec\bcb\lib mkdir ..\..\..\..\spec\bcb\lib
		copy $@ ..\..\..\..\spec\bcb\lib

il_odbc_store.lib: $(IL_OBJ) odbc.h
		-del $@
		$(AR) $@ +il_odbc.obj
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\bcb mkdir ..\..\..\..\spec\bcb
		if not exist ..\..\..\..\spec\bcb\lib mkdir ..\..\..\..\spec\bcb\lib
		copy $@ ..\..\..\..\spec\bcb\lib

il_odbc.obj: odbc.c
	$(CC) $(IL_CFLAGS) -o$@ -c $?

clean:
	-del *.obj
