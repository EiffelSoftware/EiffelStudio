if exist generated rd /q /s generated

mkdir generated

%ISE_EIFFEL%\wizards\com\com_wizard.exe --client %EIFFEL_SRC%\com_compiler\idl\EiffelSoftwareCompiler.idl --destination %EIFFEL_SRC%\com_compiler\Client_Only\generated --outofprocess