SRCLIST = newemitter.cs renameclauses.cs redefineclauses.cs undefineclauses.cs selectclauses.cs eiffelclassfactory.cs newemittermain.cs globals.cs eiffelmethodfactory.cs neweiffelclassgenerator.cs eiffelcreationroutine.cs argparser.cs

.SUFFIXES: .exe .cs

.cs.exe:
	csc $*.cs

ISE.Reflection.Emitter.exe : $(SRCLIST) makefile
	csc /out:ISE.Reflection.Emitter.exe $(SRCLIST) /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.CodeGenerator.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.EiffelComponents.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.ReflectionInterface.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.Support.dll /r:%EIFFEL_SRC%\dotnet\reflection_interface\bin\ISE.Reflection.Formatter.dll
