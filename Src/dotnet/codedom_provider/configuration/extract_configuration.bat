@REM Use this script to extract the configuration files from the current build
@REM and replace the content of the configuration folder with them.

@ECHO OFF

IF EXIST ..\build_envision\EiffelSoftware.EiffelBase\EiffelSoftware.EiffelBase.eifp COPY /Y ..\build_envision\EiffelSoftware.EiffelBase\EiffelSoftware.EiffelBase.eifp base.eifp
IF EXIST ..\build_envision\EiffelSoftware.EiffelBase\EiffelSoftware.EiffelBase.eifp GOTO VISION2
ECHO Could not find ..\build_envision\EiffelSoftware.EiffelBase\EiffelSoftware.EiffelBase.eifp !!

:VISION2
IF EXIST ..\build_envision\EiffelSoftware.EiffelVision2\EiffelSoftware.EiffelVision2.eifp COPY /Y ..\build_envision\EiffelSoftware.EiffelVision2\EiffelSoftware.EiffelVision2.eifp vision2.eifp
IF EXIST ..\build_envision\EiffelSoftware.EiffelVision2\EiffelSoftware.EiffelVision2.eifp GOTO CACHE
ECHO Could not find ..\build_envision\EiffelSoftware.EiffelVision2\EiffelSoftware.EiffelVision2.eifp !!

:CACHE
IF EXIST ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp COPY /Y ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp cache_browser.eifp
IF EXIST ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp GOTO PROVIDER
ECHO Could not find ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp !!

:PROVIDER
IF EXIST ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp COPY /Y ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp codedom_provider.eifp
IF EXIST ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp GOTO SOLUTION
ECHO Could not find ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp !!

:SOLUTION
IF EXIST ..\build_envision\codedom_provider.sln COPY /Y ..\build_envision\codedom_provider.sln codedom_provider.sln
IF EXIST ..\build_envision\codedom_provider.sln GOTO END
ECHO Could not find ..\build_envision\codedom_provider.sln !!

:END
ECHO Done copying Eiffel CodeDom Provider Eiffel ENViSioN! project settings.