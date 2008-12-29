note
	description:
		"Logging interface for tests"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_LOGGER inherit

	CHECK_UTILITY

feature -- Status report

	is_log_writable: BOOLEAN
			-- Is log ready for writing?
		deferred
		end
	
feature -- Output

	put_evaluation (d: TEST_DRIVER)
			-- Output evaluation from driver `d'.
		require
			driver_exists: d /= Void
			has_results: d.has_results
			writable: is_log_writable
		deferred
		end

	put_string (s: STRING)
			-- Output `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
			writable: is_log_writable
		deferred
		end

	put_summary (t: TESTABLE)
			-- Output result summary for `t'.
		require
			test_exists: t /= Void
			result_available: t.produces_result
			writable: is_log_writable
		deferred
		end
	 
	put_container_results (t: TEST_CONTAINER)
			-- Output statistic information about tests contained in `t'.
		require
			container_exists: t /= Void
			writable: is_log_writable
		deferred
		end
	 
	put_failure_information (t: SINGLE_TEST; run: INTEGER)
			-- Output failure information of `run' for `t'.
		require
			test_exists: t /= Void
			result_available: t.produces_result
			writable: is_log_writable
			valid_run_number: t.valid_run_index (run)
			failed_test: not has_passed (t, run)
		deferred
		end
	 
	put_timing_information (t: SINGLE_TEST; run: INTEGER)
			-- Output timing information for `run' of test `t'.
		require
			test_exists: t /= Void
			writable: is_log_writable
			valid_run_number: t.valid_run_index (run)
			timing_available: has_execution_time (t, run)
		deferred
		end
	 
	put_new_line
			-- Output new line.
		require
			writable: is_log_writable
		deferred
		end
	 
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TEST_LOGGER

