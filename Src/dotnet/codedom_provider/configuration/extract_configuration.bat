@REM Use this script to extract the configuration files from the current build
@REM and replace the content of the configuration folder with them.

copy /Y ..\build\ISE.Base\obj\Debug\ace.ace base_debug.ace
copy /Y ..\build\ISE.Base\obj\Release\ace.ace base_release.ace
copy /Y ..\build\ISE.Base\ISE.Base.eifp base.eifp

copy /Y ..\build\ISE.CacheBrowser\obj\Debug\ace.ace cache_browser_debug.ace
copy /Y ..\build\ISE.CacheBrowser\obj\Release\ace.ace cache_browser_release.ace
copy /Y ..\build\ISE.CacheBrowser\ISE.CacheBrowser.eifp cache_browser.eifp

copy /Y ..\build\ISE.EiffelCodeDomProvider\obj\Debug\ace.ace codedom_provider_debug.ace
copy /Y ..\build\ISE.EiffelCodeDomProvider\obj\Release\ace.ace codedom_provider_release.ace
copy /Y ..\build\ISE.EiffelCodeDomProvider\ISE.EiffelCodeDomProvider.eifp codedom_provider.eifp

copy /Y ..\build\codedom_provider.sln codedom_provider.sln
