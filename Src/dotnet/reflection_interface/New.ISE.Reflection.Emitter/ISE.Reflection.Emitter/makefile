SRCLIST = newemitter.cs renameclauses.cs redefineclauses.cs undefineclauses.cs selectclauses.cs eiffelclassfactory.cs newemittermain.cs globals.cs eiffelmethodfactory.cs neweiffelclassgenerator.cs eiffelcreationroutine.cs argparser.cs emittersupport.cs

.SUFFIXES: .exe .cs

.cs.exe:
	csc $*.cs

ISE.Reflection.Emitter.exe : $(SRCLIST) makefile Emitter.key
	csc /out:ISE.Reflection.Emitter.exe $(SRCLIST) /r:..\..\bin\ISE.Reflection\ISE.Reflection.dll /r:..\..\bin\ISE.Reflection.Formatter\ISE.Reflection.Formatter.dll /r:%ISE_EIFFEL%/ise_runtime.dll -nowarn:679 -debug

Emitter.key:
	sn -k Emitter.key