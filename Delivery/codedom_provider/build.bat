@ECHO OFF
REM *********************************************
ECHO Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO ***********************************
ECHO Building with following settings:

IF "%ISE_EIFFEL%"=="" ECHO ISE_EIFFEL not defined!!
IF "%ISE_EIFFEL%"=="" GOTO END
ECHO ISE_EIFFEL=%ISE_EIFFEL%

REM Change this to match your path:
SET C_COMPILER_PATH=d:\dev\micros~1.net\vc7
ECHO C_COMPILER_PATH=%C_COMPILER_PATH%

REM Change these between releases:
SET CODEDOM_RELEASE=HEAD
ECHO CODEDOM_RELEASE=%CODEDOM_RELEASE%
SET COMPILER_RELEASE=HEAD
ECHO COMPILER_RELEASE=%COMPILER_RELEASE%

SET EIFFEL_SRC=%CD%\checkout
ECHO EIFFEL_SRC=%EIFFEL_SRC%
SET GOBO=%CD%\checkout\library\gobo
ECHO GOBO=%GOBO%
SET ECLOP=%CD%\checkout\eclop
ECHO ECLOP=%ECLOP%
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin
ECHO PATH=%PATH%
ECHO ***********************************

ECHO Setting up folders
IF EXIST delivery RD /Q /S delivery
IF EXIST delivery GOTO END
MKDIR delivery
IF EXIST checkout GOTO COMPILER
MKDIR checkout
CALL checkout.bat
CALL setup.bat

:COMPILER
ECHO Building compiler
CALL build_compiler.bat
IF "%COMPILER_BUILT%"=="" GOTO END

ECHO Building codedom
CALL build_codedom.bat
IF "%CODEDOM_BUILT%"=="" GOTO END

ECHO Building silent_launcher
CD checkout\tools\silent_launcher
IF EXIST EIFGEN rd /q /s EIFGEN
IF EXIST silent_launcher.epr del silent_launcher.epr
SET ISE_CFLAGS=-D WINVER=0x500
ec -finalize -c_compile -ace silent_launcher.ace
IF NOT EXIST EIFGEN\F_Code\silent_launcher.exe ECHO Build failed, could not find EIFGEN\F_Code\silent_launcher.exe!!
IF NOT EXIST EIFGEN\F_Code\silent_launcher.exe GOTO END
COPY EIFGEN\F_Code\silent_launcher.exe ..\..\..\delivery

ECHO Building intaller_launcher
CD ..\silent_launcher
IF EXIST EIFGEN rd /q /s EIFGEN
IF EXIST installer_launcher.epr del installer_launcher.epr
SET ISE_CFLAGS=
ec -finalize -c_compile -ace ace.ace
IF NOT EXIST EIFGEN\F_Code\installer_launcher.exe ECHO Build failed, could not find EIFGEN\F_Code\installer_launcher.exe!!
IF NOT EXIST EIFGEN\F_Code\installer_launcher.exe GOTO END
COPY EIFGEN\F_Code\installer_launcher.exe ..\..\..\delivery
CD ..\..\..
:END
ECHO Done.