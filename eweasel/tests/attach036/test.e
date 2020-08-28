class
	TEST
 
create
	make
 
feature {NONE} -- Creation
 
	make
			-- Run test.
		local
			s: SPECIAL [attached ANY]
		do
			create s.make_empty (5)
			test_item (s, 0)
			test_item (s, 1)
			test_item (s, 2)
			test_item (s, 3)
			test_item (s, 4)
			s.fill_with (Current, 0, 4)
			test_item (s, 0)
			test_item (s, 1)
			test_item (s, 2)
			test_item (s, 3)
			test_item (s, 4)
		end

feature {NONE} -- Tests

	test_item (s: attached SPECIAL [attached ANY]; i: INTEGER)
			-- Check that `i'-th item of `s' is not Void.
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
				if s.valid_index (i) then
					state := 1
					if s.item (i) = Void then
						io.put_string ("`item' is Void when it should not")
					else
						io.put_string ("OK")
					end
				else
					io.put_string ("OK")
				end
			when 1 then
				io.put_string ("`valid_index' raises an exception.")
			when 2 then
				io.put_string ("`item' raises an exception.")
			end
			io.put_new_line
		rescue
			state := state + 1
			retry
		end

end
