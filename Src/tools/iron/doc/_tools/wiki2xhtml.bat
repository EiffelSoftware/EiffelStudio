@echo off
setlocal

if "%WIKI2XHTML_PATH%" == "" goto LOCAL_WIKI2XHTML
goto start

:LOCAL_WIKI2XHTML
if exist "%~dp0wiki2xhtml.exe" set WIKI2XHTML_PATH=%~dp0

if "%WIKI2XHTML_PATH%" == "" goto SEARCH_WIKI2XHTML
goto START

:SEARCH_WIKI2XHTML
for %%f in (wiki2xhtml.exe) do (
    if exist "%%~dp$PATH:f" set WIKI2XHTML_PATH="%%~dp$PATH:f"
 )
if "%WIKI2XHTML_PATH%" == "" goto BUILD_WIKI2XHTML
echo Using wiki2xhtml.exe from %WIKI2XHTML_PATH%
goto START

:BUILD_WIKI2XHTML
set TMP_SVN_CHECKOUT=%~dp0.tmp_wiki2xhtml
call svn checkout https://svn.eiffel.com/eiffelstudio/trunk/Src/contrib/library/text/parser/wikitext %TMP_SVN_CHECKOUT%
call ecb -config %~dp0.tmp_wiki2xhtml\apps\wiki2xhtml\wiki2xhtml-safe.ecf -finalize -c_compile -project_path %TMP_SVN_CHECKOUT%
copy %TMP_SVN_CHECKOUT%\EIFGENs\wiki2xhtml\F_code\wiki2xhtml.exe %~dp0wiki2xhtml.exe
rd /q/s %TMP_SVN_CHECKOUT%

set WIKI2XHTML_PATH=%~dp0
goto START

:START
rem echo Calling %WIKI2XHTML_PATH%wiki2xhtml.exe %*
call %WIKI2XHTML_PATH%wiki2xhtml.exe %*
goto END

:END
endlocal
