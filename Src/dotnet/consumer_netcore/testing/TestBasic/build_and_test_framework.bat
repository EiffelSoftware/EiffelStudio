call clean_framework.bat

REM dotnet build cs\TestBasicNetFramework.csproj --output _BIN.F
dotnet publish cs\TestBasicNetFramework.csproj --output _BIN.F

set NEMDC_CMD=emdc.exe

rd /q/s %~dp0_MD.F
mkdir %~dp0_MD.F
%NEMDC_CMD% -nologo ^
		-a "_BIN.F\TestBasicNetFramework.dll" ^
		-o "%~dp0_MD.F" ^
		-v -debug  -json

		REM -i "c:\program files\dotnet\packs\microsoft.netcore.app.ref\6.0.23\ref\net6.0\system.dll" ^
 	   	REM -runtime "C:\Program Files\dotnet\packs\microsoft.netcore.app.ref\6.0.23" ^
 	   	REM -sdk "C:\Program Files\dotnet\sdk\7.0.401" ^

md_cache_browser --assembly TestBasicNetFramework _MD.F\md\x64\v4.0.30319 > TestBasicNetFramework.txt
