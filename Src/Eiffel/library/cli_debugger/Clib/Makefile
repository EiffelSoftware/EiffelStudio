CLIBOBJ = .\OBJ
CLIBSRC = .
OPT_CFLAGS = -Ox -W4 -nologo
OUTPUT_CMD = -Fo
INPUT_CMD = -Fd$(CLIBOBJ)\\
JCFLAGS = $(CFLAGS) -MT $(OPT_CFLAGS) $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
CFLAGS = -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -D_UNICODE -DUNICODE 

#CFLAGS = -nologo -Ox -MT -W4 \ # -Zi \
#		 -I$(EIFFEL_SRC)\C \
#		 -I$(EIFFEL_SRC)\C\bench \
#		 -I$(EIFFEL_SRC)\C\console \
#		 -I$(EIFFEL_SRC)\C\platform \
#		 -I$(EIFFEL_SRC)\C\run-time


#OPT_CFLAGS = -Zi -W4 -nologo
#OPT_CFLAGS = -DASSERTIONS 
#OPT_CFLAGS = -DASSERTIONS -DDBGTRACE_ENABLED
#OPT_CFLAGS = -DDBGTRACE_ENABLED
#OPT_CFLAGS = 

#CFLAGS = -nologo -MT -W4 -Zi -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -D_UNICODE -DUNICODE

all:: cli_debugger.lib

$(CLIBOBJ)\cli_debugger.obj: $(CLIBSRC)\cli_debugger.cpp  $(CLIBSRC)\cli_debugger.h $(CLIBSRC)\Makefile
	$(CC) $(JCFLAGS) $(CLIBSRC)\cli_debugger.cpp 

$(CLIBOBJ)\cli_debugger_utils.obj:  $(CLIBSRC)\cli_debugger_utils.cpp $(CLIBSRC)\cli_debugger_utils.h $(CLIBSRC)\Makefile
	$(CC) $(JCFLAGS) $(CLIBSRC)\cli_debugger_utils.cpp

$(CLIBOBJ)\cli_debugger_callback.obj:  $(CLIBSRC)\cli_debugger_callback.cpp $(CLIBSRC)\cli_debugger_callback.h $(CLIBSRC)\Makefile
	$(CC) $(JCFLAGS) $(CLIBSRC)\cli_debugger_callback.cpp

$(CLIBOBJ)\cli_debugger_callback_id.obj:  $(CLIBSRC)\cli_debugger_headers.h $(CLIBSRC)\cli_debugger_callback_id.cpp $(CLIBSRC)\cli_debugger_callback_id.h $(CLIBSRC)\Makefile
	$(CC) $(JCFLAGS) $(CLIBSRC)\cli_debugger_callback_id.cpp

OBJ_DEBUGGER = $(CLIBOBJ)\cli_debugger.obj \
			   $(CLIBOBJ)\cli_debugger_callback.obj \
			   $(CLIBOBJ)\cli_debugger_callback_id.obj \
			   $(CLIBOBJ)\cli_debugger_utils.obj

$(CLIBOBJ):
	if not exist $(CLIBOBJ) mkdir $(CLIBOBJ)

cli_debugger.lib: $(CLIBOBJ) $(OBJ_DEBUGGER) 
	if exist $@ del $@
	lib /NOLOGO /OUT:$(CLIBOBJ)\$@ $(OBJ_DEBUGGER)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $(CLIBOBJ)\$@ ..\spec\msc\lib

clean_debugger:
	del $(OBJ_DEBUGGER)
	del cli_debugger.lib

clean: clean_all
clean_all: clean_debugger

