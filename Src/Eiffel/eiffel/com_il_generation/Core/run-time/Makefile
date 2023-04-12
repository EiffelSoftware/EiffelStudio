RUNTIME_SRC = rt_parameter_utility.cs eiffel_type_info.cs runtime.cs gen_conf.cs runtime_assembly_info.cs assertions.cs rt_exception_manager.cs rt_extension.cs agent_proxy.cs any.cs rt_reference_comparer.cs types/*.cs custom_attributes/*.cs enums/*.cs
CSFLAGS = -nologo -w:4 -nowarn:0659 -optimize+
#CSFLAGS = -nologo -w:4 -nowarn:0659 -debug -d:ASSERTIONS
GACFLAGS = -nologo
MKDIR = -mkdir
RMDIR = -rd /q /s
CP = -copy
RM = -del
OUTPUT_NAME = EiffelSoftware.Runtime.dll
ISE_KEY_NAME = isekey.snk
ISE_KEY_PATH = $(EIFFEL_SRC)\dotnet\helpers\$(ISE_KEY_NAME)

all:: dotnet_20 dotnet_60

dotnet_20: $(RUNTIME_SRC) Makefile
	csc $(CSFLAGS) -target:library -out:$(OUTPUT_NAME) -recurse:"*.cs" /keyfile:$(ISE_KEY_PATH)

dotnet_60: $(RUNTIME_SRC) Makefile
	dotnet build -c Release runtime_core.csproj --restore --no-incremental
	dotnet publish -c Release runtime_core.csproj

msbuild_20: $(RUNTIME_SRC) Makefile
	$(CP) $(ISE_KEY_PATH) $(ISE_KEY_NAME)
	msbuild runtime.sln /p:TargetFrameworkVersion=v2.0;ToolsVersion=2.0
	$(RMDIR) obj
	$(RM) runtime.sln.cache
	$(RM)  $(ISE_KEY_NAME)

msbuild_40: $(RUNTIME_SRC) Makefile
	$(CP) $(ISE_KEY_PATH) $(ISE_KEY_NAME)
	msbuild runtime.sln /p:TargetFrameworkVersion=v4.0;ToolsVersion=4.0
	$(RMDIR) obj
	$(RM) runtime.sln.cache
	$(RM)  $(ISE_KEY_NAME)

msbuild_60: $(RUNTIME_SRC) Makefile
	dotnet build -c Release runtime_core.csproj --restore --no-incremental
	dotnet publish -c Release runtime_core.csproj
	$(CP) bin\Release\net6.0\publish\EiffelSoftware.Runtime.dll netcore/$(OUTPUT_NAME)
	$(RMDIR) obj
