indexing
	description:
		"Utility class for checking features"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	CHECK_UTILITY

feature -- Status report

	has_passed (t: TESTABLE; run: INTEGER): BOOLEAN is
			-- Has `run' of `t' passed?
		require
			test_exists: t /= Void
			valid_run_number: t.valid_run_index (run)
		local
			old_run: INTEGER
			res: TEST_RESULT
		do
			res := t.test_results
			old_run := res.run
			res.select_run (run)
			Result := res.has_passed
			res.select_run (old_run)
		end
		
	has_execution_time (t: SINGLE_TEST; run: INTEGER): BOOLEAN is
			-- Has `run' of `t' a recorded execution time?
		require
			test_exists: t /= Void
			valid_run_number: t.valid_run_index (run)
		local
			old_run: INTEGER
			res: TEST_CASE_RESULT
		do
			res := t.test_results
			old_run := res.run
			res.select_run (run)
			Result := res.has_execution_time
			res.select_run (old_run)
		end
		
end -- class CHECK_UTILITY

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
