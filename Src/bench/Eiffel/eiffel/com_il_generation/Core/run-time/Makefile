RUNTIME_SRC = runtime.cs gen_conf.cs runtime_assembly_info.cs assertions.cs types/*.cs custom_attributes/*.cs
CSFLAGS = -nologo -w:4 -optimize+
#CSFLAGS = -nologo -w:4 -debug -d:ASSERTIONS
GACFLAGS = -nologo
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: ise_runtime.dll

ise_runtime.dll: $(RUNTIME_SRC) Makefile
	csc $(CSFLAGS) -target:library -out:$@ -recurse:"*.cs"
	gacutil $(GACFLAGS) -if ise_runtime.dll
