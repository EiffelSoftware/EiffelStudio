@echo off

mkdir bin

echo ***********************************************
echo *  Generating `ISE.Reflection.Formatter.dll'  *
echo ***********************************************

cd ISE.Reflection.Emitter
copy ..\..\..\tools\emitter\formatter.cs .
gacutil -u ISE.Reflection.Formatter
call make_formatter.bat
gacutil -i ISE.Reflection.Formatter.dll
copy ISE.Reflection.Formatter.dll ..\bin
copy formatter.netmodule ..\bin
del formatter.cs
del ISE.Reflection.Formatter.dll
del formatter.netmodule
del Key
cd ..

echo *****************************************************************
echo *  Generating Eiffel class from `ISE.Reflection.Formatter.dll'  *
echo ***************************************************************** 

..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.Formatter.dll /d .\generated\formatter_generated

set PATH=%PATH%;%ISE_EIFFEL%\bench\spec\windows\bin

echo ******************************************************
echo *  Generating `ISE.Reflection.EiffelComponents.dll'  *
echo ******************************************************

cd ISE.Reflection.EiffelComponents
cd ace_file
gacutil -u ISE.Reflection.EiffelComponents
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace 
gacutil -i ISE.Reflection.EiffelComponents.dll
copy .\ISE.Reflection.EiffelComponents.dll ..\..\bin

cd ..
cd ..

echo ************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelComponents.dll'  *
echo ************************************************************************

..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.EiffelComponents.dll /d .\generated\eiffel_components_generated
del .\generated\eiffel_components_generated\tuple.e

echo *****************************************************************
echo *  Generating `ISE.Reflection.EiffelAssemblyCacheNotifier.dll'  *
echo *****************************************************************

cd ISE.Reflection.EiffelAssemblyCacheNotifier
cd ace_file
gacutil -u ISE.Reflection.EiffelAssemblyCacheNotifier
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace 
gacutil -i ISE.Reflection.EiffelAssemblyCacheNotifier.dll
copy .\ISE.Reflection.EiffelAssemblyCacheNotifier.dll ..\..\bin

cd ..
cd ..

echo ***********************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelAssemblyCacheNotifier.dll'  *
echo ***********************************************************************************

copy .\bin\ISE.Reflection.EiffelComponents.dll ..\..\tools\emitter
..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.EiffelAssemblyCacheNotifier.dll /d .\generated\notifier_generated

echo *********************************************
echo *  Generating `ISE.Reflection.Support.dll'  *
echo *********************************************

cd ISE.Reflection.Support
cd ace_file
gacutil -u ISE.Reflection.Support
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace 
gacutil -i ISE.Reflection.Support.dll
copy .\ISE.Reflection.Support.dll ..\..\bin

cd ..
cd ..

echo ****************************************************************
echo *   Emitting Eiffel classes from `ISE.Reflection.Support.dll'  *
echo ****************************************************************

copy bin\ISE.Reflection.Formatter.dll ..\..\tools\emitter
..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.Support.dll /d .\generated\support_generated

echo ******************************************************************
echo *    Generating `ISE.Reflection.EiffelAssemblyCacheHandler.dll'  *
echo ******************************************************************

cd ISE.Reflection.EiffelAssemblyCacheHandler
cd ace_file
gacutil -u ISE.Reflection.EiffelAssemblyCacheHandler
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace 
gacutil -i ISE.Reflection.EiffelAssemblyCacheHandler.dll
copy .\ISE.Reflection.EiffelAssemblyCacheHandler.dll ..\..\bin

cd ..
cd ..

echo **********************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelAssemblyCacheHandler.dll'  *
echo **********************************************************************************

copy .\bin\ISE.Reflection.Support.dll ..\..\tools\emitter
copy .\bin\ISE.Reflection.EiffelAssemblyCacheNotifier.dll ..\..\tools\emitter
..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.EiffelAssemblyCacheHandler.dll /d .\generated\eiffel_assembly_cache_generated

echo ***************************************************
echo *  Generating `ISE.Reflection.CodeGenerator.dll'  *
echo ***************************************************

cd ISE.Reflection.CodeGenerator
cd ace_file
gacutil -u ISE.Reflection.CodeGenerator
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace
gacutil -i ISE.Reflection.CodeGenerator.dll
copy .\ISE.Reflection.CodeGenerator.dll ..\..\bin

cd ..
cd ..

echo *********************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.CodeGenerator.dll'  *
echo *********************************************************************

copy .\bin\ISE.Reflection.EiffelAssemblyCacheHandler.dll ..\..\tools\emitter
..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.CodeGenerator.dll /d .\generated\code_generator_generated

