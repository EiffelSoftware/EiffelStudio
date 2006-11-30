class TEST
create
	make
feature
	make is
		do
			test_hash_code
			test_justify
		end

feature {NONE}

	test_hash_code is
		local
			s: STRING
			hash_code: INTEGER
			c_string: C_STRING
		do
			s := "This is a test"
			hash_code := s.hash_code
			s.make (0)
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			s.make_empty
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			s.make_filled (' ', 0)
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			s.make_from_string ("")
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			create c_string.make ("")
			s.make_from_c (c_string.item)
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			create c_string.make ("")
			s.from_c (c_string.item)
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line

			s := "This is a test"
			hash_code := s.hash_code
			create c_string.make ("")
			s.from_c_substring (c_string.item, 1, 1)
			io.put_boolean (s.hash_code = hash_code)
			io.put_new_line
		end

	test_justify is
		local
			s: STRING
		do
			s := "123456"
			s.left_justify
			io.put_boolean (s.substring (1, 6).is_equal ("123456"))
			io.put_new_line
		end
	
end
