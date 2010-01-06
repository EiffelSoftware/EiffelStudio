class TEST
create
	make
feature
	make is
		local
			s: A [STRING]
			t: A [TEST]
			l_int: INTERNAL
			l_type: INTEGER
		do
			create s
			create t
			io.put_string (s.generating_type) -- A [STRING_8]
			io.put_new_line
			io.put_string (t.generating_type) -- A [TEST]
			io.put_new_line
			io.put_boolean (s.f (s) = Void) -- False
			io.put_new_line
			io.put_boolean (s.f (t) = Void) -- True
			io.put_new_line
			io.put_boolean (t.f (t) = Void) -- False
			io.put_new_line
			io.put_boolean (t.f (s) = Void) -- True
			io.put_new_line

			create l_int
			l_type := l_int.dynamic_type (s)
			io.put_string (l_int.type_name_of_type (l_int.field_static_type_of_type (1, l_type))) -- STRING_8
			io.put_new_line
			l_type := l_int.dynamic_type (t)
			io.put_string (l_int.type_name_of_type (l_int.field_static_type_of_type (1, l_type))) -- TEST
			io.put_new_line
		end
 end

