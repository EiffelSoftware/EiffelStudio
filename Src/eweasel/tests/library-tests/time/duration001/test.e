class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			t1, t2: TIME
			td: TIME_DURATION
			retried: BOOLEAN
		do
			if not retried then
				create t1.make (0, 0, 0)
				create t2.make (0, 5, 0)
			end
			from
			until
				equal (t1, t2)
			loop
				Io.put_string (t2.out + "... ")
				td := t2.relative_duration (t1)
				Io.put_string ("OK%N")
				t2.minute_add (5)
			end
		rescue
			Io.put_string ("FAILED%N")
			t2.minute_add (5)
			retried := True
			retry
		end

end -- class TEST
