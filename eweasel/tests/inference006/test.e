class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i
			t
			s
		do
			from
				i := 500
				t := [i]
				s := [i]
			until
				i <= 0
			loop
				t := [t, i]
				s := [i, s]
				i := i - 1
			end
			io.put_string (t.generating_type)
			io.put_new_line
			io.put_string (s.generating_type)
			io.put_new_line
		end

end
