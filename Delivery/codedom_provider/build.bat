@ECHO OFF
IF '%1' == '' GOTO USAGE
IF '%2' == '' GOTO USAGE

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
SET COMPILER_RELEASE=Eiffel_55_new_consumer
ECHO COMPILER_RELEASE=%COMPILER_RELEASE%
SET CODEDOM_RELEASE=HEAD
ECHO CODEDOM_RELEASE=%CODEDOM_RELEASE%

SET EIFFEL_SRC=%CD%\checkout\compiler
ECHO EIFFEL_SRC=%EIFFEL_SRC%
SET GOBO=%CD%\checkout\head\library\gobo
ECHO GOBO=%GOBO%
SET ECLOP=%CD%\checkout\head\eclop
ECHO ECLOP=%ECLOP%
ECHO ***********************************

ECHO Setting up folders
IF EXIST delivery RD /Q /S delivery
IF EXIST delivery GOTO END
MKDIR delivery
IF EXIST checkout GOTO COMPILER
MKDIR checkout
CALL checkout.bat
CALL setup.bat %1 %2

:COMPILER
ECHO Building compiler
REM CALL build_compiler.bat %1
REM IF "%COMPILER_BUILT%"=="" GOTO END

ECHO Building codedom
CALL build_codedom.bat %2
IF "%CODEDOM_BUILT%"=="" GOTO END

ECHO Building installer
CD checkout\head\tools\silent_launcher
IF EXIST EIFGEN rd /q /s EIFGEN
IF EXIST installer.epr del installer.epr
SET ISE_CFLAGS=-D WINVER=0x500
"%2\studio\spec\windows\bin\ec" -finalize -c_compile -ace ace.codedom.ace
IF NOT EXIST EIFGEN\F_Code\installer.exe ECHO Build failed, could not find EIFGEN\F_Code\installer.exe!!
IF NOT EXIST EIFGEN\F_Code\installer.exe GOTO END
COPY EIFGEN\F_Code\installer.exe ..\..\..\..\delivery

CD ..\..\..\..
GOTO END

:USAGE
ECHO                                                               .
ECHO Usage: build.bat $ISE_EIFFEL_REL $ISE_EIFFEL_DEV              .
ECHO --------------------------------------------                  .
ECHO                                                               .
ECHO $ISE_EIFFEL_REL is path to EiffelStudio last release delivery .
ECHO $ISE_EIFFEL_DEV is path to development EiffelStudio           .
ECHO                                                               .

:END
ECHO Done.