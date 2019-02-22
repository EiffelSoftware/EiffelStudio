echo off
setlocal

set t_output=%EIFFEL_SRC%\Eiffel\interface\new_graphical\shared\es_mini_icons.e
emcgen %EIFFEL_SRC%\Delivery\studio\bitmaps\png\mini_icons.ini -f %EIFFEL_SRC%\tools\eiffel_matrix_code_generator\frames\studio_dpi.e.frame --output_file %t_output%

sed -i -- 's/E:.eiffelstudio.trunk.Src/%%EIFFEL_SRC%%/g' %t_output%
head %t_output% | grep command_line

endlocal
