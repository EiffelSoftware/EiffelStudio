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
ec -ace ace.ace -finalize -c_compile
CD ..\..
IF EXIST build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated in build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code)
GOTO END

:VISION2
CD build_studio\EiffelSoftware.EiffelVision2
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ec -ace ace.ace -precompile -finalize -c_compile
CD ..\..
IF EXIST build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.EiffelVision2.dll was generated in build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code)
GOTO END

:MANAGER
CD build_studio\ecd_manager
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL /Q /F *.epr
ec -ace ace.ace -finalize -c_compile
CD ..\..
IF EXIST build_studio\ecd_manager\EIFGEN\F_code\ecd_manager.exe GOTO END
ECHO Compilation failed !! (no ecd_manager.exe was generated in build_studio\ecd_manager\EIFGEN\F_code)
GOTO END

:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.