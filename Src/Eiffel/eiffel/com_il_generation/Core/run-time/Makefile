RUNTIME_SRC = rt_parameter_utility.cs eiffel_type_info.cs runtime.cs gen_conf.cs runtime_assembly_info.cs assertions.cs eiffel_exception.cs agent_proxy.cs any.cs rt_reference_comparer.cs types/*.cs custom_attributes/*.cs enums/*.cs
CSFLAGS = -nologo -w:4 -nowarn:0659 -optimize+
#CSFLAGS = -nologo -w:4 -nowarn:0659 -debug -d:ASSERTIONS
GACFLAGS = -nologo
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy

all:: EiffelSoftware.Runtime.dll

EiffelSoftware.Runtime.dll: $(RUNTIME_SRC) Makefile
	$(CP) $(EIFFEL_SRC)\dotnet\helpers\isekey.snk ise_runtime.key
	csc $(CSFLAGS) -target:library -out:$@ -recurse:"*.cs"
	del ise_runtime.key


install: all
	gacutil $(GACFLAGS) -if EiffelSoftware.Runtime.dll
