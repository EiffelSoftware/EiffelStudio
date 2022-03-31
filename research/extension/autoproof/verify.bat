@echo off

rem
rem A script to verify projects recursively reachable from the current directory.
rem
rem Every project should have a single target. Verification applies to the clusters of this target.
rem
rem Usage:
rem 	verify.bat
rem
rem Output: projects that fail to compile or verify are reported to the standard output.
rem         The compilation/verification errors are logged in the project directories.
rem
rem Note: the script recompiles projects from scratch and does not keep them.
rem       In particular, it removes `EIFGENs` from the current directory.
rem

setlocal enableextensions
setlocal enabledelayedexpansion

if not defined EC (
	echo Environment variable %%EC%% is not defined.
	echo It should point to EiffelStudio executable.
	exit /b 1
)

if not exist "%EC%" (
	echo Environment variable %%EC%% points to a non-existing path.
	echo It should point to EiffelStudio executable.
	exit /b 1
)

for /r %%# in (*.ecf) do (
	%EC% -batch -clean -verify collection:cluster -verify printtime:false -config %%# 2> %%~dpn#.log
	call set "ECF=%%#"
	if ERRORLEVEL 1 (
		call echo Verification failed: %%ECF:CD\=%%
	) else if ERRORLEVEL 0 (
		del %%~dpn#.log
	) else if ERRORLEVEL -1 (
		call echo Verification failed: %%ECF:CD\=%%
	)
	rd/s/q EIFGENs
)
