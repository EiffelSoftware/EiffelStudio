class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			date: DATE_TIME
			d1, d2: DATE_TIME
			d: DATE_TIME_DURATION
			t: TIME
			date_duration: DATE_DURATION
			time: TIME_DURATION
			date_time_duration: DATE_TIME_DURATION
		do
			create date_duration.make_by_days (10)
			create time.make_by_fine_seconds (1000)
			create date_time_duration.make_by_date_time (date_duration, time)
			date_time_duration := - date_time_duration

			create d1.make_fine (2005, 6, 29, 23, 59, 59.6)
			create d2.make_fine (2005, 6, 30, 12, 3, 25.4)
			d := d2.relative_duration (d1)

			create date.make (2005, 6, 29, 9, 3, 0)
			print (date.formatted_out ("hh12:mi AM") + "%N")
			print (date.formatted_out ("AM hh12:mi") + "%N")
			print (date.formatted_out ("PM hh12:mi") + "%N")
			print (date.formatted_out ("hh12:mi PM") + "%N")
			print (date.formatted_out ("hh12:mi PM ss") + "%N")
			print (date.formatted_out ("hh12 PM:mi ss") + "%N")
			print (date.formatted_out ("hh12") + "%N")
			print (date.formatted_out ("[0]hh12") + "%N")
			
			create t.make_now
			print (t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss PM"))
			print ("%N")
			print (t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss"))
			print ("%N")
			print (t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss"))
			print ("%N")
			print (t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss PM"))
			print ("%N")
			
			create d1.make_now
			print (d1.date_time_valid ("1/1/0000 3:30:00 PM", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
			print ("%N")
			print (d1.date_time_valid ("1/1/0000 3:30:00", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
			print ("%N")
		end

end -- class TEST
