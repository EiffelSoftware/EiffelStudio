indexing
	description:
		"General test drivers"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_DRIVER inherit

	RUNNABLE
		undefine
			copy, is_equal
		end
		
	ARRAYED_TEST_CONTAINER
		export
			{LOG_OUTPUT_FORMAT} put_summary, put_failure_information
		end

feature -- Measurement

	run_count: INTEGER is
			-- Number of runs for selected test
		do
			Result := selected_test.run_count
		end
	 
feature -- Status report

	Is_enabled: BOOLEAN is True
			-- Is test enabled? (Answer: yes)

	is_ready: BOOLEAN is
			-- Is test ready for execution?
		do
			Result := not is_empty
		end
		
	is_log_set: BOOLEAN is
			-- Is log set up?
		do
			Result := log /= Void and then not log.is_format_set
		end

	has_results: BOOLEAN
			-- Are results available?
			
	all_tests_passed: BOOLEAN is
			-- Did any tests fail?
		local
			i: INTEGER
		do
			if has_results then
				from 
					i := 1 
					Result := True
				until 
					not Result or i > test_count 
				loop
					Result := has_passed (i)
					i := i + 1
				end
			end
		end

	insertable (v: TESTABLE): BOOLEAN is
			-- Can `v' be inserted?
		do
			Result := v.top_level_allowed
		end

	timing_display_enabled: BOOLEAN
			-- Is display of timing information enabled?
			
	valid_run_index (n: INTEGER): BOOLEAN is
			-- Is run `n' valid?
		do
			Result := 1 <= n and n <= total_run_count
		end

feature -- Status setting

	set_log (l: LOG_FACILITY) is
			-- Set log to `l'.
		require
			log_exists: l /= Void
			log_format_set: l.is_format_set
		do
			log := l
		ensure
			log_set: log = l
		end
		
	enable_timing_display is
			-- Enable display of timing information.
		do
			timing_display_enabled := True
		ensure
			enabled: timing_display_enabled
		end

	disable_timing_display is
			-- Disable display of timing information.
		do
			timing_display_enabled := False
		ensure
			disabled: not timing_display_enabled
		end

feature -- Basic operations

	execute is
			-- Execute test.
		local
			old_idx: INTEGER
			i: INTEGER
		do
			cached := False
			old_idx := index
			from i := 1 until i > test_count loop
				select_test (i)
				selected_test.execute
				i := i + 1
			end
			select_test (old_idx)
			has_results := True
		ensure then
			results_available: has_results
			index_unchanged: index = old index
			not_cached: not cached
		end
	
	clear_results is
			-- Clear test results.
		require
			not_empty: not is_empty
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from i := 1 until i > test_count loop
				select_test (i)
				selected_test.clear_results
				i := i + 1
			end
			select_test (old_idx)
			has_results := False
		ensure then
			results_cleared: not has_results
			index_unchanged: index = old index
		end

	evaluate is
			-- Output test evaluation.
		require
			ready: is_ready
			results_available: has_results
		do
			log.put_evaluation (Current)
		end

feature {NONE} -- Initialization

	log: LOG_FACILITY
			-- Facility for log output

invariant

	ready_definition: is_ready = not is_empty
	log_set_up: log /= Void and then log.is_format_set

end -- class TEST_DRIVER

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
