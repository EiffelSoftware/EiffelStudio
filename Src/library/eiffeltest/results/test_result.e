indexing
	description:
		"Test results"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_RESULT inherit

	STORABLE
	
	TEST_STATISTICS
		rename
			count as run_count
		end

feature -- Access

	run: INTEGER is
			-- Number of selected run
		deferred
		end
	 
	exceptions: INTEGER is
			-- Number of thrown exceptions
		deferred
		end
	 
	run_count: INTEGER is
			-- Number of runs 
		do
			Result := passed_tests + failed_tests
		end

feature -- Status report

	all_tests_passed: BOOLEAN is
			-- Have all test runs passed?
		deferred
		end
	 
	has_passed: BOOLEAN is
			-- Has selected run passed?
		require
			results_available: has_results
		deferred
		end

	is_exception: BOOLEAN is
			-- Has selected run thrown an exception?
		require
			results_available: has_results
		deferred
		ensure
			exception_means_failed: Result implies not has_passed
		end

	has_results: BOOLEAN is
			-- Are there test results available?
		deferred
		end

	valid_run_index (i: INTEGER): BOOLEAN is
			-- Is run index `i' valid?
		deferred
		ensure
			valid_run_index: 1 <= i and i <= run_count
		end

feature -- Cursor movement

	select_run (i: INTEGER) is
			-- Select run `i'.
		require
			valid_run_index: valid_run_index (i)
		deferred
		ensure
			run_set: run = i
		end

feature -- Removal
	
	clear_results is
			-- Clear test results.
		deferred
		ensure
			run_count_reset: run_count = 0
			exceptions_reset: exceptions = 0
		end

invariant

	run_count_definition: run_count = passed_tests + failed_tests
	exception_constraint: exceptions <= failed_tests
	
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




end -- class TEST_RESULT

