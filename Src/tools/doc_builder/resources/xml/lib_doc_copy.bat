rem --------------------------------------------------------------------------------
rem Script copies library generated XML files to correct place in docs and removes |
rem  all unwanted generated files.						   |
rem --------------------------------------------------------------------------------

rem Script arguments:
rem 	1 - Source location
rem	2 - Target location

cd /D %1
del /S *.html
del /S *_links.xml
del /S *_short.xml
IF NOT EXIST %2 mkdir %2
xcopy /S /Y %1 %2