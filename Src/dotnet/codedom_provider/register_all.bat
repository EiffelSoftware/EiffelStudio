@ECHO OFF

IF EXIST "%VS71COMNTOOLS%vsvars32.bat" CALL "%VS71COMNTOOLS%vsvars32.bat"
IF EXIST "%VS71COMNTOOLS%vsvars32.bat" GOTO START
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" CALL "%VSCOMNTOOLS%vsvars32.bat"
IF EXIST "%VSCOMNTOOLS%vsvars32.bat" GOTO START

ECHO Error: could not find Visual Studio installation...
GOTO END

:START
IF EXIST build_studio_debug GOTO DEBUG
CD build_studio
GOTO BASE
:DEBUG
CD build_studio_debug

:BASE
ECHO Registering EiffelSoftware.CodeDom.Base.dll
IF EXIST EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll gacutil -if EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll /nologo
IF EXIST EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll GOTO LIBBASE
ECHO Could not find EiffelSoftware.CodeDom.Base\EIFGEN\F_code\EiffelSoftware.CodeDom.Base.dll

:LIBBASE
ECHO Registering libEiffelSoftware.CodeDom.Base.dll
IF EXIST EiffelSoftware.CodeDom.Base\EIFGEN\F_code\libEiffelSoftware.CodeDom.Base.dll COPY /Y EiffelSoftware.CodeDom.Base\EIFGEN\F_code\libEiffelSoftware.CodeDom.Base.dll %WINDIR%\System32
IF EXIST EiffelSoftware.CodeDom.Base\EIFGEN\F_code\libEiffelSoftware.CodeDom.Base.dll GOTO VISION2
ECHO Could not find EiffelSoftware.CodeDom.Base\EIFGEN\F_code\libEiffelSoftware.CodeDom.Base.dll

:VISION2
ECHO Registering EiffelSoftware.CodeDom.Vision2.dll
IF EXIST EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll gacutil -if EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll /nologo
IF EXIST EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll GOTO LIBVISION2
ECHO Could not find EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\EiffelSoftware.CodeDom.Vision2.dll

:LIBVISION2
ECHO Registering libEiffelSoftware.CodeDom.Vision2.dll
IF EXIST EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll COPY /Y EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll %WINDIR%\System32
IF EXIST EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll GOTO CACHE
ECHO Could not find EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll

:CACHE
ECHO Registering EiffelSoftware.CodeDom.CacheBrowser.dll
IF EXIST EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll gacutil -if EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll /nologo
IF EXIST EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll GOTO CODEDOM
ECHO Could not find EiffelSoftware.CodeDom.CacheBrowser\EIFGEN\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll

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
