class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			u: UTF_CONVERTER
		do
			report (1, u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<>>).area))
			report (2, u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<0>>).area))
			report (3, not u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<0, 0xD800>>).area))
			report (4, u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<1>>).area))
			report (5, not u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<1, 0xDC00>>).area))
			report (6, u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<0xD7FF>>).area))
			report (7, not u.is_valid_utf_16 (({ARRAY [NATURAL_16]} <<0xD800>>).area))
		end

feature {NONE} -- Output

	report (test_number: NATURAL_32; value: BOOLEAN)
			-- Check whether `value` is true and print an approprite result mesage for test `test_number`.
		do
			io.put_string ("Test #")
			io.put_natural_32 (test_number)
			io.put_string (if value then ": OK" else ": Failed" end)
			io.put_new_line
		end

end
