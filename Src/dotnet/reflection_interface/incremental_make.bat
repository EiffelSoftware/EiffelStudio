@echo off

if not exist bin mkdir bin

echo ***********************************************
echo *  Generating `ISE.Reflection.Formatter.dll'  *
echo ***********************************************

cd ISE.Reflection.Emitter
if exist ISE.Reflection.Formatter.dll goto formatter_found
if not exist ISE.Reflection.Formatter.dll goto formatter_not_found

:formatter_not_found
gacutil -u ISE.Reflection.Formatter
call make_formatter.bat
gacutil -i ISE.Reflection.Formatter.dll
copy ISE.Reflection.Formatter.dll ..\bin
copy formatter.netmodule ..\bin
goto formatter_registered

:formatter_found
gacutil -u ISE.Reflection.Formatter
gacutil -i ISE.Reflection.Formatter.dll

:formatter_registered
cd ..

echo *****************************************************************
echo *  Generating Eiffel class from `ISE.Reflection.Formatter.dll'  *
echo ***************************************************************** 

cd generated
cd formatter_generated
if exist *.e goto formatter_emitted
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.Formatter.dll
:formatter_emitted
cd ..
cd ..

set PATH=%PATH%;%ISE_EIFFEL%\bench\spec\windows\bin

echo ******************************************************
echo *  Generating `ISE.Reflection.EiffelComponents.dll'  *
echo ******************************************************

cd ISE.Reflection.EiffelComponents
cd ace_file
if not exist ISE.Reflection.EiffelComponents.epr goto generate_components
if not exist EIFGEN goto generate_components
cd EIFGEN
cd W_code
if not exist ISE.Reflection.EiffelComponents.dll goto generate_components
gacutil -u ISE.Reflection.EiffelComponents
gacutil -i ISE.Reflection.EiffelComponents.dll
cd ..
cd ..
goto components_generated

:generate_components
gacutil -u ISE.Reflection.EiffelComponents
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.EiffelComponents.dll
copy .\ISE.Reflection.EiffelComponents.dll ..\..\..\..\bin
cd..
cd..

:components_generated
cd ..
cd ..

echo ************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelComponents.dll'  *
echo ************************************************************************

cd generated
cd eiffel_components_generated
if exist *.e goto components_emitted
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.EiffelComponents.dll 
del .\generated\eiffel_components_generated\tuple.e
:components_emitted
cd ..
cd ..

echo *****************************************************************
echo *  Generating `ISE.Reflection.EiffelAssemblyCacheNotifier.dll'  *
echo *****************************************************************

cd ISE.Reflection.EiffelAssemblyCacheNotifier
cd ace_file
if not exist ISE.Reflection.EiffelAssemblyCacheNotifier.epr goto generate_notifier
if not exist EIFGEN goto generate_notifier
cd EIFGEN
cd W_code
if not exist ISE.Reflection.EiffelAssemblyCacheNotifier.dll goto generate_notifier
gacutil -u ISE.Reflection.EiffelAssemblyCacheNotifier
gacutil -i ISE.Reflection.EiffelAssemblyCacheNotifier.dll
cd ..
cd ..
goto notifier_generated

:generate_notifier
gacutil -u ISE.Reflection.EiffelAssemblyCacheNotifier
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.EiffelAssemblyCacheNotifier.dll
copy .\ISE.Reflection.EiffelAssemblyCacheNotifier.dll ..\..\..\..\bin
cd ..
cd ..

:notifier_generated
cd ..
cd ..

echo ***********************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelAssemblyCacheNotifier.dll'  *
echo ***********************************************************************************

cd generated
cd notifier_generated
if exist *.e goto notifier_emitted
copy ..\..\bin\ISE.Reflection.EiffelComponents.dll ..\..\..\..\tools\emitter
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.EiffelAssemblyCacheNotifier.dll
:notifier_emitted
cd ..
cd ..

echo *********************************************
echo *  Generating `ISE.Reflection.Support.dll'  *
echo *********************************************

cd ISE.Reflection.Support
cd ace_file
if not exist ISE.Reflection.Support.epr goto generate_support
if not exist EIFGEN goto generate_support
cd EIFGEN
cd W_code
if not exist ISE.Reflection.Support.dll goto generate_support
gacutil -u ISE.Reflection.Support
gacutil -i ISE.Reflection.Support.dll
cd ..
cd ..
goto support_generated

:generate_support
gacutil -u ISE.Reflection.Support
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.Support.dll
copy .\ISE.Reflection.Support.dll ..\..\..\..\bin
cd ..
cd ..
:support_generated
cd ..
cd ..

echo ****************************************************************
echo *   Emitting Eiffel classes from `ISE.Reflection.Support.dll'  *
echo ****************************************************************