echo *********************************************************
echo *  Generating `ISE.Reflection.ReflectionInterface.dll'  *
echo *********************************************************

cd ISE.Reflection.ReflectionInterface
cd ace_file
gacutil -u ISE.Reflection.ReflectionInterface
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace 
gacutil -i ISE.Reflection.ReflectionInterface.dll
copy .\ISE.Reflection.ReflectionInterface.dll ..\..\bin

cd ..
cd ..

echo **************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.ReflectionInterface.dll' *
echo **************************************************************************

..\..\tools\emitter\emitter.exe /t .\bin\ISE.Reflection.ReflectionInterface.dll /d .\generated\reflection_interface_generated
del ..\..\tools\emitter\ISE.Reflection.EiffelComponents.dll
del ..\..\tools\emitter\ISE.Reflection.EiffelAssemblyCacheNotifier.dll
del ..\..\tools\emitter\ISE.Reflection.Support.dll
del ..\..\tools\emitter\ISE.Reflection.EiffelAssemblyCacheHandler.dll
del ..\..\tools\emitter\ISE.Reflection.Formatter.dll

echo ********************************************************************
echo *  Generating `ISE.AssemblyManager.WindowsDirectoryExtractor.dll'  *
echo ********************************************************************

cd assembly_manager
cd gac_browser
gacutil -u ISE.AssemblyManager.WindowsDirectoryExtractor
call make.bat
gacutil -i ISE.AssemblyManager.WindowsDirectoryExtractor.dll
copy ISE.AssemblyManager.WindowsDirectoryExtractor.dll ..\..\bin
copy windowsdirectoryextractor.netmodule ..\..\bin


echo *************************************************************
echo * Generating `FolderBrowser.dll' and `FolderDialog.dll'     *
echo *************************************************************

cd ..
cd folder_dialog
cd Core
gacutil -u FolderBrowser
gacutil -u FolderDialog
call build.bat
gacutil -i FolderBrowser.dll
gacutil -i FolderDialog.dll
copy FolderBrowser.dll ..\..\..\bin
copy FolderDialog.dll ..\..\..\bin
copy folderdialog.netmodule ..\..\..\bin

cd ..
cd Clib
call make_finalize.bat
cd ..


echo *************************************
echo *  Generating `folder_browser.dll'  *
echo *************************************

gacutil -u folder_browser
del *.epr
rd -q -s EIFGEN
ec -ace Ace.ace -finalize
cd EIFGEN
cd F_code
finish_freezing
gacutil -i folder_browser.dll
copy .\folder_browser.dll ..\..\..\..\bin

cd ..
cd ..
cd ..
cd ..

echo *********************************************
echo *  Generating `ISE.Reflection.Emitter.exe'  *
echo *********************************************

cd ISE.Reflection.Emitter
copy ..\..\..\tools\emitter\argparser.cs .
copy ..\..\..\tools\emitter\eiffelclassfactory.cs .
copy ..\..\..\tools\emitter\eiffelcreationroutine.cs .
copy ..\..\..\tools\emitter\eiffelmethodfactory.cs .
copy ..\..\..\tools\emitter\formatter.cs .
copy ..\..\..\tools\emitter\globals.cs .
copy ..\..\..\tools\emitter\newemitter.cs .
copy ..\..\..\tools\emitter\newemittermain.cs .
copy ..\..\..\tools\emitter\redefineclauses.cs .
copy ..\..\..\tools\emitter\renameclauses.cs .
copy ..\..\..\tools\emitter\selectclauses.cs .
copy ..\..\..\tools\emitter\undefineclauses.cs .

gacutil -u ISE.Reflection.Emitter
sn -k Key
call make.bat
gacutil -i ISE.Reflection.Emitter.exe
copy ISE.Reflection.Emitter.exe ..\bin
del ISE.Reflection.Emitter.exe
del argparser.cs
del eiffelclassfactory.cs
del eiffelcreationroutine.cs
del eiffelmethodfactory.cs
del formatter.cs
del globals.cs
del newemitter.cs
del newemittermain.cs
del redefineclauses.cs
del renameclauses.cs
del selectclauses.cs
del undefineclauses.cs

cd ..

echo ******************************************
echo *  Generating `ISE.AssemblyManager.exe'  *
echo ******************************************

cd assembly_manager
cd ace_file
gacutil -u ISE.AssemblyManager
del *.epr
rd -q -s EIFGEN
ec -ace ace.ace
gacutil -i ISE.AssemblyManager.exe
copy ISE.AssemblyManager.exe .\..\dotnet\reflection_interface\bin
copy ..\..\bin\ISE.Reflection.Formatter.dll .
copy ..\..\bin\ISE.Reflection.EiffelComponents.dll .
copy ..\..\bin\ISE.Reflection.EiffelAssemblyCacheNotifier.dll .
copy ..\..\bin\ISE.Reflection.Support.dll .
copy ..\..\bin\ISE.Reflection.EiffelAssemblyCacheHandler.dll .
copy ..\..\bin\ISE.Reflection.CodeGenerator.dll .
copy ..\..\bin\ISE.Reflection.ReflectionInterface.dll .
copy ..\..\bin\ISE.AssemblyManager.WindowsDirectoryExtractor.dll .
copy ..\..\bin\FolderBrowser.dll .
copy ..\..\bin\FolderDialog.dll .
copy ..\..\bin\folder_browser.dll .
copy ..\..\bin\ISE.Reflection.Emitter.exe .

regsvr32 folder_browser.dll

