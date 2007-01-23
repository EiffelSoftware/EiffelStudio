class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			l_date, l_date2: DATE_TIME
			l_duration: DATE_TIME_DURATION
		do
			create l_date.make (1500, 1, 1, 1, 1, 1)
			create l_date2.make (2010, 1, 1, 1, 1, 1)
			l_date2.time.set_fine_second (.5)

			l_duration := l_date2.duration
			l_duration.set_origin_date_time (l_date)
			print (l_duration.seconds_count)
			print ("%N")
			print (l_duration.fine_seconds_count)
			print ("%N")
		end

end
