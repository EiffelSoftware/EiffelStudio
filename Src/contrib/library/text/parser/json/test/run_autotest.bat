@echo off
setlocal
set TMP_EC_SCRIPT_FILENAME=%~dp0.tmp_ec_scripting

cd %~dp0autotest\test_suite
set TMP_EC_CMD=ec -config test_suite-safe.ecf -target test_suite -batch 

echo # Fresh Compilation
%TMP_EC_CMD% -batch -clean -freeze -c_compile -project_path . > %~dp0autotest.compile.log 2>&1

rem Build scripting for freeze + testing
rem ------------------------------------
rem Testing
echo T > %TMP_EC_SCRIPT_FILENAME%		
rem Execute
echo e >> %TMP_EC_SCRIPT_FILENAME%		
rem Quit
echo Q >> %TMP_EC_SCRIPT_FILENAME%		

echo # Execute test_suite
type %TMP_EC_SCRIPT_FILENAME% | %TMP_EC_CMD% -loop 1> :NULL 2> %~dp0autotest.testing.log
type %~dp0autotest.testing.log

cd %~dp0

del %TMP_EC_SCRIPT_FILENAME%
endlocal
