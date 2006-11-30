class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			t1, t2: TIME
			s, os: INTEGER
			td: TIME_DURATION
		do
			from
				create t1.make (0, 0, 0)
				create t2.make (0, 5, 0)
			until
				equal (t1, t2)
			loop
				os := s
				Io.put_string (t2.out + "... ")
				td := t2.relative_duration (t1)
				s := td.seconds_count
				if s = os + (5 * 60) then
					Io.put_string ("OK%N")
				else
					Io.put_string ("FAILED%N")
				end
				t2.minute_add (5)
			end
		end

end -- class TEST
