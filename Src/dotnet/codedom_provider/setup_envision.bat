@ECHO OFF

@REM Setup Eiffel CodeDom Provider Eiffel ENViSioN! projects

IF EXIST build_envision RD /Q /S build_envision

MKDIR build_envision
MKDIR build_envision\EiffelSoftware.EiffelBase
MKDIR build_envision\EiffelSoftware.EiffelBase\obj
MKDIR build_envision\EiffelSoftware.EiffelBase\obj\Debug
MKDIR build_envision\EiffelSoftware.EiffelBase\obj\Release
MKDIR build_envision\EiffelSoftware.EiffelVision2
MKDIR build_envision\EiffelSoftware.EiffelVision2\obj
MKDIR build_envision\EiffelSoftware.EiffelVision2\obj\Debug
MKDIR build_envision\EiffelSoftware.EiffelVision2\obj\Release
MKDIR build_envision\EiffelSoftware.CacheBrowser
MKDIR build_envision\EiffelSoftware.CacheBrowser\obj
MKDIR build_envision\EiffelSoftware.CacheBrowser\obj\Debug
MKDIR build_envision\EiffelSoftware.CacheBrowser\obj\Release
MKDIR build_envision\EiffelSoftware.CodeDom
MKDIR build_envision\EiffelSoftware.CodeDom\obj
MKDIR build_envision\EiffelSoftware.CodeDom\obj\Debug
MKDIR build_envision\EiffelSoftware.CodeDom\obj\Release

COPY configuration\base.eifp build_envision\EiffelSoftware.EiffelBase\EiffelSoftware.EiffelBase.eifp
COPY configuration\vision2.eifp build_envision\EiffelSoftware.EiffelVision2\EiffelSoftware.EiffelVision2.eifp
COPY configuration\cache_browser.eifp build_envision\EiffelSoftware.CacheBrowser\EiffelSoftware.CacheBrowser.eifp
COPY configuration\codedom_provider.eifp build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp

COPY configuration\codedom_provider.sln build_envision\

ECHO Done setting up Eiffel ENViSioN! Eiffel CodeDom Provider projects.
