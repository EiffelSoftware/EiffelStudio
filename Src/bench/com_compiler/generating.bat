if exist generated rd /q /s generated

mkdir generated

%ISE_EIFFEL%\wizards\com\com_wizard_cmd.exe -new_com_project -com_file %EIFFEL_SRC%\com_compiler\idl\Eif_compiler.idl -destination %EIFFEL_SRC%\com_compiler\generated -server -automation -output_all -not_spawn_ebench
