class TEST
create
	make
feature
	make is
		local
			s1: SPECIAL [TEST1]
			s2: SPECIAL [TEST2]
		do
			create s1.make (100)
			io.put_string (s1.item (10).generating_type)
			io.put_new_line
			io.put_string (s1.item (10).generator)
			io.put_new_line

			create s2.make (100)
			io.put_string (s2.item (10).generating_type)
			io.put_new_line
			io.put_string (s2.item (10).generator)
			io.put_new_line
			io.put_string (s2.item (10).name)
			io.put_new_line

			s2.item (10).set_name ("Manu")

			io.put_string (s2.item (10).name)
			io.put_new_line
		end
	
end
