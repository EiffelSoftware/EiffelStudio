@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

SET EFLAGS=-finalize -keep
IF "%ISE_EIFFEL%" == "" ECHO ISE_EIFFEL is not defined !!
IF "%ISE_EIFFEL%" == "" GOTO END
IF "%ISE_PLATFORM%" == "" ECHO ISE_PLATFORM is not defined !!
IF "%ISE_PLATFORM%" == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin

IF "%1"=="/release" GOTO CDREL
IF NOT EXIST build_studio_debug CALL setup_studio.bat %1
CD build_studio_debug\EiffelSoftware.CodeDom.Base
GOTO BASE

:CDREL
IF NOT EXIST build_studio CALL setup_studio.bat %1
CD build_studio\EiffelSoftware.CodeDom.Base

:BASE
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDom.Base
ECHO -
ec -ace ace.ace -precompile %EFLAGS% -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Base.dll was generated in build_studio\EiffelSoftware.CodeDom.Base\EIFGEN\F_code)
GOTO ENDCD

:CACHE
CD ..
CD EiffelSoftware.CodeDom.CacheBrowser
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel Cache Browser
ECHO -
ec -ace ace.ace -precompile %EFLAGS%
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.CacheBrowser.dll was generated in build_studio\EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code)
GOTO ENDCD

:PROVIDER
CD ..
CD EiffelSoftware.CodeDom
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Eiffel CodeDom Provider
ECHO -
ec -ace ace.ace -precompile %EFLAGS%
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated in build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code)
GOTO ENDCD

:VISION2
CD ..
CD EiffelSoftware.CodeDom.Vision2
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING CodeDom.Vision2
ECHO -
ec -ace ace.ace -precompile %EFLAGS% -c_compile
IF EXIST EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Vision2.dll was generated in build_studio\EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code)
GOTO ENDCD


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
ec -ace ace.ace %EFLAGS%
IF EXIST EIFGEN\F_code\ecdpman.exe GOTO SPLITTER
ECHO Compilation failed !! (no ecdpman.exe was generated in build_studio\ecdpman\EIFGEN\F_code)
GOTO ENDCD

:SPLITTER
CD ..
CD esplitter
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING eSplitter
ECHO -
ec -ace ace.ace %EFLAGS%
IF EXIST EIFGEN\F_code\esplitter.exe GOTO SPLIT
ECHO Compilation failed !! (no esplitter.exe was generated in build_studio\esplitter\EIFGEN\F_code)
GOTO ENDCD

:SPLIT
CD ..
CD esplit
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING eSplit
ECHO -
ec -ace ace.ace %EFLAGS%
IF EXIST EIFGEN\F_code\esplit.exe GOTO NMAP
ECHO Compilation failed !! (no esplit.exe was generated in build_studio\esplit\EIFGEN\F_code)
GOTO ENDCD

:NMAP
CD ..
CD nmap
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ECHO -
ECHO COMPILING Name Mapper
ECHO -
ec -ace ace.ace %EFLAGS%
IF EXIST EIFGEN\F_code\nmap.exe GOTO ENDCD
ECHO Compilation failed !! (no esplit.exe was generated in build_studio\esplit\EIFGEN\F_code)
GOTO ENDCD

:ENDCD
CD ..\..
CALL register_all.bat

:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
