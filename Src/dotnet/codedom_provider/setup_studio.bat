@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF EXIST build_studio RD /Q /S build_studio

IF %1 == "release" GOTO RELEASE

:DEBUG
MKDIR build_studio_debug
MKDIR build_studio_debug\EiffelSoftware.EiffelBase
MKDIR build_studio_debug\EiffelSoftware.EiffelVision2
MKDIR build_studio_debug\EiffelSoftware.CacheBrowser
MKDIR build_studio_debug\EiffelSoftware.CodeDom
MKDIR build_studio_debug\ecd_manager

COPY configuration\base.debug.ace build_studio_debug\EiffelSoftware.EiffelBase\ace.ace
COPY configuration\vision2.debug.ace build_studio_debug\EiffelSoftware.EiffelVision2\ace.ace
COPY configuration\cache_browser.debug.ace build_studio_debug\EiffelSoftware.CacheBrowser\ace.ace
COPY configuration\codedom_provider.debug.ace build_studio_debug\EiffelSoftware.CodeDom\ace.ace
COPY configuration\manager.debug.ace build_studio_debug\ecd_manager\ace.ace
GOTO END

:RELEASE
MKDIR build_studio
MKDIR build_studio\EiffelSoftware.EiffelBase
MKDIR build_studio\EiffelSoftware.EiffelVision2
MKDIR build_studio\EiffelSoftware.CacheBrowser
MKDIR build_studio\EiffelSoftware.CodeDom
MKDIR build_studio\ecd_manager

COPY configuration\base.ace build_studio\EiffelSoftware.EiffelBase\ace.ace
COPY configuration\vision2.ace build_studio\EiffelSoftware.EiffelVision2\ace.ace
COPY configuration\cache_browser.ace build_studio\EiffelSoftware.CacheBrowser\ace.ace
COPY configuration\codedom_provider.ace build_studio\EiffelSoftware.CodeDom\ace.ace
COPY configuration\manager.ace build_studio\ecd_manager\ace.ace

:END
ECHO Done setting up EiffelStudio Eiffel CodeDom Provider projects.
