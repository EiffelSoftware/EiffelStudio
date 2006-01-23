indexing
	description:
		"Utility class for checking features"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CHECK_UTILITY

