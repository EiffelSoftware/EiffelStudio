SRCLIST = AssemblyManagerInterface.cs IAssemblyManagerInterface.cs

.SUFFIXES: .dll .cs

.cs.dll:
	csc /dll $*.cs

AssemblyManagerInterface.dll : $(SRCLIST) makefile
	csc /t:module /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.ReflectionInterface.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.Support.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.EiffelComponents.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.AssemblyManager.exe $(SRCLIST)
	sn -k Key
	al assemblymanagerinterface.netmodule /keyfile:Key /out:AssemblyManagerInterface.dll
	tlbexp AssemblyManagerInterface.dll
	regasm AssemblyManagerInterface.dll
	gacutil -u AssemblyManagerInterface
	gacutil -i AssemblyManagerInterface.dll