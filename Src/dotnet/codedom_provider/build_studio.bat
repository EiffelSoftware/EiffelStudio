@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF %ISE_EIFFEL% == "" ECHO ISE_EIFFEL is not defined !!
IF %ISE_EIFFEL% == "" EXIT 1
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin

IF "%1"=="release" GOTO CDREL
IF NOT EXIST build_studio_debug CALL setup_studio.bat %1
CD build_studio_debug\EiffelSoftware.EiffelBase
GOTO BASE

:CDREL
IF NOT EXIST build_studio CALL setup_studio.bat %1
CD build_studio\EiffelSoftware.EiffelBase

:BASE
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING EiffelBase
ECHO -
ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.EiffelBase.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.EiffelBase.dll was generated in build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code)
GOTO END

:CACHE
CD ..
CD EiffelSoftware.CacheBrowser
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel Cache Browser
ECHO -
ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CacheBrowser.dll was generated in build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code)
GOTO END

:PROVIDER
CD ..
CD EiffelSoftware.CodeDom
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Provider
ECHO -
ec -ace ace.ace -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated in build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code)
GOTO END

:VISION2
CD ..
CD EiffelSoftware.EiffelVision2
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING EiffelVision2
ECHO -
ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.EiffelVision2.dll was generated in build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code)
GOTO END

:MANAGER
CD ..
CD ecd_manager
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Manager
ECHO -
COPY ..\..\manager\ecd_manager.ico .
COPY ..\..\manager\ecd_manager.rc .

ec -ace ace.ace -finalize -c_compile
IF EXIST EIFGEN\F_code\ecd_manager.exe GOTO END
ECHO Compilation failed !! (no ecd_manager.exe was generated in build_studio\ecd_manager\EIFGEN\F_code)
GOTO END

:END
CD ..\..
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
