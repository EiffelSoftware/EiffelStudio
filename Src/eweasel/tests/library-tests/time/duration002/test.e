class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			d1, d2: DATE
			dd: DATE_DURATION
			retried: BOOLEAN
		do
			if not retried then
				create d1.make (2001, 1, 15)
				d2 := clone (d1)
			end
			from
			until
				d2.year = d1.year + 10
			loop
				Io.put_string (d2.out + "... ")
				dd := d2.relative_duration (d1)
				Io.put_string ("OK%N")
				d2.day_forth
			end
		rescue
			Io.put_string ("FAILED%N")
			d2.day_forth
			retried := True
			retry
		end

end -- class TEST
