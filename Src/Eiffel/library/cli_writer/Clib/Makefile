# Finalized Version

#CFLAGS = -nologo -Ox -MT -W4 \ # -Zi \
#		 -I$(EIFFEL_SRC)\C \
#		 -I$(EIFFEL_SRC)\C\bench \
#		 -I$(EIFFEL_SRC)\C\console \
#		 -I$(EIFFEL_SRC)\C\platform \
#		 -I$(EIFFEL_SRC)\C\run-time

CFLAGS = -nologo -Ox -MT -W4 -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -D_UNICODE -DUNICODE
#CFLAGS = -nologo -MT -W4 -Zi -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -D_UNICODE -DUNICODE

OPT_CFLAGS =
#OPT_CFLAGS = -DASSERTIONS 
#OPT_CFLAGS = -DASSERTIONS -DDBGTRACE_ENABLED
#OPT_CFLAGS = -DDBGTRACE_ENABLED
#OPT_CFLAGS = 

.cpp.obj:
	$(CC) $(CFLAGS) -c $<

.c.obj:
	$(CC) $(CFLAGS) -c $<

all:: cli_writer cli_debugger
cli_writer: cli_writer.lib
cli_debugger: cli_debugger.lib

cli_writer.obj: cli_writer.cpp metadata_consumer.idl cli_writer.h Makefile
	midl -notlb -header metadata_consumer.h -iid metadata_consumer.c metadata_consumer.idl
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_writer.cpp

cli_debugger.obj: cli_debugger.cpp  cli_debugger.h Makefile
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger.cpp 

cli_debugger_utils.obj:  cli_debugger_utils.cpp cli_debugger_utils.h Makefile
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger_utils.cpp

cli_debugger_callback.obj:  cli_debugger_callback.cpp cli_debugger_callback.h Makefile
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger_callback.cpp

cli_debugger_callback_id.obj:  cli_debugger_callback_id.cpp cli_debugger_callback_id.h Makefile
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_debugger_callback_id.cpp

OBJ_WRITER = cli_writer.obj ise_vs_fusion_support.obj metadata_consumer.obj
OBJ_DEBUGGER = cli_debugger.obj cli_debugger_callback.obj cli_debugger_callback_id.obj cli_debugger_utils.obj

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

clean: clean_all
clean_all: clean_writer clean_debugger

