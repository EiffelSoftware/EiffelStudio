@echo off

if exist bin rd /q /s bin

echo Deleting `ISE.Reflection.Formatter.dll' ...

cd ISE.Reflection.Emitter
if exist ISE.Reflection.Formatter.dll del ISE.Reflection.Formatter.dll
if exist formatter.netmodule del formatter.netmodule 
if exist Key del Key
if exist ISE.Reflection.Emitter.exe del ISE.Reflection.Emitter.exe
cd ..

echo Deleting `ISE.Reflection.EiffelComponents.dll' ...

cd ISE.Reflection.EiffelComponents
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.Reflection.EiffelAssemblyCacheNotifier.dll' ...

cd ISE.Reflection.EiffelAssemblyCacheNotifier
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.Reflection.Support.dll' ...

cd ISE.Reflection.Support
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.Reflection.EiffelAssemblyCacheHandler.dll' ...

cd ISE.Reflection.EiffelAssemblyCacheHandler
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.Reflection.CodeGenerator.dll' ...

cd ISE.Reflection.CodeGenerator
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.Reflection.ReflectionInterface.dll' ...

cd ISE.Reflection.ReflectionInterface
cd ace_file
del *.epr
rd /q /s EIFGEN
cd ..
cd ..

echo Deleting `ISE.AssemblyManager.WindowsDirectoryExtractor.dll' ...

cd assembly_manager
cd gac_browser
if exist ISE.AssemblyManager.WindowsDirectoryExtractor.dll del ISE.AssemblyManager.WindowsDirectoryExtractor.dll 
if exist windowsdirectoryextractor.netmodule del windowsdirectoryextractor.netmodule 
if exist Key rd /q /s Key

echo Deleting `FolderBrowser.dll' and `FolderDialog.dll' ...

cd ..
cd folder_dialog
cd Core
if exist FolderBrowser.dll del FolderBrowser.dll 
if exist FolderDialog.dll del FolderDialog.dll
if exist folderdialog.netmodule del folderdialog.netmodule 
if exist Key1 del Key1
if exist Key2 del Key2
cd ..
cd Clib
del *.lib

echo Deleting `folder_browser.dll' ...

del *.epr
rd /q /s EIFGEN
cd ..

echo Deleting `ISE.AssemblyManager.exe' ...

cd ace_file
del *.epr
rd /q /s EIFGEN