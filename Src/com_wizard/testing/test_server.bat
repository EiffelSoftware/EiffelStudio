rem --------------------------------- %1

if exist D:\testing_server\%1_finished del D:\testing_server\%1_finished

if exist D:\testing_server\%1_failed del D:\testing_server\%1_failed

if exist D:\testing_server\%1 rd /q /s D:\testing_server\%1

mkdir D:\testing_server\%1

c:\com_wizard_cmd\EIFGEN\W_code\com_wizard_cmd.exe -new_com_project -com_file %2 -destination D:\testing_server\%1 -server -automation -compile_c -compile_eiffel -stop_on_error -output_none -not_spawn_ebench

call test_status.bat %1 testing_server server


