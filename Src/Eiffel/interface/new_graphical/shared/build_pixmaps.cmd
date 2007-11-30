set FRAMEFILE="%EIFFEL_SRC%\tools\eiffel_matrix_code_generator\frames\studio.e.frame"
set INIDIR="%EIFFEL_SRC%\Delivery\studio\bitmaps\png"
emcgen -frame "%FRAMEFILE%" "%INIDIR%\10x10.ini"
emcgen -frame "%FRAMEFILE%" "%INIDIR%\12x12.ini
emcgen -frame "%FRAMEFILE%" "%INIDIR%\16x16.ini
emcgen -frame "%FRAMEFILE%" "%INIDIR%\cursors.ini