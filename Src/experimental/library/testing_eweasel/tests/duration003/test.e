class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			d1, d2: DATE_TIME
			s, os: INTEGER_64
			dd: DATE_TIME_DURATION
		do
			from
				create d1.make (2001, 1, 15, 0, 0, 0)
				create d2.make (2000, 6, 1, 0, 0, 0)
				dd := d2.relative_duration (d1)
				s := dd.seconds_count
				os := s - (8 * 3600)
			until
				d2.year = d1.year + 4 and d2.month = 6
			loop
				Io.put_string (d2.out + "... ")
				dd := d2.relative_duration (d1)
				s := dd.seconds_count
				if s = os + (8 * 3600) then
					Io.put_string ("OK%N")
				else
					Io.put_string ("FAILED%N")
				end
				d2.hour_add (8)
				os := s
			end
		end

end -- class TEST
