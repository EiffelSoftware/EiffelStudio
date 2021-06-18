@echo off

set "TEMP_DATA=%TEMP%\unicode_symbols_data.txt"
set "TEMP_FILTER=%TEMP%\unicode_symbols_filter.txt"
set "TEMP_OUTPUT=%TEMP%\symbols_output.txt"

set "UNICODE_VERSION=13.0.0"

set "GROUP=symbol_group.txt"

set "OUTPUT=unicode_symbols.cfg"

	rem Select symbol categories to include in processing.
call grep -v -e ';L.;' -e ';M.;' -e ';Nd;' -e '002B;PLUS SIGN;' -e '003C;LESS-THAN SIGN;' -e '003D;EQUALS SIGN;' -e '003E;GREATER-THAN SIGN;' -e '005E;CIRCUMFLEX ACCENT;' -e '007C;VERTICAL LINE;' -e '007E;TILDE;' ucd/%UNICODE_VERSION%/UnicodeData.txt > "%TEMP_DATA%"

	rem Select math symbols.
call grep -e '; Math' ucd/%UNICODE_VERSION%/DerivedCoreProperties.txt > "%TEMP_FILTER%"

	rem Filter symbols.
call %ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\eiffel unicode_helper_generator.ecf -f "%TEMP_FILTER%" -g "%GROUP%" -u %UNICODE_VERSION% -i "%TEMP_DATA%" --nologo | ^
call sed 's/\(.*;[A-Z0-9]\)\([-A-Z0-9 ]*\);\(.*\)/\1\L\2\E;\3/' ^
> "%TEMP_OUTPUT%"

	rem Add Eiffel-specific shortcuts.
echo # Eiffel-specific symbols> "%OUTPUT%"
echo 2227;Conjunction;Eiffel>> "%OUTPUT%"
echo 2227 0020;and;Eiffel>> "%OUTPUT%"
echo 2227 2026 0020;and then;Eiffel>> "%OUTPUT%"
echo 2228;Disjunction;Eiffel>> "%OUTPUT%"
echo 2228 0020 0020;or_;Eiffel>> "%OUTPUT%"
echo 2228 2026 0020;or else;Eiffel>> "%OUTPUT%"
echo 21D2;Implication;Eiffel>> "%OUTPUT%"
echo 21D2 0020;implies;Eiffel>> "%OUTPUT%"
echo 2200;All;Eiffel>> "%OUTPUT%"
echo 2203;Exists;Eiffel>> "%OUTPUT%"
echo 2200 0020 00A6;across all;Eiffel>> "%OUTPUT%"
echo 2203 0020 00A6;across some;Eiffel>> "%OUTPUT%"
echo 27F3 0020 00A6 0020 27F2;across loop;Eiffel>> "%OUTPUT%"
echo 00A6;Such that;Eiffel>> "%OUTPUT%"
echo 00A6 0020;Bar;Eiffel>> "%OUTPUT%"
echo 27F3;Loop begin;Eiffel>> "%OUTPUT%"
echo 27F2;Loop end;Eiffel>> "%OUTPUT%"
echo 27E6;Agent begin;Eiffel>> "%OUTPUT%"
echo 27E7;Agent end;Eiffel>> "%OUTPUT%"
echo.>> "%OUTPUT%"
echo # Automatically generated Unicode %UNICODE_VERSION% symbols>> "%OUTPUT%"
type "%TEMP_OUTPUT%" >> "%OUTPUT%"

del "%TEMP_DATA%"
del "%TEMP_FILTER%"
del "%TEMP_OUTPUT%"
