setlocal

mkdir %cd%\.comp
ecb -config %cd%\update_ecf\update_ecf.ecf -finalize -c_compile -project_path %cd%\.comp
move %cd%\.comp\EIFGENs\update_ecf\F_code\update_ecf.exe update_ecf.exe
rd /q/s %cd%\.comp\EIFGENs\update_ecf

ecb -config %cd%\update_iron\update_iron.ecf -finalize -c_compile -project_path %cd%\.comp
move %cd%\.comp\EIFGENs\update_iron\F_code\update_iron.exe update_iron.exe
rd /q/s %cd%\.comp\EIFGENs\update_iron


rd /q/s %cd%\.comp
move update_ecf.exe %ISE_EIFFEL%\tools\iron\spec\%ISE_PLATFORM%\bin\commands\update_ecf.exe
move update_iron.exe %ISE_EIFFEL%\tools\iron\spec\%ISE_PLATFORM%\bin\commands\update_iron.exe

endlocal
exit /B 0
