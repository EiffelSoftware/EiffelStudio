@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF "%ISE_EIFFEL%" == "" ECHO ISE_EIFFEL is not defined !!
IF "%ISE_EIFFEL%" == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin

IF "%1"=="/release" GOTO CDREL
IF NOT EXIST build_studio_debug CALL setup_studio.bat %1
CD build_studio_debug\EiffelSoftware.CodeDom.Base
GOTO BASE

:CDREL
IF NOT EXIST build_studio CALL setup_studio.bat %1
CD build_studio\EiffelSoftware.CodeDom.Base

:BASE
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDom.Base
ECHO -
REM ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Base.dll was generated in build_studio\EiffelSoftware.CodeDom.Base\EIFGEN\F_code)
GOTO END

:CACHE
CD ..
CD EiffelSoftware.CodeDom.CacheBrowser
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel Cache Browser
ECHO -
REM ec -ace ace.ace -precompile -finalize
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.CacheBrowser.dll was generated in build_studio\EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code)
GOTO END

:PROVIDER
CD ..
CD EiffelSoftware.CodeDom
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Provider
ECHO -
REM ec -ace ace.ace -finalize
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated in build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code)
GOTO END

:VISION2
CD ..
CD EiffelSoftware.CodeDom.Vision2
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDom.Vision2
ECHO -
REM ec -ace ace.ace -precompile -finalize -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll GOTO SPLITDLL
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Vision2.dll was generated in build_studio\EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code)
GOTO END

:SPLITDLL
CD ..
CD EiffelSoftware.CodeDom.Splitter
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDom.Splitter
ECHO -
REM ec -ace ace.ace -precompile -finalize
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.Splitter.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Splitter.dll was generated in build_studio\EiffelSoftware.CodeDom.Splitter\EIFGEN\F_code)
GOTO END

:MANAGER
CD ..
CD ecdpman
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Manager
ECHO -
COPY ..\..\manager\ecdpman.ico .
COPY ..\..\manager\ecdpman.rc .
REM ec -ace ace.ace -finalize
IF EXIST EIFGEN\F_code\ecdpman.exe GOTO SPLITTER
ECHO Compilation failed !! (no ecdpman.exe was generated in build_studio\ecdpman\EIFGEN\F_code)
GOTO END

:SPLITTER
CD ..
CD esplitter
REM IF EXIST EIFGEN RD /Q /S EIFGEN
REM IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING eSplitter
ECHO -
REM ec -ace ace.ace -finalize
IF EXIST EIFGEN\F_code\esplitter.exe GOTO SPLIT
ECHO Compilation failed !! (no esplitter.exe was generated in build_studio\esplitter\EIFGEN\F_code)
GOTO END

:SPLIT
CD ..
CD esplit
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING eSplit
ECHO -
ec -ace ace.ace -finalize
IF EXIST EIFGEN\F_code\esplit.exe GOTO END
ECHO Compilation failed !! (no esplit.exe was generated in build_studio\esplit\EIFGEN\F_code)
GOTO END

CD ..\..
:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
