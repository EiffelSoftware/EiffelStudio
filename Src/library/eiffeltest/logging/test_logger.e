indexing
	description:
		"Logging interface for tests"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_LOGGER inherit

	CHECK_UTILITY

feature -- Status report

	is_log_writable: BOOLEAN is
			-- Is log ready for writing?
		deferred
		end
	
feature -- Output

	put_evaluation (d: TEST_DRIVER) is
			-- Output evaluation from driver `d'.
		require
			driver_exists: d /= Void
			has_results: d.has_results
			writable: is_log_writable
		deferred
		end

	put_string (s: STRING) is
			-- Output `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
			writable: is_log_writable
		deferred
		end

	put_summary (t: TESTABLE) is
			-- Output result summary for `t'.
		require
			test_exists: t /= Void
			result_available: t.produces_result
			writable: is_log_writable
		deferred
		end
	 
	put_container_results (t: TEST_CONTAINER) is
			-- Output statistic information about tests contained in `t'.
		require
			container_exists: t /= Void
			writable: is_log_writable
		deferred
		end
	 
	put_failure_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output failure information of `run' for `t'.
		require
			test_exists: t /= Void
			result_available: t.produces_result
			writable: is_log_writable
			valid_run_number: t.valid_run_index (run)
			failed_test: not has_passed (t, run)
		deferred
		end
	 
	put_timing_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output timing information for `run' of test `t'.
		require
			test_exists: t /= Void
			writable: is_log_writable
			valid_run_number: t.valid_run_index (run)
			timing_available: has_execution_time (t, run)
		deferred
		end
	 
	put_new_line is
			-- Output new line.
		require
			writable: is_log_writable
		deferred
		end
	 
end -- class TEST_LOGGER

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------
