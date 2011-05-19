setlocal
rem echo off

set DB_ADMIN_USER=root
set DB_ADMIN_PASS=

set DB_SERVER=localhost
set DB_USER=eweasel_user
set DB_PASS=123456
set DB_NAME=store_eweasel_test


set BIN_MYSQL="%MYSQL%\bin\mysql.exe"
set MYSQL_CMD=%BIN_MYSQL% -h %DB_SERVER% -u %DB_ADMIN_USER% -p%DB_ADMIN_PASS%

echo Dropping DATABASE %DB_NAME% if exists
echo DROP DATABASE %DB_NAME%; | %MYSQL_CMD%

echo Creating DATABASE %DB_NAME% 
echo CREATE DATABASE %DB_NAME%; | %MYSQL_CMD%

echo Dropping USER %DB_USER% if exists
echo DROP USER '%DB_USER%'@'localhost'; | %MYSQL_CMD%

echo Creating user %DB_USER%
echo CREATE USER '%DB_USER%'@'localhost' IDENTIFIED by '%DB_PASS%' | %MYSQL_CMD%

echo Granting privilege on DATABASE %DB_NAME% for user %DB_USER%
echo GRANT ALL PRIVILEGES ON %DB_NAME%.* TO '%DB_USER%'@localhost; | %MYSQL_CMD%

echo Loading sql schema/content into %DB_NAME%
%MYSQL_CMD% -D %DB_NAME% < %DB_SQL_FILENAME%

endlocal