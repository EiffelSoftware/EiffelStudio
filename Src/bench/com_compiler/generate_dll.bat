if exist generated rd /q /s generated

mkdir generated

%ISE_EIFFEL%\wizards\com\com_wizard_cmd.exe -new_com_project -com_file %EIFFEL_SRC%\com_compiler\idl\EiffelSoftwareCompiler.idl -destination %EIFFEL_SRC%\com_compiler\generated -server -in_process -output_all -not_spawn_ebench -proxy_stub "%EIFFEL_SRC%\com_compiler\idl\EiffelSoftware.CompilerPS.dll"
