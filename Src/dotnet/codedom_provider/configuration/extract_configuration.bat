@REM Use this script to extract the configuration files from the current build
@REM and replace the content of the configuration folder with them.

copy /Y ..\build\ISE.Base\ISE.Base.eifp base.eifp

copy /Y ..\build\ISE.CacheBrowser\ISE.CacheBrowser.eifp cache_browser.eifp

copy /Y ..\build\ISE.EiffelCodeDomProvider\ISE.EiffelCodeDomProvider.eifp codedom_provider.eifp

copy /Y ..\build\codedom_provider.sln codedom_provider.sln
