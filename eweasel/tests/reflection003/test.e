class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_int_value_type: INTEGER_32
			t: TYPE [detachable ANY]
		do
			l_int_value_type := dynamic_type_from_string ("INTEGER_32")
			t := type_of_type (l_int_value_type)
			io.put_string (t.out)
			io.put_new_line
			t := type_of ({INTEGER} 2)
			io.put_string (t.out)
			io.put_new_line
		end

end
