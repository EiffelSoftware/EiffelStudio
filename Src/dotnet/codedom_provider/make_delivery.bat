@echo off

REM Setup Eiffel CodeDom Provider delivery, result is put in folder "delivery"
REM "make.bat" must be called first

if not exist build call make.bat

cd build

devenv /RootSuffix Exp codedom_provider.sln /build Release

cd ..

if exist delivery rd /q /s delivery
mkdir delivery
mkdir delivery\bin
mkdir delivery\system32

copy build\ISE.Base\bin\Release\ISE.Base.dll delivery\bin\
copy build\ISE.Base\bin\Release\libISE.Base.dll delivery\system32\
copy build\ISE.CacheBrowser\bin\Release\ISE.CacheBrowser.dll delivery\bin\
copy build\ISE.CacheBrowser\bin\Release\libISE.CacheBrowser.dll delivery\system32\
copy build\ISE.EiffelCodeDomProvider\bin\Release\ISE.EiffelCodeDomProvider.dll delivery\bin\
copy build\ISE.EiffelCodeDomProvider\bin\Release\libISE.EiffelCodeDomProvider.dll delivery\system32\