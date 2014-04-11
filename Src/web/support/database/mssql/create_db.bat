@ECHO Use example:create_db "<ServerName>" "<DatabaseName>" "schema"

@echo off
echo Value %1
echo Value %2
echo Value %3

echo "%~dp0"


odbcconf.exe /a {CONFIGDSN "SQL Server" "DSN=%2|Description=Eiffel test DSN|SERVER=JVELILLA\SQLEXPRESS|Trusted_Connection=Yes|Database=%2"}
sqlcmd -S %1 -E  -v database_name="%2" schema="%3" curr="%~dp0" -i create_db.sql

