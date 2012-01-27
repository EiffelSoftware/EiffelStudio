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
SET CODEDOM_DELIVERY=%CD%

REM Change these between releases:
SET RELEASE=trunk
ECHO RELEASE=%RELEASE%
SET COMPILER_RELEASE=%2
ECHO COMPILER_RELEASE=%COMPILER_RELEASE%
SET CODEDOM_RELEASE=%1
ECHO CODEDOM_RELEASE=%CODEDOM_RELEASE%
SET GOBO_SRC=\57dev\library\gobo
ECHO GOBO_SRC=%GOBO_SRC%
IF NOT EXIST %GOBO_SRC% ECHO GOBO_SRC points to an invalid folder, exiting.
IF NOT EXIST %GOBO_SRC% GOTO END
SET EIFFEL_SRC=%CD%\checkout
ECHO EIFFEL_SRC=%EIFFEL_SRC%
SET GOBO=%CD%\checkout\library\gobo
ECHO GOBO=%GOBO%
SET ECLOP=%CD%\checkout\eclop
ECHO ECLOP=%ECLOP%
SET SVN_URL=svn://raphaels@svn.ise:3690/ise_svn
SET SVN_ORIGO_URL=https://eiffelsoftware.origo.ethz.ch/svn/es/
ECHO SVN_URL=%SVN_URL%
ECHO SVN_ORIGO_URL=%SVN_ORIGO_URL%
ECHO
ECHO C Compiler must be setup
ECHO hhc.exe must be in your path
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
IF EXIST EIFGENs rd /q /s EIFGENs
IF EXIST installer.epr del installer.epr
SET ISE_CFLAGS=-D WINVER=0x500
"%3\studio\spec\windows\bin\ec" -finalize -c_compile -config launcher.ecf -target codedom
IF NOT EXIST EIFGENs\codedom\F_Code\installer.exe ECHO Build failed, could not find EIFGEN\F_Code\installer.exe!!
IF NOT EXIST EIFGENs\codedom\F_Code\installer.exe GOTO END
COPY EIFGENs\codedom\F_Code\installer.exe ..\..\..\files
SET ISE_CFLAGS=

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
ECHO BRANCH: SVN branch for codedom sources (e.g. trunk)
ECHO COMP_BRANCH: SVN branch of delivery compiler (e.g. branches/Eiffel_56_new_consumer)
ECHO $ISE_EIFFEL: ES Installation used to build delivery (e.g. C:\Eiffel56)
ECHO DESTINATION: Folder where to generate installation (current folder by default)

:END
ECHO Done.
