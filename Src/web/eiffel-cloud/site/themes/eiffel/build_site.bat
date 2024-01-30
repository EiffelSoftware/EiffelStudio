setlocal
set CWD=%cd%

echo [themes/eiffel] Build css files from scss 
cd %~dp0assets
::sass --scss --sourcemap=none -t expanded scss/es_cloud-admin.scss:css/es_cloud-admin.css
call:scss2css style

cd %CWD%
goto:eof

:scss2css
	::sass --scss --sourcemap=none -t expanded scss\%~1.scss:css\%~1.css
	sass --no-source-map --style=expanded scss\%~1.scss:css\%~1.css
goto:eof
endlocal
