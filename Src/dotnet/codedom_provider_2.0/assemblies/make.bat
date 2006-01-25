@ECHO OFF

ECHO Registering Compiler COM DLL
regsvr32 /s EiffelSoftware.Compiler.dll
IF EXIST EiffelSoftware.Compiler.Managed.dll del EiffelSoftware.Compiler.Managed.dll

ECHO Consuming COM DLL
tlbimp /out:EiffelSoftware.Compiler.Managed.dll /keyfile:%EIFFEL_SRC%\dotnet\helpers\isekey.snk EiffelSoftware.Compiler.dll /namespace:EiffelSoftware.Compiler /nologo
IF NOT EXIST EiffelSoftware.Compiler.Managed.dll ECHO COM DLL CONSUMPTION FAILED!
IF NOT EXIST EiffelSoftware.Compiler.Managed.dll GOTO END

ECHO Registering Managed DLL
regasm /codebase EiffelSoftware.Compiler.Managed.dll /nologo
gacutil -if EiffelSoftware.Compiler.Managed.dll /nologo

ECHO Building Compiler Output Processing DLLs
CD output_processing
nmake
CD ..

:END
ECHO Done.
