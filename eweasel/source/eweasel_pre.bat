@echo off

rem Update ew_eweasel.e to list the latest revision of eweasel.

del/q ew_eweasel.new

setlocal enabledelayedexpansion

rem Convert all version numbers to the same lenght by adding leading spaces.
	(for /f "tokens=4" %%v in ('svn info --depth infinity ^| findstr /C:"Last Changed Rev:"') do (
		set rev=0000000000%%v
		set rev=!rev:~-10!
		echo !rev!
	)) > eweasel_pre.tmp

rem Sort revision numbers.
	for /f %%v in ('sort eweasel_pre.tmp') do (
		set rev=%%v
	)

rem Remove temporary file.
	del eweasel_pre.tmp

rem Remove leading zeroes.
	for /f "tokens=* delims=0" %%n in ("!rev!") do set "new_rev=%%n"

rem Replace current revision number with the computed one.
	%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed -b "s/revision := ""\$Revision.*\$""/revision := ""\$Revision: %new_rev% \$""/" < ew_eweasel.e > ew_eweasel.new

rem Update Eiffel source file with the new one.
	if exist ew_eweasel.new move/y ew_eweasel.new ew_eweasel.e