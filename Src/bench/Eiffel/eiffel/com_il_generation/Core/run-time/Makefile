RUNTIME_SRC = runtime.cs gen_conf.cs runtime_assembly_info.cs types/*.cs
CSFLAGS = -nologo -w:4 -optimize+ -debug
#CSFLAGS = -nologo -w:4 -debug -d:DEBUG
GACFLAGS = -nologo
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: ise_runtime.dll

ise_runtime.dll: $(RUNTIME_SRC) makefile
	csc $(CSFLAGS) -target:library -out:$@ -recurse:"*.cs"
	gacutil $(GACFLAGS) -if ise_runtime.dll
