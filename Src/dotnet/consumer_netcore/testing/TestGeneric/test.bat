setlocal

set test_name=TestGeneric

if "%1" EQU "-dist" GOTO dist
GOTO dev
:after_dev
:after_dist

goto main

:dist
set ISE_EMDC=%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\netcore\nemdc.exe
set TMP_SUFFIX=_dist
shift
goto after_dist

:dev
set TMP_SUFFIX=
set NEMDC_PUB=%cd%\..\..\pub\win64
set ISE_EMDC=%NEMDC_PUB%\nemdc.exe
shift

set CWD=%cd%
cd ..\..
geant publish
cd %CWD%

goto after_dev

:main


echo ISE_EMDC=%ISE_EMDC%
rd /q/s "%~dp0_MD%TMP_SUFFIX%"

%ISE_EMDC% -nologo ^
		-a "_BIN\%test_name%.dll" ^
		-a "c:\work\eiffel\version\current\studio\spec\win64\lib\netcore\eiffelsoftware.runtime.dll" ^
		-a "C:\Program Files\dotnet\packs\microsoft.netcore.app.ref\6.0.25\ref\net6.0\System.Runtime.dll" ^
		-i "c:\program files\dotnet\packs\microsoft.netcore.app.ref\6.0.25\ref\net6.0\system.dll" ^
 	   	-runtime "C:\Program Files\dotnet\packs\microsoft.netcore.app.ref\6.0.25\ref\net6.0" ^
 	   	-sdk "C:\Program Files\dotnet\sdk\7.0.401" ^
		-o "%~dp0_MD%TMP_SUFFIX%" ^
		-v ^
		-debug ^
		-debug ^
		-clean ^
 	   	-json

call md_cache_browser --assembly %test_name% _MD%TMP_SUFFIX% > %test_name%%TMP_SUFFIX%.txt
call md_cache_browser _MD%TMP_SUFFIX% > %test_name%_all%TMP_SUFFIX%.txt

:EOF
endlocal
