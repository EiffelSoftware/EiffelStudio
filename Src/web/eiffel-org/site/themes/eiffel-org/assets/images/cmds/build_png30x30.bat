@echo off
setlocal

set SVG2PNG=C:\apps\graphical\Inkscape\inkscape.exe --export-height=30 
set TMP_OUTPUT=..
IF NOT EXIST %TMP_OUTPUT% mkdir %TMP_OUTPUT%

for %%f in (%1\*.svg) do %SVG2PNG% --export-png=%TMP_OUTPUT%\%%~nf_30x30.png %%f

endlocal
