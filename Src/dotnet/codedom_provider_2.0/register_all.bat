@ECHO OFF

:START
CD bin

:BASE
ECHO Registering EiffelSoftware.CodeDom.Base.dll
IF EXIST Base\EIFGENs\base\F_code\EiffelSoftware.CodeDom.Base.dll (
	gacutil -if Base\EIFGENs\base\F_code\EiffelSoftware.CodeDom.Base.dll /nologo
	GOTO LIBBASE
)
ECHO Could not find EiffelSoftware.CodeDom.Base.dll

:LIBBASE
ECHO Registering libEiffelSoftware.CodeDom.Base.dll
IF EXIST Base\EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base.dll (
	COPY /Y Base\EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base.dll %WINDIR%\System32
	IF EXIST %WINDIR%\SysWow64 COPY /Y Base\EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base.dll %WINDIR%\SysWow64
	GOTO VISION2
)
ECHO Could not find libEiffelSoftware.CodeDom.Base.dll

:VISION2
ECHO Registering EiffelSoftware.CodeDom.Vision2.dll
IF EXIST Vision2\EIFGENs\vision2\F_code\EiffelSoftware.CodeDom.Vision2.dll (
	gacutil -if Vision2\EIFGENs\vision2\F_code\EiffelSoftware.CodeDom.Vision2.dll /nologo
	GOTO LIBVISION2
)
ECHO Could not find EiffelSoftware.CodeDom.Vision2.dll

:LIBVISION2
ECHO Registering libEiffelSoftware.CodeDom.Vision2.dll
IF EXIST Vision2\EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2.dll (
	COPY /Y Vision2\EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2.dll %WINDIR%\System32
	IF EXIST %WINDIR%\SysWow64 COPY /Y Vision2\EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2.dll %WINDIR%\SysWow64
	GOTO CACHE
)
ECHO Could not find EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll

:CACHE
ECHO Registering EiffelSoftware.CodeDom.CacheBrowser.dll
IF EXIST cache_browser\EIFGENs\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll (
	gacutil -if cache_browser\EIFGENs\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll /nologo
	GOTO CODEDOM
)
ECHO Could not find EiffelSoftware.CodeDom.CacheBrowser.dll

:CODEDOM
ECHO Registering EiffelSoftware.CodeDom.dll
IF EXIST codedom_provider\EIFGENs\debug\F_code\EiffelSoftware.CodeDom.dll (
	gacutil -if codedom_provider\EIFGENs\debug\F_code\EiffelSoftware.CodeDom.dll /nologo
	installutil codedom_provider\EIFGENs\debug\F_code\EiffelSoftware.CodeDom.dll
	GOTO END
)
ECHO Could not find EiffelSoftware.CodeDom.dll

:END
CD ..
ECHO Done.
