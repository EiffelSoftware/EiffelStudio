@echo off

rem This script can be used to run a make utility on Windows using WSL (if installed)
rem when nmake (or sed) is not available.

set ISE_WIN_CR=\r
set WSLENV=ISE_LIBRARY/p:ISE_WIN_CR
bash -c "make update"