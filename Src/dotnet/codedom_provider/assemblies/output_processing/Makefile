HANDLER_SRC = handler\assembly_info.cs handler\handler.cs
DISPATCHER_SRC = dispatcher\assembly_info.cs dispatcher\dispatcher.cs
CSFLAGS = -nologo -w:4 -nowarn:0659 -optimize+
#CSFLAGS = -nologo -w:4 -nowarn:0659 -debug -d:ASSERTIONS
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: EiffelSoftware.Compiler.OutputDispatcher.dll

EiffelSoftware.Compiler.OutputDispatcher.dll: $(DISPATCHER_SRC) Makefile EiffelSoftware.Compiler.OutputHandler.dll
	$(CP) $(EIFFEL_SRC)\dotnet\helpers\isekey.snk .
	csc $(CSFLAGS) -target:library -out:$@ -r:EiffelSoftware.Compiler.OutputHandler.dll,..\EiffelSoftware.Compiler.Managed.dll $(DISPATCHER_SRC)
	del isekey.snk

EiffelSoftware.Compiler.OutputHandler.dll: $(HANDLER_SRC) Makefile
	$(CP) $(EIFFEL_SRC)\dotnet\helpers\isekey.snk .
	csc $(CSFLAGS) -target:library -out:$@ $(HANDLER_SRC)
	del isekey.snk