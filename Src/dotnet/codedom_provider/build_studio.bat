@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF "%ISE_EIFFEL%" == "" ECHO ISE_EIFFEL is not defined !!
IF "%ISE_EIFFEL%" == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin

IF "%1"=="/release" GOTO CDREL
IF NOT EXIST build_studio_debug CALL setup_studio.bat %1
CD build_studio_debug\EiffelSoftware.CodeDomBase
GOTO BASE

:CDREL
IF NOT EXIST build_studio CALL setup_studio.bat %1
CD build_studio\EiffelSoftware.CodeDomBase

:BASE
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDomBase
ECHO -
ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDomBase.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.CodeDomBase.dll was generated in build_studio\EiffelSoftware.CodeDomBase\EIFGEN\F_code)
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
CD EiffelSoftware.CodeDomVision2
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDomVision2
ECHO -
ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDomVision2.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.CodeDomVision2.dll was generated in build_studio\EiffelSoftware.CodeDomVision2\EIFGEN\F_code)
GOTO END

:MANAGER
CD ..
CD ecdpman
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Manager
ECHO -
COPY ..\..\manager\ecdpman.ico .
COPY ..\..\manager\ecdpman.rc .

ec -ace ace.ace -finalize -c_compile
IF EXIST EIFGEN\F_code\ecdpman.exe GOTO END
ECHO Compilation failed !! (no ecdpman.exe was generated in build_studio\ecdpman\EIFGEN\F_code)
GOTO END

:END
CD ..\..
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
