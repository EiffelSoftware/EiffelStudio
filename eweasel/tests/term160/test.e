class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
		local
			t1: TEST1 [TUPLE]
			t2: TEST1 [TUPLE [INTEGER]]
		do
			create t1.make
			create t2.make

			io.put_string (t1.generating_type)
			io.put_new_line
			io.put_string (t1.item.generating_type)
			io.put_new_line
			io.put_string (t1.list.generating_type)
			io.put_new_line

			io.put_string (t2.generating_type)
			io.put_new_line
			io.put_string (t2.item.generating_type)
			io.put_new_line
			io.put_string (t2.list.generating_type)
			io.put_new_line
		end

end
