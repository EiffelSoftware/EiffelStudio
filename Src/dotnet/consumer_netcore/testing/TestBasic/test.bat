set NEMDC_PUB=..\..\pub\win64
set NEMDC_CMD=%NEMDC_PUB%\nemdc.exe


%NEMDC_CMD% -nologo ^
		-a "_BIN\TestBasic.dll" ^
		-i "c:\program files\dotnet\packs\microsoft.netcore.app.ref\6.0.24\ref\net6.0\system.dll" ^
 	   	-runtime "C:\Program Files\dotnet\packs\microsoft.netcore.app.ref\6.0.24\ref\net6.0" ^
 	   	-sdk "C:\Program Files\dotnet\sdk\7.0.401" ^
		-o "%~dp0_MD" ^
		-v -clean -debug  -json

md_cache_browser --assembly TestBasic _MD > TestBasic.txt
