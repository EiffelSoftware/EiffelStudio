@REM Use this script to extract the ace files from the current build
@REM and replace the content of the configuration folder with them.

@ECHO OFF

IF EXIST ..\build_studio\EiffelSoftware.CodeDom.Base\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CodeDom.Base\ace.ace base.ace
IF EXIST ..\build_studio\EiffelSoftware.CodeDom.Base\ace.ace GOTO VISION2
ECHO Could not find ..\build_studio\EiffelSoftware.CodeDom.Base\ace.ace !!

:VISION2
IF EXIST ..\build_studio\EiffelSoftware.CodeDom.Vision2\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CodeDom.Vision2\ace.ace vision2.ace
IF EXIST ..\build_studio\EiffelSoftware.CodeDom.Vision2\ace.ace GOTO CACHE
ECHO Could not find ..\build_studio\EiffelSoftware.CodeDom.Vision2\ace.ace !!

:CACHE
IF EXIST ..\build_studio\EiffelSoftware.CodeDom.CacheBrowser\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CodeDom.CacheBrowser\ace.ace cache_browser.ace
IF EXIST ..\build_studio\EiffelSoftware.CodeDom.CacheBrowser\ace.ace GOTO PROVIDER
ECHO Could not find ..\build_studio\EiffelSoftware.CodeDom.CacheBrowser\ace.ace !!

:PROVIDER
IF EXIST ..\build_studio\EiffelSoftware.CodeDom\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CodeDom\ace.ace codedom_provider.ace
IF EXIST ..\build_studio\EiffelSoftware.CodeDom\ace.ace GOTO END
ECHO Could not find ..\build_studio\EiffelSoftware.CodeDom\ace.ace !!

:MANAGER
IF EXIST ..\build_studio\ecdpman\ace.ace COPY /Y ..\build_studio\ecdpman\ace.ace manager.ace
IF EXIST ..\build_studio\ecdpman\ace.ace GOTO BASEDEBUG
ECHO Could not find ..\build_studio\ecdpman\ace.ace !!

:BASEDEBUG
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.Base\ace.ace COPY /Y ..\build_studio_debug\EiffelSoftware.CodeDom.Base\ace.ace base.debug.ace
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.Base\ace.ace GOTO VISION2DEBUG
ECHO Could not find ..\build_studio_debug\EiffelSoftware.CodeDom.Base\ace.ace !!

:VISION2DEBUG
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.Vision2\ace.ace COPY /Y ..\build_studio_debug\EiffelSoftware.CodeDom.Vision2\ace.ace vision2.debug.ace
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.Vision2\ace.ace GOTO CACHEDEBUG
ECHO Could not find ..\build_studio_debug\EiffelSoftware.CodeDom.Vision2\ace.ace !!

:CACHEDEBUG
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser\ace.ace COPY /Y ..\build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser\ace.ace cache_browser.debug.ace
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser\ace.ace GOTO PROVIDERDEBUG
ECHO Could not find ..\build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser\ace.ace !!

:PROVIDERDEBUG
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom\ace.ace COPY /Y ..\build_studio_debug\EiffelSoftware.CodeDom\ace.ace codedom_provider.debug.ace
IF EXIST ..\build_studio_debug\EiffelSoftware.CodeDom\ace.ace GOTO MANAGERDEBUG
ECHO Could not find ..\build_studio_debug\EiffelSoftware.CodeDom\ace.ace !!

:MANAGERDEBUG
IF EXIST ..\build_studio_debug\ecdpman\ace.ace COPY /Y ..\build_studio_debug\ecdpman\ace.ace manager.debug.ace
IF EXIST ..\build_studio_debug\ecdpman\ace.ace GOTO END
ECHO Could not find ..\build_studio_debug\ecdpman\ace.ace !!

:END
ECHO Done copying Eiffel CodeDom Provider ace files.