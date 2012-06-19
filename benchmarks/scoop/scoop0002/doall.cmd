@echo off
for /F %%i in (processors.txt) do (
	for /F %%j in (queries.txt) do (
		echo %%i %%j >> log.txt
		call launch %1 %%i %%j
	)
)
