@ECHO OFF

IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO START
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO START

ECHO Error: could not find Visual Studio installation...
GOTO END

:START
ECHO Registering EiffelSoftware.Compiler.OutputHandler and EiffelSoftware.Compiler.OutputDispatcher
IF EXIST assemblies\output_processing\dispatcher\bin\Release\EiffelSoftware.Compiler.OutputDispatcher.dll gacutil -if assemblies\output_processing\dispatcher\bin\Release\EiffelSoftware.Compiler.OutputDispatcher.dll /nologo
IF EXIST assemblies\output_processing\dispatcher\bin\Release\EiffelSoftware.Compiler.OutputDispatcher.dll GOTO COMPILER2
ECHO Could not find assemblies\output_processing\dispatcher\bin\Release\EiffelSoftware.Compiler.OutputDispatcher.dll

:COMPILER2
IF EXIST assemblies\output_processing\handler\bin\Release\EiffelSoftware.Compiler.OutputHandler.dll gacutil -if assemblies\output_processing\handler\bin\Release\EiffelSoftware.Compiler.OutputHandler.dll /nologo
IF EXIST assemblies\output_processing\handler\bin\Release\EiffelSoftware.Compiler.OutputHandler.dll GOTO CHANGEDIR
ECHO Could not find assemblies\output_processing\handler\bin\Release\EiffelSoftware.Compiler.OutputHandler.dll

:CHANGEDIR
IF EXIST build_studio_debug GOTO DEBUG
CD build_studio
GOTO BASE
:DEBUG
CD build_studio_debug

:BASE
ECHO Registering EiffelSoftware.EiffelBase.dll
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll gacutil -if EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll /nologo
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll GOTO LIBBASE
ECHO Could not find EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll

:LIBBASE
ECHO Registering libEiffelSoftware.EiffelBase.dll
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll COPY /Y EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll %WINDIR%\System32
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll GOTO VISION2
ECHO Could not find EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll

:VISION2
ECHO Registering EiffelSoftware.EiffelVision2.dll
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll gacutil -if EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll /nologo
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll GOTO LIBVISION2
ECHO Could not find EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll

:LIBVISION2
ECHO Registering libEiffelSoftware.EiffelVision2.dll
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll COPY /Y EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll %WINDIR%\System32
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll GOTO CACHE
ECHO Could not find EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll

:CACHE
ECHO Registering EiffelSoftware.CacheBrowser.dll
IF EXIST EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll gacutil -if EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll /nologo
IF EXIST EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO CODEDOM
ECHO Could not find EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll

:CODEDOM
ECHO Registering EiffelSoftware.CodeDom.dll
IF EXIST EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll gacutil -if EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll /nologo
IF EXIST EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll installutil EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll
IF EXIST EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO PROVIDER
ECHO Could not find EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll

:PROVIDER
CD ..
ECHO Registering EiffelSoftware.CodedomSerializer.dll
IF EXIST test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll gacutil -if test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll /nologo
IF EXIST test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll GOTO END
ECHO Could not find test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll

:END
ECHO Done.
