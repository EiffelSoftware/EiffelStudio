if exist D:\%2\%1\%3\eifgen\w_code\%1.exe (
	rd /q /s D:\%2\%1
) else (
 	if exist D:\%2\%1\%3\eifgen\w_code\msc\driver.exe (
		rd /q /s D:\%2\%1
	) else (
 		if exist D:\%2\%1\%3\eifgen\w_code\%1.dll (
			rd /q /s D:\%2\%1
 		) else (
 			echo "failed" >> D:\%2\%1_failed
 		)
 	)
)