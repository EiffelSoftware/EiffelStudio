@echo off

rd /q /s bin
rd /q /s generated
mkdir generated
cd generated
mkdir formatter_generated
mkdir eiffel_components_generated
mkdir code_generator_generated
mkdir eiffel_assembly_cache_generated
mkdir new_emitter_generated
mkdir notifier_generated
mkdir reflection_interface_generated
mkdir support_generated
cd ..
mkdir bin

echo ***********************************************
echo *  Generating `ISE.Reflection.Formatter.dll'  *
echo ***********************************************

cd ISE.Reflection.Emitter
del ISE.Reflection.Formatter.dll
call make_formatter.bat
copy ISE.Reflection.Formatter.dll ..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.Formatter.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\formatter_generated
cd ..\bin
gacutil -u ISE.Reflection.Formatter
gacutil -i ISE.Reflection.Formatter.dll
cd ..

set PATH=%PATH%;%ISE_EIFFEL%\bench\spec\windows\bin

echo ******************************************************
echo *  Generating `ISE.Reflection.EiffelComponents.dll'  *
echo ******************************************************

cd ISE.Reflection.EiffelComponents
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd F_code
copy ISE.Reflection.EiffelComponents.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.EiffelComponents.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\eiffel_components_generated
cd..
cd..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.EiffelComponents
gacutil -i ISE.Reflection.EiffelComponents.dll
regasm ISE.Reflection.EiffelComponents.dll
cd ..

echo *****************************************************************
echo *  Generating `ISE.Reflection.EiffelAssemblyCacheNotifier.dll'  *
echo *****************************************************************

cd ISE.Reflection.EiffelAssemblyCacheNotifier
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd F_code
copy .\ISE.Reflection.EiffelAssemblyCacheNotifier.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.EiffelAssemblyCacheNotifier.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\notifier_generated
cd ..
cd ..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.EiffelAssemblyCacheNotifier
gacutil -i ISE.Reflection.EiffelAssemblyCacheNotifier.dll
cd ..

echo *********************************************
echo *  Generating `ISE.Reflection.Support.dll'  *
echo *********************************************

cd ISE.Reflection.Support
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd F_code
copy .\ISE.Reflection.Support.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.Support.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\support_generated
cd ..
cd ..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.Support
gacutil -i ISE.Reflection.Support.dll
cd ..

echo ******************************************************************
echo *    Generating `ISE.Reflection.EiffelAssemblyCacheHandler.dll'  *
echo ******************************************************************

cd ISE.Reflection.EiffelAssemblyCacheHandler
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd F_code
copy .\ISE.Reflection.EiffelAssemblyCacheHandler.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.EiffelAssemblyCacheHandler.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\eiffel_assembly_cache_generated
cd ..
cd ..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.EiffelAssemblyCacheHandler
gacutil -i ISE.Reflection.EiffelAssemblyCacheHandler.dll
cd ..

echo ***************************************************
echo *  Generating `ISE.Reflection.CodeGenerator.dll'  *
echo ***************************************************

cd ISE.Reflection.CodeGenerator
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace
cd EIFGEN
cd F_code
copy .\ISE.Reflection.CodeGenerator.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.CodeGenerator.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\code_generator_generated
cd ..
cd ..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.CodeGenerator
gacutil -i ISE.Reflection.CodeGenerator.dll
regasm ISE.Reflection.CodeGenerator.dll
cd ..

echo *********************************************************
echo *  Generating `ISE.Reflection.ReflectionInterface.dll'  *
echo *********************************************************

cd ISE.Reflection.ReflectionInterface
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd F_code
copy .\ISE.Reflection.ReflectionInterface.dll ..\..\..\..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.ReflectionInterface.dll /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\reflection_interface_generated
cd ..
cd ..
cd ..
cd ..
cd bin
gacutil -u ISE.Reflection.ReflectionInterface
gacutil -i ISE.Reflection.ReflectionInterface.dll
cd ..

echo ********************************************************************
echo *  Generating `ISE.AssemblyManager.WindowsDirectoryExtractor.dll'  *
echo ********************************************************************

cd assembly_manager
cd gac_browser
del ISE.AssemblyManager.WindowsDirectoryExtractor.dll
call make.bat
copy ISE.AssemblyManager.WindowsDirectoryExtractor.dll ..\..\bin
copy windowsdirectoryextractor.netmodule ..\..\bin
cd ..
cd ..
cd bin
gacutil -u ISE.AssemblyManager.WindowsDirectoryExtractor
gacutil -i ISE.AssemblyManager.WindowsDirectoryExtractor.dll
cd ..


echo *************************************************************
echo * Generating `FolderBrowser.dll' and `FolderDialog.dll'     *
echo *************************************************************

cd assembly_manager\folder_dialog
cd Core
del FolderBrowser.dll
del FolderDialog.dll
del folderdialog.netmodule
call build.bat
copy FolderBrowser.dll ..\..\..\bin
copy FolderDialog.dll ..\..\..\bin
copy folderdialog.netmodule ..\..\..\bin

cd ..
cd Clib
del *.lib
call make_finalize.bat
cd ..\..
cd bin
gacutil -u FolderBrowser
gacutil -u FolderDialog
gacutil -i FolderBrowser.dll
gacutil -i FolderDialog.dll
cd ..


echo *************************************
echo *  Generating `folder_browser.dll'  *
echo *************************************

cd assembly_manager\folder_dialog
del *.epr
rd /q /s EIFGEN
ec -ace Ace.ace -finalize
cd EIFGEN
cd F_code
finish_freezing
copy .\folder_browser.dll ..\..\..\..\bin

cd ..
cd ..
cd ..
cd ..
cd bin
regsvr32 folder_browser.dll
cd ..

echo *********************************************
echo *  Generating `ISE.Reflection.Emitter.exe'  *
echo *********************************************

cd ISE.Reflection.Emitter
del ISE.Reflection.Emitter.exe
call make.bat
copy ISE.Reflection.Emitter.exe ..\bin
del emitter.exe
copy %EIFFEL_SRC%\tools\emitter\emitter.exe .
emitter /t ISE.Reflection.Emitter.exe /d %EIFFEL_SRC%\dotnet\reflection_interface\generated\new_emitter_generated
cd ..
cd bin
gacutil -u ISE.Reflection.Emitter
gacutil -i ISE.Reflection.Emitter.exe
cd ..

echo ******************************************
echo *  Generating `ISE.AssemblyManager.exe'  *
echo ******************************************

cd assembly_manager
cd ace_file
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace
cd EIFGEN
cd F_code
copy ISE.AssemblyManager.exe ..\..\..\..\bin
cd ..\..\..\..\bin
gacutil -u ISE.AssemblyManager
gacutil -i ISE.AssemblyManager.exe
cd ..
