@ECHO OFF

IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO SETUP
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO SETUP

ECHO Error: could not find Visual Studio installation...
GOTO END

:SETUP
ECHO Registering Compiler COM DLL
regsvr32 /s EiffelSoftware.Compiler.dll
IF EXIST EiffelSoftware.Compiler.Managed.dll del EiffelSoftware.Compiler.Managed.dll

ECHO Consuming COM DLL
tlbimp /out:EiffelSoftware.Compiler.Managed.dll /keyfile:e:\sources\dotnet\helpers\isekey.snk EiffelSoftware.Compiler.dll /namespace:EiffelSoftware.Compiler /nologo
IF NOT EXIST EiffelSoftware.Compiler.Managed.dll ECHO COM DLL CONSUMPTION FAILED!
IF NOT EXIST EiffelSoftware.Compiler.Managed.dll GOTO END

ECHO Registering Managed DLL
regasm /codebase EiffelSoftware.Compiler.Managed.dll /nologo
gacutil -if EiffelSoftware.Compiler.Managed.dll /nologo

ECHO Building Compiler Output Processing DLLs
CD output_processing
devenv output_processing.sln /build release
CD ..

:END
ECHO Done.
