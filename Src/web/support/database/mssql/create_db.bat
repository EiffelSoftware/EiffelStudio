@ECHO Use example:create_db "<ServerName>" "<DatabaseName>" "schema"

@echo off
echo Value %1
echo Value %2
echo Value %3

echo "%~dp0"

sqlcmd -S %1 -E  -v database_name="%2" schema="%3" curr="%~dp0" -i create_db.sql