cd generated
cd support_generated
if exist *.e goto support_emitted
copy ..\..\bin\ISE.Reflection.Formatter.dll ..\..\..\..\tools\emitter
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.Support.dll 
:support_emitted
cd ..
cd ..

echo ******************************************************************
echo *    Generating `ISE.Reflection.EiffelAssemblyCacheHandler.dll'  *
echo ******************************************************************

cd ISE.Reflection.EiffelAssemblyCacheHandler
cd ace_file
if not exist ISE.Reflection.EiffelAssemblyCacheHandler.epr goto generate_cache_handler
if not exist EIFGEN goto generate_cache_handler
cd EIFGEN
cd W_code
if not exist ISE.Reflection.EiffelAssemblyCacheHandler.dll goto generate_cache_handler
gacutil -u ISE.Reflection.EiffelAssemblyCacheHandler
gacutil -i ISE.Reflection.EiffelAssemblyCacheHandler.dll
cd ..
cd ..
goto cache_handler_generated

:generate_cache_handler
gacutil -u ISE.Reflection.EiffelAssemblyCacheHandler
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.EiffelAssemblyCacheHandler.dll
copy .\ISE.Reflection.EiffelAssemblyCacheHandler.dll ..\..\..\..\bin
cd ..
cd ..
:cache_handler_generated
cd ..
cd ..

echo **********************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.EiffelAssemblyCacheHandler.dll'  *
echo **********************************************************************************

cd generated
cd eiffel_assembly_cache_generated
if exist *.e goto cache_handler_emitted
copy ..\..\bin\ISE.Reflection.Support.dll ..\..\..\..\tools\emitter
copy ..\..\bin\ISE.Reflection.EiffelAssemblyCacheNotifier.dll ..\..\..\..\tools\emitter
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.EiffelAssemblyCacheHandler.dll 
:cache_handler_emitted
cd ..
cd ..

echo ***************************************************
echo *  Generating `ISE.Reflection.CodeGenerator.dll'  *
echo ***************************************************

cd ISE.Reflection.CodeGenerator
cd ace_file
if not exist ISE.Reflection.CodeGenerator.epr goto generate_code_generator
if not exist EIFGEN goto generate_code_generator
cd EIFGEN
cd W_code
if not exist ISE.Reflection.CodeGenerator.dll goto generate_code_generator
gacutil -u ISE.Reflection.CodeGenerator
gacutil -i ISE.Reflection.CodeGenerator.dll
cd ..
cd ..
goto code_generator_generated

:generate_code_generator
gacutil -u ISE.Reflection.CodeGenerator
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.CodeGenerator.dll
copy .\ISE.Reflection.CodeGenerator.dll ..\..\..\..\bin
cd ..
cd ..
:code_generator_generated
cd ..
cd ..

echo *********************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.CodeGenerator.dll'  *
echo *********************************************************************

cd generated
cd code_generator_generated
if exist *.e goto code_generator_emitted
copy ..\..\bin\ISE.Reflection.EiffelAssemblyCacheHandler.dll ..\..\..\..\tools\emitter
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.CodeGenerator.dll 
:code_generator_emitted
cd ..
cd ..

echo *********************************************************
echo *  Generating `ISE.Reflection.ReflectionInterface.dll'  *
echo *********************************************************

cd ISE.Reflection.ReflectionInterface
cd ace_file
if not exist ISE.Reflection.ReflectionInterface.epr goto generate_reflection_interface
if not exist EIFGEN goto generate_reflection_interface
cd EIFGEN
cd W_code
if not exist ISE.Reflection.ReflectionInterface.dll goto generate_reflection_interface
gacutil -u ISE.Reflection.ReflectionInterface
gacutil -i ISE.Reflection.ReflectionInterface.dll
cd ..
cd ..
goto reflection_interface_generated

:generate_reflection_interface
gacutil -u ISE.Reflection.ReflectionInterface
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace 
cd EIFGEN
cd W_code
gacutil -i ISE.Reflection.ReflectionInterface.dll
copy .\ISE.Reflection.ReflectionInterface.dll ..\..\..\..\bin
cd ..
cd ..
:reflection_interface_generated
cd ..
cd ..

echo **************************************************************************
echo *  Emitting Eiffel classes from `ISE.Reflection.ReflectionInterface.dll' *
echo **************************************************************************

