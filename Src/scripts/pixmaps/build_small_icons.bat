echo off
setlocal

set t_output=%EIFFEL_SRC%\Eiffel\interface\new_graphical\shared\es_small_icons.e
emcgen %EIFFEL_SRC%\Delivery\studio\bitmaps\png\small_icons.ini -f %EIFFEL_SRC%\tools\eiffel_matrix_code_generator\frames\studio_dpi.e.frame --output_file %t_output%

rem Update output file with expected command line.
for /d %f in (%EIFFEL_SRC%) do set t_drive=%~df
sed -i -- 's/%t_drive%.eiffelstudio.trunk.Src/%%EIFFEL_SRC%%/g' %t_output%
head %t_output% | grep emcgen

endlocal
