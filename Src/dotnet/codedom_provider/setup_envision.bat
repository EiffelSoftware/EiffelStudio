@ECHO OFF

@REM Setup Eiffel CodeDom Provider Eiffel ENViSioN! projects

IF EXIST build_envision RD /Q /S build_envision

MKDIR build_envision
MKDIR build_envision\EiffelSoftware.CodeDom.Base
MKDIR build_envision\EiffelSoftware.CodeDom.Vision2
MKDIR build_envision\EiffelSoftware.CodeDom.CacheBrowser
MKDIR build_envision\EiffelSoftware.CodeDom
MKDIR build_envision\EiffelSoftware.CodeDom.Splitter
MKDIR build_envision\ecdpman
MKDIR build_envision\esplitter
MKDIR build_envision\esplit
MKDIR build_envision\nmap

COPY configuration\base.eifp build_envision\EiffelSoftware.CodeDom.Base\EiffelSoftware.CodeDom.Base.eifp
COPY configuration\vision2.eifp build_envision\EiffelSoftware.CodeDom.Vision2\EiffelSoftware.CodeDom.Vision2.eifp
COPY configuration\cache_browser.eifp build_envision\EiffelSoftware.CodeDom.CacheBrowser\EiffelSoftware.CodeDom.CacheBrowser.eifp
COPY configuration\codedom_provider.eifp build_envision\EiffelSoftware.CodeDom\EiffelSoftware.CodeDom.eifp
COPY configuration\codedom_provider.eifp build_envision\EiffelSoftware.CodeDom.Splitter\EiffelSoftware.CodeDom.Splitter.eifp
COPY configuration\ecdpman.eifp build_envision\ecdpman\ecdpman.eifp
COPY configuration\esplitter.eifp build_envision\esplitter\esplitter.eifp
COPY configuration\esplit.eifp build_envision\esplit\esplit.eifp
COPY configuration\nmap.eifp build_envision\nmap\nmap.eifp

COPY configuration\codedom_provider.sln build_envision\

ECHO Done setting up Eiffel ENViSioN! Eiffel CodeDom Provider projects.
