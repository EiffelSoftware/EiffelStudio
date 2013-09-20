class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			report (Current = if twin ~ Current then Current else twin end, 1)
			report (Current /= if twin ~ Current then twin elseif twin ~ twin then Current else twin end, 2)
		end

feature {NONE} -- Output

	report (value: BOOLEAN; test_number: NATURAL_32)
			-- Report that a test `test_number' completed with result `value'.
		do
			io.put_string ("Test ")
			io.put_natural_32 (test_number)
			if value then
				io.put_string (": OK.")
			else
				io.put_string (": FAILED.")
			end
			io.put_new_line
		end

end
