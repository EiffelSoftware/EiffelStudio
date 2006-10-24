@ECHO OFF

CD configuration

ECHO Registering EiffelSoftware.CodeDom.Base.dll
IF EXIST EIFGENs\base\F_code\EiffelSoftware.CodeDom.Base2_0.dll (
	gacutil -if EIFGENs\base\F_code\EiffelSoftware.CodeDom.Base2_0.dll /nologo
) ELSE (
	ECHO Could not find EiffelSoftware.CodeDom.Base.dll
)

ECHO Registering libEiffelSoftware.CodeDom.Base.dll
IF EXIST EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base2_0.dll (
	COPY /Y EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base2_0.dll %WINDIR%\System32
	IF EXIST %WINDIR%\SysWow64 COPY /Y EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base2_0.dll %WINDIR%\SysWow64
) ELSE (
	ECHO Could not find libEiffelSoftware.CodeDom.Base.dll
)

REM ECHO Registering EiffelSoftware.CodeDom.Vision2.dll
REM IF EXIST EIFGENs\vision2\F_code\EiffelSoftware.CodeDom.Vision2_0.dll (
	REM gacutil -if EIFGENs\vision2\F_code\EiffelSoftware.CodeDom.Vision2_0.dll /nologo
REM ) ELSE (
	REM ECHO Could not find EiffelSoftware.CodeDom.Vision2.dll
REM )
REM 
REM ECHO Registering libEiffelSoftware.CodeDom.Vision2.dll
REM IF EXIST EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2_0.dll (
	REM COPY /Y EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2_0.dll %WINDIR%\System32
	REM IF EXIST %WINDIR%\SysWow64 COPY /Y EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2_0.dll %WINDIR%\SysWow64
REM ) ELSE (
	REM ECHO Could not find EiffelSoftware.CodeDom.Vision2\EIFGEN\F_code\libEiffelSoftware.CodeDom.Vision2.dll
REM )

ECHO Registering EiffelSoftware.CodeDom.CacheBrowser.dll
IF EXIST EIFGENs\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser2_0.dll (
	gacutil -if EIFGENs\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser2_0.dll /nologo
) ELSE (
ECHO Could not find EiffelSoftware.CodeDom.CacheBrowser.dll
)

ECHO Registering EiffelSoftware.CodeDom.dll
IF EXIST EIFGENs\codedom_provider_debug\F_code\EiffelSoftware.CodeDom2_0.dll (
	gacutil -if EIFGENs\codedom_provider_debug\F_code\EiffelSoftware.CodeDom2_0.dll /nologo
	installutil EIFGENs\codedom_provider_debug\F_code\EiffelSoftware.CodeDom2_0.dll
) ELSE (
	ECHO Could not find EiffelSoftware.CodeDom.dll
)

CD ..
ECHO Done.
