@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

IF EXIST build_studio RD /Q /S build_studio

IF "%1"=="/release" GOTO RELEASE

:DEBUG
MKDIR build_studio_debug
MKDIR build_studio_debug\EiffelSoftware.CodeDom.Base
MKDIR build_studio_debug\EiffelSoftware.CodeDom.Vision2
MKDIR build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser
MKDIR build_studio_debug\EiffelSoftware.CodeDom
MKDIR build_studio_debug\EiffelSoftware.CodeDom.Splitter
MKDIR build_studio_debug\ecdpman
MKDIR build_studio_debug\esplitter
MKDIR build_studio_debug\esplit
MKDIR build_studio_debug\nmap

COPY configuration\base.debug.ace build_studio_debug\EiffelSoftware.CodeDom.Base\ace.ace
COPY configuration\vision2.debug.ace build_studio_debug\EiffelSoftware.CodeDom.Vision2\ace.ace
COPY configuration\cache_browser.debug.ace build_studio_debug\EiffelSoftware.CodeDom.CacheBrowser\ace.ace
COPY configuration\codedom_provider.debug.ace build_studio_debug\EiffelSoftware.CodeDom\ace.ace
COPY configuration\esplitter.common.debug.ace build_studio_debug\EiffelSoftware.CodeDom.Splitter\ace.ace
COPY configuration\manager.debug.ace build_studio_debug\ecdpman\ace.ace
COPY configuration\esplitter.gui.debug.ace build_studio_debug\esplitter\ace.ace
COPY configuration\esplitter.text.debug.ace build_studio_debug\esplit\ace.ace
COPY configuration\nmap.debug.ace build_studio_debug\nmap\ace.ace
GOTO END

:RELEASE
MKDIR build_studio
MKDIR build_studio\EiffelSoftware.CodeDom.Base
MKDIR build_studio\EiffelSoftware.CodeDom.Vision2
MKDIR build_studio\EiffelSoftware.CodeDom.CacheBrowser
MKDIR build_studio\EiffelSoftware.CodeDom
MKDIR build_studio\EiffelSoftware.CodeDom.Splitter
MKDIR build_studio\ecdpman
MKDIR build_studio\esplitter
MKDIR build_studio\esplit
MKDIR build_studio\nmap

COPY configuration\base.ace build_studio\EiffelSoftware.CodeDom.Base\ace.ace
COPY configuration\vision2.ace build_studio\EiffelSoftware.CodeDom.Vision2\ace.ace
COPY configuration\cache_browser.ace build_studio\EiffelSoftware.CodeDom.CacheBrowser\ace.ace
COPY configuration\codedom_provider.ace build_studio\EiffelSoftware.CodeDom\ace.ace
COPY configuration\esplitter.common.ace build_studio\EiffelSoftware.CodeDom.Splitter\ace.ace
COPY configuration\manager.ace build_studio\ecdpman\ace.ace
COPY configuration\esplitter.gui.ace build_studio\esplitter\ace.ace
COPY configuration\esplitter.text.ace build_studio\esplit\ace.ace
COPY configuration\nmap.ace build_studio\nmap\ace.ace

:END
ECHO Done setting up EiffelStudio Eiffel CodeDom Provider projects.
