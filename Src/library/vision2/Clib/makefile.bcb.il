# ilvision2.lib - Makefile for Borland

CC = $(ISE_EIFFEL)\BCC55\bin\bcc32.exe
AR = $(ISE_EIFFEL)\BCC55\bin\tlib.exe


# Release version
CFLAGS = -c -O1 -DEIF_IL_DLL \
	-I..\spec\include \
	-I$(ISE_EIFFEL)\C_library\libpng \
	-I$(ISE_EIFFEL)\C_library\zlib \
	-I$(ISE_EIFFEL)\studio\spec\windows\include \
	-I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib 

.c.obj:
	$(CC) $(CFLAGS) $<

OBJ = load_pixmap.obj

ilvision2.lib: $(OBJ)
	if exist $@ -del $@
	$(AR) $@ +$(OBJ)
	if not exist ..\spec\bcb mkdir ..\spec\bcb
	if not exist ..\spec\bcb\lib mkdir ..\spec\bcb\lib
	copy $@ ..\spec\bcb\lib
	-del $@
	-del *.obj
