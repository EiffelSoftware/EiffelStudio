# Finalized Version

#CFLAGS = -nologo -Ox -W4 \ # -Zi \
#		 -I$(EIFFEL_SRC)\C \
#		 -I$(EIFFEL_SRC)\C\bench \
#		 -I$(EIFFEL_SRC)\C\console \
#		 -I$(EIFFEL_SRC)\C\platform \
#		 -I$(EIFFEL_SRC)\C\run-time

CFLAGS = -nologo -Ox -W4 -I$(ISE_EIFFEL)\studio\spec\windows\include

OPT_CFLAGS = -MT
#OPT_CFLAGS = -MT -DASSERTIONS 
#OPT_CFLAGS = -MT -DASSERTIONS -DDBGTRACE_ENABLED
#OPT_CFLAGS = 

.cpp.obj:
	$(CC) $(CFLAGS) -c $<

.c.obj:
	$(CC) $(CFLAGS) -c $<

all:: cli_writer cli_debugger
cli_writer: cli_writer.lib
cli_debugger: cli_debugger.lib 

cli_writer.obj: cli_writer.cpp ise_cache_manager.idl cli_writer.h
	midl -notlb -header ise_cache_manager.h -iid ise_cache_manager.c ise_cache_manager.idl
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_writer.cpp

cli_debugger.obj: cli_debugger.cpp  cli_debugger.h
	midl -notlb -header cordebug.h cordebug.idl
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger.cpp 

cli_debugger_callback.obj:  cli_debugger_callback.cpp cli_debugger_callback.h
	midl -notlb -header cordebug.h cordebug.idl
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger_callback.cpp

OBJ_WRITER = cli_writer.obj ise_vs_fusion_support.obj ise_cache_manager.obj
OBJ_DEBUGGER = cli_debugger.obj cli_debugger_callback.obj

cli_writer.lib: $(OBJ_WRITER)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(OBJ_WRITER)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib


cli_debugger.lib: $(OBJ_DEBUGGER)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(OBJ_DEBUGGER)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib

clean_debugger:
	del $(OBJ_DEBUGGER)
clean_writer:
	del $(OBJ_WRITER)

clean_all: clean_writer clean_debugger

