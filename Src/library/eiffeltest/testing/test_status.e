indexing
	description:
		"Test status information"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class TEST_STATUS

