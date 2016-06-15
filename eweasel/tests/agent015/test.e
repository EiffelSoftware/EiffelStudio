class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			report_open_operands (agent do_nothing, 1)
			report_open_operands (agent do_nothing, True, Current, 2)
			report_open_operands (agent procedure, True, Current, 3)
			report_open_operands (agent procedure, False, Current, 5, 4)
			report_open_operands (agent function, True, Current, 5)
			report_open_operands (agent function, False, Current, 5, 6)
		end

feature {NONE} -- Output

	report_open_operands (routine: ROUTINE; arguments: TUPLE; n: NATURAL)
			-- Report if open operands of a routine `routine' match `expected_types' for a test number `n'.
		do
			io.put_string ("Test ")
			io.put_natural (n)
			io.put_string (": ")
			if routine.open_count > arguments.count then
				io.put_string ("Wrong open argument count")
			elseif not routine.valid_operands (arguments) then
				io.put_string ("Incorrect argument types")
			else
				io.put_string ("OK")
			end
			io.put_new_line
		end

feature {NONE} -- Test

	procedure (b: BOOLEAN; x: TEST)
		do
		end

	function (b: BOOLEAN; x: TEST): TEST
		do
			Result := x
		end

end
