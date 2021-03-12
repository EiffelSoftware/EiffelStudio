@echo off
echo -----------------------------------------------------------------
echo ----------------- Preparing Temporary directory -----------------
echo -----------------------------------------------------------------
pushd
mkdir %DELIVERY%\studio\wizards\%1\%2\spec
mkdir %DELIVERY%\studio\wizards\%1\%2\spec\%ISE_PLATFORM%
rd /Q /S %TEMP%\%3
mkdir %TEMP%\%3
echo -----------------------------------------------------------------
echo ----------------- Retrieving last sources -----------------------
echo -----------------------------------------------------------------
cd/d %EIFFEL_SRC%\help\wizards
call svn up
echo -----------------------------------------------------------------
echo ----------------- Compilation -----------------------------------
echo -----------------------------------------------------------------
cd/d %TEMP%\%3
copy/b %EIFFEL_SRC%\help\wizards\wizard.ico .
copy/b %EIFFEL_SRC%\help\wizards\wizard.rc .
%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec -finalize -config %EIFFEL_SRC%\help\wizards\%3.ecf -project_path %TEMP%\%3 -c_compile

::DISABLED as upx cause trouble with antivirus
::echo -----------------------------------------------------------------
::echo ------- Compress generated executable file ----------------------
::echo -----------------------------------------------------------------
::cd/d %TEMP%\%3\EIFGENs\wizard\F_code
::iff not defined WIN64 then
::	upx wizard.exe
::endiff

echo -----------------------------------------------------------------
echo ------- Copying generated executable file into Delivery ---------
echo -----------------------------------------------------------------
copy /b %TEMP%\%3\EIFGENs\wizard\F_code\wizard.exe %DELIVERY%\studio\wizards\%1\%2\spec\%ISE_PLATFORM%
cd %TEMP%
popd
echo -----------------------------------------------------------------
echo ------- Deleting temporary files --------------------------------
echo -----------------------------------------------------------------
rd /Q /S %TEMP%\%3
