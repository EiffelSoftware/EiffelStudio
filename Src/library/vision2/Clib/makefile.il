# vision2.lib - Makefile for Microsoft C

CC = cl
CFLAGS = -c -MT -Ox -W3 -DEIF_IL_DLL \
	-I..\spec\include \
	-I..\..\..\C_library\libpng \
	-I..\..\..\C_library\zlib \
	-I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include

.c.obj:
	$(CC) $(CFLAGS) $<

OBJ = load_pixmap.obj

ilvision2.lib: $(OBJ)
	if exist $@ del $@
	lib /OUT:$@ $(OBJ)
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib
	del $@
	del *.obj
