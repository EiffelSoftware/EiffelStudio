class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			f: FIXED_LIST [INTEGER]
		do
			create f.make (3)
			report_list_state (f, 1)
			f.extend (0)
			report_list_state (f, 2)
			f.extend (0)
			report_list_state (f, 3)
			f.extend (0)
			report_list_state (f, 4)
			f.finish
			f.remove
			report_list_state (f, 5)
			f.finish
			f.remove
			report_list_state (f, 6)
			f.finish
			f.remove
			report_list_state (f, 7)
		end

feature {NONE} -- Output

	report_list_state (list: FIXED_LIST [INTEGER]; test_number: INTEGER) is
			-- Report state of `list' in test identified by `test_number'.
		require
			list_not_void: list /= Void
		do
			io.put_string ("Test ")
			io.put_integer (test_number)
			io.put_string (": ")
			io.put_boolean (list.has (0))
			io.put_character (' ')
			io.put_boolean (list.valid_index (2))
			io.put_character (' ')
			io.put_boolean (list.is_equal (create {FIXED_LIST [INTEGER]}.make (4)))
			io.put_new_line
		end

end
