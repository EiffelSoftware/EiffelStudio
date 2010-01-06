class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			d1, d2: DATE
			d, od: INTEGER
			dd: DATE_DURATION
		do
			from
				create d1.make (2001, 1, 15)
				create d2.make (1991, 1, 15)
				dd := d2.relative_duration (d1)
				d := dd.days_count
				od := d - 1
			until
				d2.year = d1.year + 10
			loop
				Io.put_string (d2.out + "... ")
				dd := d2.relative_duration (d1)
				d := dd.days_count
				if d = od + 1 then
					Io.put_string ("OK%N")
				else
					Io.put_string ("FAILED%N")
				end
				d2.day_forth
				od := d
			end
		end

end -- class TEST
