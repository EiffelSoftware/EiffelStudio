setlocal
set CWD=%cd%
cd ..\..\library

%ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\espawn.exe "%ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\wrap_c.exe --verbose --script_pre_process=%cd%\pre_script.bat --script_post_process=%cd%\post_script.bat --output-dir=%cd%\generated_wrapper  --full-header=%cd%\manual_wrapper\c\include\simple_header.h  --config=config.xml

cd %CWD%

exit /b 0
