@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF EXIST build_studio RD /Q /S build_studio

IF "%1"=="/release" GOTO RELEASE

:DEBUG
MKDIR build_studio_debug
MKDIR build_studio_debug\EiffelSoftware.CodeDomBase
MKDIR build_studio_debug\EiffelSoftware.CodeDomVision2
MKDIR build_studio_debug\EiffelSoftware.CacheBrowser
MKDIR build_studio_debug\EiffelSoftware.CodeDom
MKDIR build_studio_debug\ecdpman

COPY configuration\base.debug.ace build_studio_debug\EiffelSoftware.CodeDomBase\ace.ace
COPY configuration\vision2.debug.ace build_studio_debug\EiffelSoftware.CodeDomVision2\ace.ace
COPY configuration\cache_browser.debug.ace build_studio_debug\EiffelSoftware.CacheBrowser\ace.ace
COPY configuration\codedom_provider.debug.ace build_studio_debug\EiffelSoftware.CodeDom\ace.ace
COPY configuration\manager.debug.ace build_studio_debug\ecdpman\ace.ace
GOTO END

:RELEASE
MKDIR build_studio
MKDIR build_studio\EiffelSoftware.CodeDomBase
MKDIR build_studio\EiffelSoftware.CodeDomVision2
MKDIR build_studio\EiffelSoftware.CacheBrowser
MKDIR build_studio\EiffelSoftware.CodeDom
MKDIR build_studio\ecdpman

COPY configuration\base.ace build_studio\EiffelSoftware.CodeDomBase\ace.ace
COPY configuration\vision2.ace build_studio\EiffelSoftware.CodeDomVision2\ace.ace
COPY configuration\cache_browser.ace build_studio\EiffelSoftware.CacheBrowser\ace.ace
COPY configuration\codedom_provider.ace build_studio\EiffelSoftware.CodeDom\ace.ace
COPY configuration\manager.ace build_studio\ecdpman\ace.ace

:END
ECHO Done setting up EiffelStudio Eiffel CodeDom Provider projects.
