@echo off

REM Setup Eiffel CodeDom Provider Eiffel ENViSioN! projects

if exist build rd /q /s build

mkdir build
mkdir build\ISE.Base
mkdir build\ISE.Base\obj
mkdir build\ISE.Base\obj\Debug
mkdir build\ISE.Base\obj\Release
mkdir build\ISE.CacheBrowser
mkdir build\ISE.CacheBrowser\obj
mkdir build\ISE.CacheBrowser\obj\Debug
mkdir build\ISE.CacheBrowser\obj\Release
mkdir build\ISE.EiffelCodeDomProvider
mkdir build\ISE.EiffelCodeDomProvider\obj
mkdir build\ISE.EiffelCodeDomProvider\obj\Debug
mkdir build\ISE.EiffelCodeDomProvider\obj\Release

copy configuration\base.eifp build\ISE.Base\ISE.Base.eifp
copy configuration\base_debug.ace build\ISE.Base\obj\Debug\ace.ace
copy configuration\base_release.ace build\ISE.Base\obj\Release\ace.ace
copy configuration\cache_browser.eifp build\ISE.CacheBrowser\ISE.CacheBrowser.eifp
copy configuration\cache_browser_debug.ace build\ISE.CacheBrowser\obj\Debug\ace.ace
copy configuration\cache_browser_release.ace build\ISE.CacheBrowser\obj\Release\ace.ace
copy configuration\codedom_provider.eifp build\ISE.EiffelCodeDomProvider\ISE.EiffelCodeDomProvider.eifp
copy configuration\codedom_provider_debug.ace build\ISE.EiffelCodeDomProvider\obj\Debug\ace.ace
copy configuration\codedom_provider_release.ace build\ISE.EiffelCodeDomProvider\obj\Release\ace.ace

copy configuration\codedom_provider.sln build\

cd build

devenv /RootSuffix Exp codedom_provider.sln /build Debug

cd ..