@ECHO OFF

IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO BASE
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO BASE

ECHO Error: could not find Visual Studio installation...
GOTO END

:BASE
CD build_studio
ECHO Registering EiffelSoftware.EiffelBase.dll
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll gacutil -if EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll GOTO LIBBASE
ECHO Could not find build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\EiffelSoftware.EiffelBase.dll

:LIBBASE
ECHO Registering libEiffelSoftware.EiffelBase.dll
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll COPY /Y EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll %WINDIR%\System32
IF EXIST EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll GOTO VISION2
ECHO Could not find build_studio\EiffelSoftware.EiffelBase\EIFGEN\F_code\libEiffelSoftware.EiffelBase.dll

:VISION2
ECHO Registering EiffelSoftware.EiffelVision2.dll
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll gacutil -if EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll GOTO LIBVISION2
ECHO Could not find build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\EiffelSoftware.EiffelVision2.dll

:LIBVISION2
ECHO Registering libEiffelSoftware.EiffelVision2.dll
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll COPY /Y EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll %WINDIR%\System32
IF EXIST EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll GOTO CACHE
ECHO Could not find build_studio\EiffelSoftware.EiffelVision2\EIFGEN\F_code\libEiffelSoftware.EiffelVision2.dll

:CACHE
ECHO Registering EiffelSoftware.CacheBrowser.dll
IF EXIST EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll gacutil -if EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll
IF EXIST EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll GOTO CODEDOM
ECHO Could not find build_studio\EiffelSoftware.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CacheBrowser.dll

:CODEDOM
ECHO Registering EiffelSoftware.CodeDom.dll
IF EXIST EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll gacutil -if EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll
IF EXIST EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll GOTO PROVIDER
ECHO Could not find build_studio\EiffelSoftware.CodeDom\EIFGEN\F_code\EiffelSoftware.CodeDom.dll

:PROVIDER
CD ..
ECHO Registering EiffelSoftware.CodedomSerializer.dll
IF EXIST test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll gacutil -if test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll
IF EXIST test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll GOTO END
ECHO Could not find test\serializer\provider\EIFGEN\F_code\EiffelSoftware.CodedomSerializer.dll

:END
ECHO Done.