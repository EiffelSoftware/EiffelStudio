@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF %ISE_EIFFEL% == "" ECHO ISE_EIFFEL is not defined !!
IF %ISE_EIFFEL% == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin

IF NOT EXIST build_studio CALL setup_studio.bat

CD build_studio\EiffelSoftware.EiffelBase
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ec -ace ace.ace -precompile -finalize -c_compile
CD ..\..
IF EXIST build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.EiffelBase.dll was generated in build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code)
GOTO END

:CACHE
CD build_studio\EiffelSoftware.CacheBrowser
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ec -ace ace.ace -precompile -finalize -c_compile
CD ..\..
IF EXIST build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CacheBrowser.dll was generated in build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code)
GOTO END

:PROVIDER
CD build_studio\EiffelSoftware.CodeDom
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ec -ace ace.ace -precompile -finalize -c_compile
CD ..\..
IF EXIST build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO END
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated in build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code)
GOTO END

:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.