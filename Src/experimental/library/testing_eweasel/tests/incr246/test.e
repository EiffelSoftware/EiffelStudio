class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			d: D
		do
			create d
			report_test_result (d.a_once $ONCE_TEST, 1)
			report_test_result (d.c_once $ONCE_TEST, 2)
			report_test_result (d.d_once $ONCE_TEST, 3)
			report_test_result (d.a_once /= Void implies d.a_once /= d.c_once, 4)
			report_test_result (d.c_once /= Void implies d.c_once /= d.d_once, 5)
			report_test_result (d.d_once /= Void implies d.d_once /= d.a_once, 6)
			report_test_result (d.a_once = d.a_once, 7)
			report_test_result (d.c_once = d.c_once, 8)
			report_test_result (d.d_once = d.d_once, 9)
		end

feature {NONE} -- Output

	report_test_result (value: BOOLEAN; number: INTEGER) is
			-- Report test result `value' of test number `number'
		do
			io.put_string ("Test ")
			io.put_integer (number)
			io.put_string (": ")
			if value then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		end

end
