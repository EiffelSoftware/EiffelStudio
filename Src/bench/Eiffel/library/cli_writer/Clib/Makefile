# Finalized Version
CFLAGS = -nologo -Ox -W3 -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION
#CFLAGS = -nologo -Zi -W3 -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION -DASSERTIONS

all:: cli_writer.lib
	del *.lib
	del *.obj

.cpp.obj:
	$(CC) $(CFLAGS) -c $<

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJ = cli_writer.obj

cli_writer.lib: $(OBJ)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(OBJ)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib
