setlocal

call clean.bat


REM dotnet build cs\TestBasic.csproj --output BUILD 
dotnet publish cs\TestBasic.csproj --output _BIN

endlocal
