if exist D:\%2\%1\%3\eifgen\w_code\%1.exe (
	rd /q /s D:\%2\%1
) else (
 	if exist D:\%2\%1\%3\eifgen\w_code\msc\driver.exe (
		rd /q /s D:\%2\%1
	) else (
 		if exist D:\%2\%1\%3\eifgen\w_code\%1.dll (
			rd /q /s D:\%2\%1
 		) else (
 			if exist D:\%2\%1\%3\eifgen\w_code (
				cd D:\%2\%1\%3\eifgen\w_code
				if exist Makefile nmake
				cd D:\com_wizard_cmd
 			)
 			call test_status2.bat %1 %2 %3
 		)
 	)
)