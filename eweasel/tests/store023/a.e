class A

create
	make

feature {NONE} -- Creation

	make
		do
			vol_s := "TEST"
			vol_i := 1
			s := "NON_VOLATILE"
			i := 123123
		end

feature -- Basic

	dump
		do
			io.put_string ("s = ")
			if s /= Void then
				io.put_string (s)
			else
				io.put_string ("Void")
			end
			io.put_new_line
			io.put_string ("vol_s = ")
			if vol_s /= Void then
				io.put_string (vol_s)
			else
				io.put_string ("Void")
			end
			io.put_new_line
			io.put_string ("i = ")
			io.put_integer (i)
			io.put_new_line
			io.put_string ("vol_i = ")
			io.put_integer (vol_i)
			io.put_new_line
		end

feature -- Access

	s: STRING
	i: INTEGER

	vol_s: STRING note option: volatile attribute end
	vol_i: INTEGER note option: volatile attribute end

end
