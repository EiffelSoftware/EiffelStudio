SRCLIST = AssemblyManagerInterface.cs IAssemblyManagerInterface.cs AMI_assembly_info.cs

.SUFFIXES: .dll .cs

.cs.dll:
	csc /dll $*.cs

AssemblyManagerInterface.dll : $(SRCLIST) makefile AMI.key
	csc /t:library /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.ReflectionInterface.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.Support.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.EiffelComponents.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.AssemblyManager.exe $(SRCLIST)
	tlbexp AssemblyManagerInterface.dll
	regasm AssemblyManagerInterface.dll
	gacutil -u AssemblyManagerInterface
	gacutil -i AssemblyManagerInterface.dll
	
AMI.key:
	sn -k AMI.key
