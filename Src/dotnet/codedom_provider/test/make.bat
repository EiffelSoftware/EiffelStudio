@ECHO OFF
@REM Use this script to build the components required to test the
@REM Eiffel Codedom Provider.
@REM
@REM These components are:
@REM
@REM   * The Eiffel Codedom Serializer which can be used to serialize codedom
@REM     trees that can then be used to run the tests. The serializer itself is
@REM     comprised of:
@REM       - The serializer provider dll which actually serializes the codedom
@REM         trees.
@REM       - The gui which calls the serializer provider dll with the context
@REM         set through the interface (WSDL vs ASP.NET etc...).
@REM
@REM   * The Eiffel Codedom Tester which uses the codedom trees produced by the
@REM     Eiffel Codedom Serializer to test the implementation.

@REM ------------------------------------------------------------
@REM Change ISE_EIFFEL so that it points to the correct location:
@REM ------------------------------------------------------------
SET ISE_EIFFEL=d:\dev\eiffel55

SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\windows\bin
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO COMPILE
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO COMPILE

ECHO Error: could not find Visual Studio installation...
GOTO END

:COMPILE
@REM First compile Eiffel Codedom Serializer Provider:
ECHO Compiling Eiffel Codedom Serializer Provider...
CD serializer\provider
IF EXIST EIFGEN RD /q /s EIFGEN
DEL /f /q *.epr
ec -precompile -ace ace.ace -c_compile
CD EIFGEN\W_code
gacutil -if 
CD ..\..

@REM Then compile serializer gui:
ECHO Compiling Eiffel Codedom Serializer GUI...
CD ..\gui
IF EXIST EIFGEN RD /q /s EIFGEN
DEL /f /q *.epr
ec -finalize -ace ace.ace -c_compile

@REM Finally compile tester:
@REM ECHO Compiling Eiffel Codedom Tester...
@REM CD ..\..\gui
@REM IF EXIST EIFGEN RD /q /s EIFGEN
@REM DEL /f /q *.epr
@REM ec -finalize -ace ace.ace

:END
ECHO -----
ECHO Done.