cd generated
cd reflection_interface_generated
if exist *.e goto reflection_interface_emitted
..\..\..\..\tools\emitter\emitter.exe /t ..\..\bin\ISE.Reflection.ReflectionInterface.dll 
:reflection_interface_emitted
cd ..
cd ..
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
if exist ISE.AssemblyManager.WindowsDirectoryExtractor.dll goto directory_extractor_generated
gacutil -u ISE.AssemblyManager.WindowsDirectoryExtractor
call make.bat
gacutil -i ISE.AssemblyManager.WindowsDirectoryExtractor.dll
copy ISE.AssemblyManager.WindowsDirectoryExtractor.dll ..\..\bin
copy windowsdirectoryextractor.netmodule ..\..\bin
goto directory_extractor_registered

:directory_extractor_generated
gacutil -u ISE.AssemblyManager.WindowsDirectoryExtractor
gacutil -i ISE.AssemblyManager.WindowsDirectoryExtractor.dll
:directory_extractor_registered

echo *************************************************************
echo * Generating `FolderBrowser.dll' and `FolderDialog.dll'     *
echo *************************************************************

cd ..
cd folder_dialog
cd Core
if exist FolderBrowser.dll goto folder_dialog_generated
gacutil -u FolderBrowser
gacutil -u FolderDialog
call build.bat
gacutil -i FolderBrowser.dll
gacutil -i FolderDialog.dll
copy FolderBrowser.dll ..\..\..\bin
copy FolderDialog.dll ..\..\..\bin
copy folderdialog.netmodule ..\..\..\bin
goto folder_dialog_registered

:folder_dialog_generated
gacutil -u FolderBrowser
gacutil -u FolderDialog
call build.bat
gacutil -i FolderBrowser.dll
gacutil -i FolderDialog.dll
:folder_dialog_registered

cd ..
cd Clib
if exist ecom_client.lib goto lib_generated
del *.lib
call make_finalize.bat
:lib_generated
cd ..

echo *************************************
echo *  Generating `folder_browser.dll'  *
echo *************************************

if not exist folder_browser.epr goto generate_folder_browser
if not exist EIFGEN goto generate_folder_browser
cd EIFGEN
cd F_code
if not exist folder_browser.dll goto generate_folder_browser
regsvr32 folder_browser.dll
cd ..
cd ..
goto folder_browser_generated

:generate_folder_browser
del *.epr
rd /q /s EIFGEN
ec -ace Ace.ace -finalize
cd EIFGEN
cd F_code
finish_freezing
regsvr32 folder_browser.dll
copy .\folder_browser.dll ..\..\..\..\bin
cd ..
cd ..
:folder_browser_generated
cd ..
cd ..

echo *********************************************
echo *  Generating `ISE.Reflection.Emitter.exe'  *
echo *********************************************

cd ISE.Reflection.Emitter
if exist ISE.Reflection.Emitter.exe goto emitter_generated
gacutil -u ISE.Reflection.Emitter
sn -k Key
call make.bat
gacutil -i ISE.Reflection.Emitter.exe
copy ISE.Reflection.Emitter.exe ..\bin
goto emitter_registered

:emitter_generated
gacutil -u ISE.Reflection.Emitter
gacutil -i ISE.Reflection.Emitter.exe
:emitter_registered
cd ..

echo ******************************************
echo *  Generating `ISE.AssemblyManager.exe'  *
echo ******************************************

cd assembly_manager
cd ace_file
if not exist ISE.AssemblyManager.epr goto generate_assembly_manager
if not exist EIFGEN goto generate_assembly_manager
cd EIFGEN
cd W_code
if not exist ISE.AssemblyManager.dll goto generate_assembly_manager
gacutil -u ISE.AssemblyManager
gacutil -i ISE.AssemblyManager.exe
cd ..
cd ..
goto assembly_manager_generated

:generate_assembly_manager
gacutil -u ISE.AssemblyManager
cd ..
cd ..
del *.epr
rd /q /s EIFGEN
ec -ace ace.ace
cd EIFGEN
cd W_code
gacutil -i ISE.AssemblyManager.exe
copy ISE.AssemblyManager.exe ..\..\..\..\bin

:assembly_manager_generated