@ECHO OFF
IF '%1' == '' GOTO USAGE
IF '%2' == '' GOTO USAGE
IF '%3' == '' GOTO USAGE

REM *********************************************
ECHO Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO ***********************************
ECHO Building with following settings:

SET ISE_PLATFORM=windows
SET ISE_C_COMPILER=msc
SET INIT_PATH=%PATH%;

REM Change these between releases:
SET RELEASE=Eiffel_55
ECHO RELEASE=%RELEASE%
SET COMPILER_RELEASE=%2
ECHO COMPILER_RELEASE=%COMPILER_RELEASE%
SET CODEDOM_RELEASE=%1
ECHO CODEDOM_RELEASE=%CODEDOM_RELEASE%
SET GOBO_SRC=\\mahogany\e$\gobo_ise
ECHO GOBO_SRC=%GOBO_SRC%
SET EIFFEL_SRC=%CD%\checkout
ECHO EIFFEL_SRC=%EIFFEL_SRC%
SET GOBO=%CD%\checkout\library\gobo
ECHO GOBO=%GOBO%
SET ECLOP=%CD%\checkout\eclop
ECHO ECLOP=%ECLOP%
ECHO ***********************************

ECHO Setting up folders
IF EXIST delivery RD /Q /S delivery
IF EXIST delivery GOTO END
MKDIR delivery
IF EXIST checkout GOTO COMPILER
MKDIR checkout
CALL checkout.bat
CALL setup.bat %3

:COMPILER
ECHO Building compiler
CALL build_compiler.bat %3
IF "%COMPILER_BUILT%"=="" GOTO END

ECHO Building codedom
CALL build_codedom.bat %3
IF "%CODEDOM_BUILT%"=="" GOTO END

ECHO Building installer
CD checkout\tools\silent_launcher
IF EXIST EIFGEN rd /q /s EIFGEN
IF EXIST installer.epr del installer.epr
SET ISE_CFLAGS=-D WINVER=0x500
"%3\studio\spec\windows\bin\ec" -finalize -c_compile -ace ace.codedom.ace
IF NOT EXIST EIFGEN\F_Code\installer.exe ECHO Build failed, could not find EIFGEN\F_Code\installer.exe!!
IF NOT EXIST EIFGEN\F_Code\installer.exe GOTO END
COPY EIFGEN\F_Code\installer.exe ..\..\..\delivery

CD ..\..\..\..
GOTO END

:USAGE
ECHO Usage: build.bat BRANCH COMP_BRANCH $ISE_EIFFEL
ECHO --
ECHO BRANCH: CVS branch for codedom sources (e.g. HEAD)
ECHO COMP_BRANCH: CVS branch of delivery compiler (e.g. Eiffel_55_new_consumer)
ECHO $ISE_EIFFEL: ES Installation used to build delivery (e.g. C:\Eiffel55)

:END
ECHO Done.
