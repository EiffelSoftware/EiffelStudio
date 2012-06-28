echo Compiling ejson_test  (finalized)
ecb -finalize -c_compile -config ejson_test.ecf -batch -clean > NUL 2>&1
IF %ERRORLEVEL% EQU -1 goto ERROR
copy EIFGENs\ejson_test\F_code\ejson_test.exe ejson_test.exe
goto EOF

:ERROR
echo Error occurred during ejson_test compilation
goto EOF

:EOF
