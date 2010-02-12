class A

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
			i := 123123
			vol_s := "TEST"
			vol_as := s
			vol_i := 1
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
			io.put_string ("vol_as = ")
			if vol_as /= Void then
				io.put_string (vol_as)
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

	vol_s: STRING note option: transient attribute end
	vol_as: STRING note option: transient attribute end
	vol_i: INTEGER note option: transient attribute end

end
