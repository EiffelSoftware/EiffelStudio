@echo off
setlocal

if "%1" EQU "src" (
	set PNG_DIR=%EIFFEL_SRC%\Delivery\studio\bitmaps\png
) else if "%1" EQU "wb" (
	set PNG_DIR=%ISE_EIFFEL%_workbench\studio\bitmaps\png
) else (
	set PNG_DIR=%ISE_EIFFEL%\studio\bitmaps\png
)

echo PNG_DIR=%PNG_DIR%

IF EXIST "icons\16x16.png" (
	copy icons\16x16.png %PNG_DIR%\16x16.png
) ELSE (
	copy icons\icons_16x16.png %PNG_DIR%\16x16.png
)
copy icons\icons_16x16.png %PNG_DIR%\icons_16x16.png
copy icons\icons_20x20.png %PNG_DIR%\icons_20x20.png
copy icons\icons_24x24.png %PNG_DIR%\icons_24x24.png
copy icons\icons_32x32.png %PNG_DIR%\icons_32x32.png

IF EXIST "small\12x12.png" (
	copy small\12x12.png %PNG_DIR%\12x12.png
) ELSE (
	copy small\small_12x12.png %PNG_DIR%\12x12.png
)
copy small\small_12x12.png %PNG_DIR%\small_12x12.png
copy small\small_15x15.png %PNG_DIR%\small_15x15.png
copy small\small_18x18.png %PNG_DIR%\small_18x18.png
copy small\small_24x24.png %PNG_DIR%\small_24x24.png

IF EXIST "mini\10x10.png" (
	copy mini\10x10.png %PNG_DIR%\10x10.png
) ELSE (
	copy mini\mini_10x10.png %PNG_DIR%\10x10.png
)
copy mini\mini_10x10.png %PNG_DIR%\mini_10x10.png
copy mini\mini_12x12.png %PNG_DIR%\mini_12x12.png
copy mini\mini_15x15.png %PNG_DIR%\mini_15x15.png
copy mini\mini_20x20.png %PNG_DIR%\mini_20x20.png
