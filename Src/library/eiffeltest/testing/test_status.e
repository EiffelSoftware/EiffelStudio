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
