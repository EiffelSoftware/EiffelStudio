echo off

cd spec\windows

call gacutil -silent -nologo -u AssemblyManagerInterface
call gacutil -silent -nologo -i AssemblyManagerInterface.dll
call regasm -silent -nologo AssemblyManagerInterface.dll

cd ..\..
