SRCLIST = ..\..\..\tools\emitter\newemitter.cs ..\..\..\tools\emitter\renameclauses.cs ..\..\..\tools\emitter\redefineclauses.cs ..\..\..\tools\emitter\undefineclauses.cs ..\..\..\tools\emitter\selectclauses.cs ..\..\..\tools\emitter\eiffelclassfactory.cs ..\..\..\tools\emitter\newemittermain.cs ..\..\..\tools\emitter\globals.cs ..\..\..\tools\emitter\eiffelmethodfactory.cs neweiffelclassgenerator.cs ..\..\..\tools\emitter\eiffelcreationroutine.cs ..\..\..\tools\emitter\argparser.cs

.SUFFIXES: .exe .cs

.cs.exe:
	csc $*.cs

ISE.Reflection.Emitter.exe : $(SRCLIST) makefile
	csc /out:ISE.Reflection.Emitter.exe $(SRCLIST) /r:..\bin\ISE.Reflection.CodeGenerator.dll /r:..\bin\ISE.Reflection.EiffelComponents.dll /r:..\bin\ISE.Reflection.ReflectionInterface.dll /r:..\bin\ISE.Reflection.Support.dll /r:..\bin\ISE.Reflection.Formatter.dll
