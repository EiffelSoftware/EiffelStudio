@echo off

cd bin
rd /s /q ISE.Reflection
rd /s /q ISE.Reflection.Formatter
rd /s /q ISE.AssemblyManager
rd /s /q ISE.Reflection.Emitter

echo *** Making Directories ***

mkdir ISE.Reflection.Formatter
mkdir ISE.Reflection
mkdir ISE.AssemblyManager
mkdir ISE.Reflection.Emitter

@rem rd /s /q generated
@rem goto generate_folderdlls

echo *****************************************************************
echo *  Generating `ISE.Reflection.Formatter.dll'                    *
echo *****************************************************************

cd bin

cd ..
cd New.ISE.Reflection.Emitter
cd ISE.Reflection.Emitter

del ISE.Reflection.Formatter.dll
call make_formatter.bat
copy ISE.Reflection.Formatter.dll ..\..\bin\ISE.Reflection.Formatter\
cd ..\..
cd bin
cd ISE.Reflection.Formatter

echo *** Now Generating Eiffel Classes ... ***

@rem copy ..\Tools\ISE.Reflection.Emitter.exe 
@rem ISE.Reflection.Emitter.exe /t ISE.Reflection.Formatter.dll /d ..\..\generated\formatter_generated /g default

gacutil -if ISE.Reflection.Formatter.dll

cd ..\..

:ISE_Reflection_Interface_dll
echo *****************************************************************
echo *  Generating `ISE.Reflection.dll'                              *
echo *****************************************************************

cd bin


cd ..
cd New.ISE.Reflection.Emitter
cd ace_file
rem del *.epr
rem rd /q /s EIFGEN

rem ec
cd EIFGEN
cd W_code
copy *.dll ..\..\..\..\bin\ISE.Reflection\

cd ..
cd ..
cd ..
cd ..
cd bin
cd ISE.Reflection

@rem echo *** Now Generating Eiffel Classes ... ***

@rem copy ..\Tools\ISE.Reflection.Emitter.exe 
@rem ISE.Reflection.Emitter.exe /t ISE.Reflection.dll /d ..\..\generated\reflection_generated /g default

gacutil -if ISE.Reflection.dll

cd ..\..

:generate_windowsdirectoryextractor
echo ********************************************************************
echo *  Generating `ISE.AssemblyManager.WindowsDirectoryExtractor.dll'  *
echo ********************************************************************

cd assembly_manager
cd gac_browser
del ISE.AssemblyManager.WindowsDirectoryExtractor.dll
call make.bat
copy ISE.AssemblyManager.WindowsDirectoryExtractor.dll ..\..\bin\ISE.AssemblyManager
copy windowsdirectoryextractor.netmodule ..\..\bin\ISE.AssemblyManager

cd ..
cd ..
cd bin
cd ISE.AssemblyManager

gacutil -if ISE.AssemblyManager.WindowsDirectoryExtractor.dll
cd ..\..


:generate_folderdlls

echo *************************************************************
echo * Generating `FolderBrowser.dll' and `FolderDialog.dll'     *
echo *************************************************************

cd assembly_manager
cd folder_dialog
cd Core
del FolderBrowser.dll
del FolderDialog.dll
del folderdialog.netmodule
call build.bat
copy FolderBrowser.dll ..\..\..\bin\ISE.AssemblyManager
copy FolderDialog.dll ..\..\..\bin\ISE.AssemblyManager
copy folderdialog.netmodule ..\..\..\bin\ISE.AssemblyManager

cd ..
cd Clib
del *.lib
call make_finalize.bat
cd ..\..\..
cd bin
cd ISE.AssemblyManager
gacutil -u FolderBrowser
gacutil -u FolderDialog
gacutil -i FolderBrowser.dll
gacutil -i FolderDialog.dll
cd ..\..

:generate_folderbrowser

echo *************************************
echo *  Generating `folder_browser.dll'  *
echo *************************************

cd assembly_manager
cd folder_dialog
cd clib
del ecom_client.lib
nmake
cd ..
del *.epr
rd /q /s EIFGEN
ec -ace Ace.ace -finalize
cd EIFGEN
cd F_code
finish_freezing
copy .\folder_browser.dll ..\..\..\..\bin\ISE.AssemblyManager

cd ..\..\..\..
cd bin
cd ISE.AssemblyManager
regsvr32 folder_browser.dll
cd ..\..

:generate_emitter

echo *********************************************
echo *  Generating `ISE.Reflection.Emitter.exe'  *
echo *********************************************

cd bin
cd ..
cd New.ISE.Reflection.Emitter
cd ISE.Reflection.Emitter
del ISE.Reflection.Emitter.exe
call make.bat
copy ISE.Reflection.Emitter.exe ..\..\bin\Tools
@rem del emitter.exe
@rem copy ..\bin\Tools\emitter\emitter.exe 
@rem emitter /t ISE.Reflection.Emitter.exe /d ..\generated\new_emitter_generated
cd ..\..
cd bin
cd Tools
gacutil -if ISE.Reflection.Emitter.exe

cd ..\..

:generate_assemblymanager

echo ******************************************
echo *  Generating `ISE.AssemblyManager.exe'  *
echo ******************************************

cd assembly_manager
cd ace_file
del *.epr
rd /q /s EIFGEN
ec
cd EIFGEN
cd W_code
copy ISE.AssemblyManager.exe ..\..\..\..\bin\ISE.AssemblyManager
copy *.dll ..\..\..\..\bin\ISE.AssemblyManager

cd ..\..\..\..\bin
cd ISE.AssemblyManager
gacutil -if ISE.AssemblyManager.exe
cd ..\..

:theend
