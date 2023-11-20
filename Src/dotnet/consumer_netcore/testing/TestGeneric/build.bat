setlocal

call clean.bat


REM dotnet build cs\TestGeneric.csproj --output BUILD 
dotnet publish cs\TestGeneric.csproj --output _BIN

endlocal
