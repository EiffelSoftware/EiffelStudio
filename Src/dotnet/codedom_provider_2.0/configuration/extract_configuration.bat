@REM Use this script to extract the configuration files from the current build
@REM and replace the content of the configuration folder with them.

@ECHO OFF

IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Base\EiffelSoftware.CodeDom.Base.eifp COPY /Y ..\build_envision\EiffelSoftware.CodeDom.Base\EiffelSoftware.CodeDom.Base.eifp base.eifp
IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Base\EiffelSoftware.CodeDom.Base.eifp GOTO VISION2
ECHO Could not find ..\build_envision\EiffelSoftware.CodeDom.Base\EiffelSoftware.CodeDom.Base.eifp !!

:VISION2
IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Vision2\EiffelSoftware.CodeDom.Vision2.eifp COPY /Y ..\build_envision\EiffelSoftware.CodeDom.Vision2\EiffelSoftware.CodeDom.Vision2.eifp vision2.eifp
IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Vision2\EiffelSoftware.CodeDom.Vision2.eifp GOTO CACHE
ECHO Could not find ..\build_envision\EiffelSoftware.CodeDom.Vision2\EiffelSoftware.CodeDom.Vision2.eifp !!

:CACHE
IF EXIST ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp COPY /Y ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp cache_browser.eifp
IF EXIST ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp GOTO PROVIDER
ECHO Could not find ..\build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp !!

:PROVIDER
IF EXIST ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp COPY /Y ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp codedom_provider.eifp
IF EXIST ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp GOTO SPLITTER
ECHO Could not find ..\build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp !!

:SPLITTER
IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Splitter\EiffelSoftware.CodeDom.Splitter.eifp COPY /Y ..\build_envision\EiffelSoftware.CodeDom.Splitter\EiffelSoftware.CodeDom.Splitter.eifp splitter_common.eifp
IF EXIST ..\build_envision\EiffelSoftware.CodeDom.Splitter\EiffelSoftware.CodeDom.Splitter.eifp GOTO PROVIDER
ECHO Could not find ..\build_envision\EiffelSoftware.CodeDom.Splitter\EiffelSoftware.CodeDom.Splitter.eifp !!

:PROVIDER
IF EXIST ..\build_envision\ecdpman\ecdpman.eifp COPY /Y ..\build_envision\ecdpman\ecdpman.eifp ecdpman.eifp
IF EXIST ..\build_envision\ecdpman\ecdpman.eifp GOTO ESPLIT
ECHO Could not find ..\build_envision\ecdpman\ecdpman.eifp !!

:ESPLIT
IF EXIST ..\build_envision\esplit\esplit.eifp COPY /Y ..\build_envision\esplit\esplit.eifp esplit.eifp
IF EXIST ..\build_envision\esplit\esplit.eifp GOTO ESPLITTER
ECHO Could not find ..\build_envision\esplit\esplit.eifp !!

:ESPLITTER
IF EXIST ..\build_envision\esplitter\esplitter.eifp COPY /Y ..\build_envision\esplitter\esplitter.eifp esplitter.eifp
IF EXIST ..\build_envision\esplitter\esplitter.eifp GOTO NMAP
ECHO Could not find ..\build_envision\esplitter\esplitter.eifp !!

:NMAP
IF EXIST ..\build_envision\nmap\nmap.eifp COPY /Y ..\build_envision\nmap\nmap.eifp nmap.eifp
IF EXIST ..\build_envision\nmap\nmap.eifp GOTO SOLUTION
ECHO Could not find ..\build_envision\nmap\nmap.eifp !!

:SOLUTION
IF EXIST ..\build_envision\codedom_provider.sln COPY /Y ..\build_envision\codedom_provider.sln codedom_provider.sln
IF EXIST ..\build_envision\codedom_provider.sln GOTO END
ECHO Could not find ..\build_envision\codedom_provider.sln !!

:END
ECHO Done copying Eiffel CodeDom Provider Eiffel ENViSioN! project settings.
