@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF EXIST build_studio RD /Q /S build_studio

MKDIR build_studio
MKDIR build_studio\EiffelSoftware.EiffelBase
MKDIR build_studio\EiffelSoftware.EiffelVision2
MKDIR build_studio\EiffelSoftware.CacheBrowser
MKDIR build_studio\EiffelSoftware.CodeDom

COPY configuration\base.ace build_studio\EiffelSoftware.EiffelBase\ace.ace
COPY configuration\vision2.ace build_studio\EiffelSoftware.EiffelVision2\ace.ace
COPY configuration\cache_browser.ace build_studio\EiffelSoftware.CacheBrowser\ace.ace
COPY configuration\codedom_provider.ace build_studio\EiffelSoftware.CodeDom\ace.ace

ECHO Done setting up EiffelStudio Eiffel CodeDom Provider projects.