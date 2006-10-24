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

all:: cli_writer
cli_writer: cli_writer.lib

cli_writer.obj: cli_writer.cpp metadata_consumer.idl cli_writer.h Makefile
	midl -notlb -header metadata_consumer.h -iid metadata_consumer.c metadata_consumer.idl
	$(CC) $(CFLAGS) $(OPT_CFLAGS) -c cli_writer.cpp

OBJ_WRITER = cli_writer.obj metadata_consumer.obj

cli_writer.lib: $(OBJ_WRITER)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(OBJ_WRITER)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib


clean_writer:
	del $(OBJ_WRITER)

clean: clean_writer

