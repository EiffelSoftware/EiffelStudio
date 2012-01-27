@echo off
rem Eiffel Software script utility to compile the C code of some Eiffel libraries.
rem It assumes a standard layout which is that you are in a Clib directory and that 
rem the C libraries will be created under ../spec/$ISE_C_COMPILER/$ISE_PLATFORM/lib

rem Store old value for ISE_C_COMPILER
set OLD_C_COMPILER=%ISE_C_COMPILER%

rem Parse command line argument values
IF "%~1" NEQ "" (
	set ISE_C_COMPILER=%~1
)

echo Compiling C code for %ISE_C_COMPILER%

rem Check environment
if not exist "%ISE_EIFFEL%\studio\config\%ISE_PLATFORM%\%ISE_C_COMPILER%\config.sh" (
	echo Missing config.sh file in "%ISE_EIFFEL%\studio\config\%ISE_PLATFORM%\%ISE_C_COMPILER%"
	goto error
)
if not exist "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\rt_converter.exe" (
	echo Missing converter tool "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\rt_converter.exe"
	goto error
)
if not exist "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed.exe" (
	echo Missing sed command "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed.exe"
	goto error
)
if not exist "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\etc" (
	echo Missing etc directory. Create etc in "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\"
	goto error
)
if not exist "Makefile-win.SH" (
	echo Missing Makefile-win.SH file in current directory
	goto error
)

rem Copy the platform/compiler configuration file
if not exist config.sh copy "%ISE_EIFFEL%\studio\config\%ISE_PLATFORM%\%ISE_C_COMPILER%\config.sh" config.sh
rem Generate the Makefile using the portable Makefile-win.SH
"%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\rt_converter.exe" Makefile-win.SH Makefile

rem The following lines although not intuitive simply extract the value of `make' in the 
rem above `config.sh' file and converts it into a Windows compliant path specification
rem using \ and not / if any. It also converts any $(X) into %X%.

rem Get the actual make name
echo echo $make > make_name.bat
"%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\rt_converter.exe" make_name.bat make_name.bat
rem Replace $(XX) into %X%
"%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed.exe" -e "s/\$(\([^)]*\))/%%\1%%/g" make_name.bat >> make_name.modif
del make_name.bat
rename make_name.modif make_name.bat

rem Generate the make2.bat file with the above name
echo @echo off > make2.bat 
call make_name.bat >> make2.bat
del make_name.bat
rem Replace all / by \
"%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed.exe" -e "s/\//\\\/g" make2.bat >> make2.bat.modif
del make2.bat
rename make2.bat.modif make2.bat

rem Now we can call our platform make utility.
call make2.bat

rem Delete files that were created in the process.
del make2.bat
del config.sh
del Makefile
goto end

:error
echo Exiting...

:end
set ISE_C_COMPILER=%OLD_C_COMPILER%
