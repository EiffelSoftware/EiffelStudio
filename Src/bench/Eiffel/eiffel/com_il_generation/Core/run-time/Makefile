RUNTIME_SRC = eiffel_type_info.cs eiffel_derivation.cs runtime.cs gen_conf.cs runtime_assembly_info.cs assertions.cs types/*.cs custom_attributes/*.cs
CSFLAGS = -nologo -w:4 -optimize+
#CSFLAGS = -nologo -w:4 -debug -d:ASSERTIONS
GACFLAGS = -nologo
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: ISE.Runtime.dll

ISE.Runtime.dll: $(RUNTIME_SRC) Makefile
	$(CP) $(EIFFEL_SRC)\dotnet\helpers\isekey.snk ise_runtime.key
	csc $(CSFLAGS) -target:library -out:$@ -recurse:"*.cs"
	gacutil $(GACFLAGS) -if ISE.Runtime.dll
	del ise_runtime.key
