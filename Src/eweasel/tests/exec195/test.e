class TEST

inherit
	EXCEPTIONS

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			test
		end

feature {NONE} -- Tests

	test is
			-- Test exception codes.
		local
			retried: BOOLEAN
		do
			if retried then
					-- Check that exception code is not reset
				report_test_result (Routine_failure, 3)

				do_nothing_without_rescue
					-- Check that exception code is not changed
				report_test_result (Routine_failure, 4)

				do_nothing_with_rescue
					-- Check that exception code is not changed
				report_test_result (Routine_failure, 5)
			else
				report_test_result (0, 1)
				raise_routine_failure
					-- We should not get here
				report_test_result (0, -1)
			end
		rescue
				-- We get here after `raise_routine_failure'
			report_test_result (Routine_failure, 2)
			retried := True
			retry
		end

	raise_routine_failure is
			-- Raise `Routine_failure' exception.
		do
			raise ("raise_routine_failure")
		rescue
			do_nothing
		end

	do_nothing_without_rescue is
			-- Do nothing without rescue clause.
		do
			do_nothing
		end

	do_nothing_with_rescue is
			-- Do nothing with rescue clause.
		do
			do_nothing
		rescue
			do_nothing
		end

feature {NONE} -- Output

	report_test_result (e: INTEGER; n: INTEGER) is
			-- Report whether current exception is equal to `e'
			-- in test number `n'.
		do
			io.put_string ("Test " + n.out + ": ")
			if exception = e then
				io.put_string ("OK")
			else
				io.put_string ("FAILED: expected " + e.out + " but got " + exception.out)
			end
			io.put_new_line
		end

end