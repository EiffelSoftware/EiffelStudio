
set T_IRON_DIR=%1
set T_IRON_PORT=%2
set T_IRON_user=%3
set T_IRON_pass=%4
set T_IRON_option=%5

call iron_prepare.bat %T_IRON_DIR% %T_IRON_option%
call iron_init.bat %T_IRON_DIR% %T_IRON_PORT% %T_IRON_user% %T_IRON_pass%

