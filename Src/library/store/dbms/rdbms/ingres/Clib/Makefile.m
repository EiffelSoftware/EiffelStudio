CC = cl
CFLAGS = -MT -c -I$(II_SYSTEM)\include
OBJ = ingres.obj

all:: clean ingres_store.lib

ingres.c: ingres.sc ingres.h
	esqlc -w ingres.sc

.c.obj:
	$(CC) $(CFLAGS) $<

ingres_store.lib: $(OBJ) ingres.h
		del $@
		lib /OUT:$@ $(OBJ)
		if not exist ..\..\..\..\spec mkdir ..\..\..\..\spec
		if not exist ..\..\..\..\spec\msc mkdir ..\..\..\..\spec\msc
		if not exist ..\..\..\..\spec\msc\lib mkdir ..\..\..\..\spec\msc\lib
		copy ingres_store.lib ..\..\..\..\spec\msc\lib

ingres.obj: ingres.c ingres.h

clean:
	del *.obj *.lib
