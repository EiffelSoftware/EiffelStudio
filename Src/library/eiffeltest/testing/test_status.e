indexing
	description:
		"Test status information"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	TEST_STATUS

feature -- Status report

	has_passed (n: INTEGER): BOOLEAN is
			-- Has run `n' of test passed?
		require
			results_available: has_results
			valid_run_number: valid_run_index (n)
		deferred
		end
	 
	valid_run_index (n: INTEGER): BOOLEAN is
	 		-- Is run index `n' valid?
		deferred
		end

	has_results: BOOLEAN is
			-- Results for logging available?
		deferred
		end

	has_execution_time (n: INTEGER): BOOLEAN is
			-- Does run `n' of test has a recorded execution time?
		require
			results_available: has_results
			valid_run_number: valid_run_index (n)
		deferred
		end
	 
end -- class TEST_STATUS

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
