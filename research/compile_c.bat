@echo off

set "EIFFEL_SRC=%~dp0..\Src"

cd "%EIFFEL_SRC%\C_library\libpng"                              && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\C_library\zlib"                                && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\Eiffel\eiffel\com_il_generation\Core\run-time" && nmake
rem cd "%EIFFEL_SRC%\framework\auto_test\Clib"                      && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\framework\cli_debugger\Clib"                   && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\framework\cli_writer\Clib"                     && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\library\cURL\Clib"                             && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
rem cd "%EIFFEL_SRC%\library\mysql\Clib"                            && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\library\net\Clib"                              && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
rem cd "%EIFFEL_SRC%\library\store\dbms\rdbms\mysql\Clib"           && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\library\vision2\Clib"                          && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\library\web_browser\Clib"                      && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"
cd "%EIFFEL_SRC%\library\wel\clib"                              && call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\compile_library"

cd "%~dp0"