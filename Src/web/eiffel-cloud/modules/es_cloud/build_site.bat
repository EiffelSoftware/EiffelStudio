setlocal
set CWD=%cd%

echo [es_cloud] Build css files from scss 
cd %~dp0site\files
::sass --scss --sourcemap=none -t expanded scss/es_cloud-admin.scss:css/es_cloud-admin.css
call:scss2css es_cloud
call:scss2css es_cloud-admin
call:scss2css es_forms
call:scss2css pricing

cd %CWD%
goto:eof

:scss2css
	::sass --scss --sourcemap=none -t expanded scss\%~1.scss:css\%~1.css
	sass --no-source-map --style=expanded scss\%~1.scss:css\%~1.css
goto:eof
endlocal
