indexing
	description:
		"Utility class for checking features"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
