indexing
	description:
		"Objects that can produce output to the test logging facility"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class LOGGABLE inherit

	TEST_STATUS

feature -- Output

	put_summary (f: LOG_FACILITY) is
			-- Output test summary to `f'.
		require
			facility_exists: f /= Void
			facility_set_up: f.is_device_set and f.is_format_set
			results_available: has_results
		deferred
		end
	 
	 put_failure_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output failure information for run `n' to `f'.
		require
			facility_exists: f /= Void
			facility_set_up: f.is_device_set and f.is_format_set
			valid_run_number: valid_run_index (n)
			results_available: has_results
			failed_test: not has_passed (n)
		deferred
		end

	 put_timing_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output timing information for run `n' to `f'.
		require
			log_exists: f /= Void
			log_format_set: f.is_format_set
			valid_run_number: valid_run_index (n)
			results_available: has_results
			timing_recorded: has_execution_time (n)
		deferred
		end
	 
end -- class LOGGABLE

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
