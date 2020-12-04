@echo off
%EIFFEL_SRC%/tools/po_generation_tool/EIFGENs/po_generation_tool/F_code/po_generation_tool -D %EIFFEL_SRC%/Eiffel %EIFFEL_SRC%/../research/extension/autoproof/Eiffel %EIFFEL_SRC%/framework %EIFFEL_SRC%/../research/extension/autoproof/framework %EIFFEL_SRC%/help/wizards %EIFFEL_SRC%/library/wizard -o %EIFFEL_SRC%/Delivery/studio/lang/po_files/estudio.pot
if ERRORLEVEL 1 then goto error

%EIFFEL_SRC%/Delivery/studio/lang/script/build_misc_entries.bat
if ERRORLEVEL 1 then goto error
goto :eof

:error
echo FAILED!
