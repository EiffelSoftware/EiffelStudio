@REM Use this script to extract the ace files from the current build
@REM and replace the content of the configuration folder with them.

@ECHO OFF

IF EXIST ..\build_studio\EiffelSoftware.EiffelBase\ace.ace COPY /Y ..\build_studio\EiffelSoftware.EiffelBase\ace.ace base.ace
IF EXIST ..\build_studio\EiffelSoftware.EiffelBase\ace.ace GOTO VISION2
ECHO Could not find ..\build_studio\EiffelSoftware.EiffelBase\ace.ace !!

:VISION2
IF EXIST ..\build_studio\EiffelSoftware.EiffelVision2\ace.ace COPY /Y ..\build_studio\EiffelSoftware.EiffelVision2\ace.ace vision2.ace
IF EXIST ..\build_studio\EiffelSoftware.EiffelVision2\ace.ace GOTO CACHE
ECHO Could not find ..\build_studio\EiffelSoftware.EiffelVision2\ace.ace !!

:CACHE
IF EXIST ..\build_studio\EiffelSoftware.CacheBrowser\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CacheBrowser\ace.ace cache_browser.ace
IF EXIST ..\build_studio\EiffelSoftware.CacheBrowser\ace.ace GOTO PROVIDER
ECHO Could not find ..\build_studio\EiffelSoftware.CacheBrowser\ace.ace !!

:PROVIDER
IF EXIST ..\build_studio\EiffelSoftware.CodeDom\ace.ace COPY /Y ..\build_studio\EiffelSoftware.CodeDom\ace.ace codedom_provider.ace
IF EXIST ..\build_studio\EiffelSoftware.CodeDom\ace.ace GOTO END
ECHO Could not find ..\build_studio\EiffelSoftware.CodeDom\ace.ace !!

:MANAGER
IF EXIST ..\build_studio\ecd_manager\ace.ace COPY /Y ..\build_studio\ecd_manager\ace.ace manager.ace
IF EXIST ..\build_studio\ecd_manager\ace.ace GOTO END
ECHO Could not find ..\build_studio\ecd_manager\ace.ace !!

:END
ECHO Done copying Eiffel CodeDom Provider ace files.