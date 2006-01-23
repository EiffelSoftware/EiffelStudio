indexing
	description:
		"Objects that can produce output to the test logging facility"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class LOGGABLE

