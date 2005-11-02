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
SET RELEASE=Eiffel_56
ECHO RELEASE=%RELEASE%
SET COMPILER_RELEASE=%2
ECHO COMPILER_RELEASE=%COMPILER_RELEASE%
SET CODEDOM_RELEASE=%1
ECHO CODEDOM_RELEASE=%CODEDOM_RELEASE%
SET GOBO_SRC=\Sources\library\gobo
ECHO GOBO_SRC=%GOBO_SRC%
SET EIFFEL_SRC=%CD%\checkout
ECHO EIFFEL_SRC=%EIFFEL_SRC%
SET GOBO=%CD%\checkout\library\gobo
ECHO GOBO=%GOBO%
SET ECLOP=%CD%\checkout\eclop
ECHO ECLOP=%ECLOP%
ECHO ***********************************

ECHO Setting up folders
SET ECPOriginalPath=%CD%
IF EXIST delivery RD /Q /S delivery
IF EXIST delivery ECHO Could not delete delivery folder, existing.
IF EXIST delivery GOTO END
MKDIR delivery
IF EXIST checkout GOTO COMPILER
MKDIR checkout
CALL scripts\checkout.bat
CALL scripts\setup.bat %3

:COMPILER
ECHO Building compiler
CALL "%ECPOriginalPath%\scripts\build_compiler.bat" %3
IF "%COMPILER_BUILT%"=="" GOTO END

ECHO Building codedom
CALL "%ECPOriginalPath%\scripts\build_codedom.bat" %3
IF "%CODEDOM_BUILT%"=="" GOTO END

ECHO Building installer
CD checkout\tools\silent_launcher
IF EXIST EIFGEN rd /q /s EIFGEN
IF EXIST installer.epr del installer.epr
SET ISE_CFLAGS=-D WINVER=0x500
"%3\studio\spec\windows\bin\ec" -finalize -c_compile -ace ace.codedom.ace
IF NOT EXIST EIFGEN\F_Code\installer.exe ECHO Build failed, could not find EIFGEN\F_Code\installer.exe!!
IF NOT EXIST EIFGEN\F_Code\installer.exe GOTO END
COPY EIFGEN\F_Code\installer.exe ..\..\..\files

CD "%ECPOriginalPath%"
CALL scripts\build_docs.bat %3
IF "%DOCS_BUILT%"=="" GOTO END

ECHO Building MSI
CD scripts
CALL make_msi.bat
CD ..
GOTO END

:USAGE
ECHO Usage: build.bat BRANCH COMP_BRANCH $ISE_EIFFEL DESTINATION
ECHO --
ECHO BRANCH: CVS branch for codedom sources (e.g. HEAD)
ECHO COMP_BRANCH: CVS branch of delivery compiler (e.g. Eiffel_55_new_consumer)
ECHO $ISE_EIFFEL: ES Installation used to build delivery (e.g. C:\Eiffel55)
ECHO DESTINATION: Folder where to generate installation (current folder by default)

:END
ECHO Done.
