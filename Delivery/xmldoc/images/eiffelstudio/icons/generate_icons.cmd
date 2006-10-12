del /q 10x10\*
del /q 12x12\*
del /q 16x16\*
del /q cursors\*
set PNGDIR="%EIFFEL_SRC%/Delivery/studio/bitmaps/png/"
emcgen -slice "%PNGDIR%/10x10.png" "%PNGDIR%/10x10.ini" -pngs 10x10
emcgen -slice "%PNGDIR%/12x12.png" "%PNGDIR%/12x12.ini" -pngs 12x12
emcgen -slice "%PNGDIR%/16x16.png" "%PNGDIR%/16x16.ini" -pngs 16x16
emcgen -slice "%PNGDIR%/cursors.png" "%PNGDIR%/cursors.ini" -pngs cursors