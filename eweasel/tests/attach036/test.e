class
	TEST
 
create
	make
 
feature {NONE} -- Creation
 
	make is
			-- Run test.
		local
			s: SPECIAL [!ANY]
		do
			create s.make (5)
			test_item (s, 0, True)
			test_item (s, 1, True)
			test_item (s, 2, True)
			test_item (s, 3, True)
			test_item (s, 4, True)
			s.fill_with (Current, 0, 4)
			test_item (s, 0, False)
			test_item (s, 1, False)
			test_item (s, 2, False)
			test_item (s, 3, False)
			test_item (s, 4, False)
			s.put_default (1)
			s.put_default (3)
			test_item (s, 0, False)
			test_item (s, 1, True)
			test_item (s, 2, False)
			test_item (s, 3, True)
			test_item (s, 4, False)
		end

feature {NONE} -- Tests

	test_item (s: !SPECIAL [!ANY]; i: INTEGER; is_default: BOOLEAN)
			-- Check that `i'-th item of `s' is default iff `is_default = True'
		require
			valid_index: 0 <= i and i < s.count
		local
			state: NATURAL_8
			a: ANY
		do
			inspect state
			when 0 then
				io.put_string ("Item #")
				io.put_integer (i)
				io.put_string (": ")
				if s.is_default (i) = is_default then
					state := 1
					if s.item (i) = Void or else is_default then
						io.put_string ("`item' does not raise an exception for default value.")
					else
						io.put_string ("OK")
					end
				end
			when 1 then
				io.put_string ("`is_default' raises an exception.")
			when 2 then
				if is_default then
					io.put_string ("OK")
				else
					io.put_string ("`item' raises an exception for non-default value.")
				end
			end
			io.put_new_line
		rescue
			state := state + 1
			retry
		end

end