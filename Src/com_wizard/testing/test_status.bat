if exist D:\%2\%1\%3\eifgen\w_code\%1.exe (
	echo "finished" >> D:\%2\%1_finished
	rd /q /s D:\%2\%1
) else (
 	if exist D:\%2\%1\%3\eifgen\w_code\msc\driver.exe (
		echo "finished" >> D:\%2\%1_finished
		rd /q /s D:\%2\%1
	) else (
 		if exist D:\%2\%1\%3\eifgen\w_code\%1.dll (
			echo "finished" >> D:\%2\%1_finished
			rd /q /s D:\%2\%1
 		) else (
 			echo "failed" >> D:\%2\%1_failed
 		)
 	)
)