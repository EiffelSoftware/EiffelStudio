note
	description:
		"General test drivers"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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

	run_count: INTEGER
			-- Number of runs for selected test
		do
			Result := selected_test.run_count
		end
	 
feature -- Status report

	Is_enabled: BOOLEAN = True
			-- Is test enabled? (Answer: yes)

	is_ready: BOOLEAN
			-- Is test ready for execution?
		do
			Result := not is_empty
		end
		
	is_log_set: BOOLEAN
			-- Is log set up?
		do
			Result := log /= Void and then not log.is_format_set
		end

	has_results: BOOLEAN
			-- Are results available?
			
	all_tests_passed: BOOLEAN
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

	insertable (v: TESTABLE): BOOLEAN
			-- Can `v' be inserted?
		do
			Result := v.top_level_allowed
		end

	timing_display_enabled: BOOLEAN
			-- Is display of timing information enabled?
			
	valid_run_index (n: INTEGER): BOOLEAN
			-- Is run `n' valid?
		do
			Result := 1 <= n and n <= total_run_count
		end

feature -- Status setting

	set_log (l: LOG_FACILITY)
			-- Set log to `l'.
		require
			log_exists: l /= Void
			log_format_set: l.is_format_set
		do
			log := l
		ensure
			log_set: log = l
		end
		
	enable_timing_display
			-- Enable display of timing information.
		do
			timing_display_enabled := True
		ensure
			enabled: timing_display_enabled
		end

	disable_timing_display
			-- Disable display of timing information.
		do
			timing_display_enabled := False
		ensure
			disabled: not timing_display_enabled
		end

feature -- Basic operations

	execute
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
	
	clear_results
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

	evaluate
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




end -- class TEST_DRIVER

