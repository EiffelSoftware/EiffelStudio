# Finalized Version
CFLAGS = -nologo -Ox -W3 -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION
#CFLAGS = -nologo -Zi -W3 -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION -DASSERTIONS

.cpp.obj:
	$(CC) $(CFLAGS) -c $<

.c.obj:
	$(CC) $(CFLAGS) -c $<

all:: cli_writer.lib

cli_writer.obj: cli_writer.cpp ise_cache_manager.idl
	midl -notlb -header ise_cache_manager.h -iid ise_cache_manager.c ise_cache_manager.idl
	$(CC) $(CFLAGS) -c cli_writer.cpp

OBJ = cli_writer.obj ise_vs_fusion_support.obj ise_cache_manager.obj

cli_writer.lib: $(OBJ)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(OBJ)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib

