indexing
	description:
		"Containers storing testable components"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_CONTAINER inherit

	ACTIVE_CONTAINER [TESTABLE]
		rename
			count as test_count, item as selected_test, i_th as test,
			valid_index as valid_test_index, go_i_th as select_test
		end

	LOGGABLE

	STANDARD_OUTPUT_FACILITY
		redefine
			set_standard_output
		end

	TEST_STATISTICS
		rename
			count as test_count, passed_tests as contained_passed_tests,
			failed_tests as contained_failed_tests,
			pass_percentage as contained_pass_percentage,
			fail_percentage as contained_fail_percentage
		end

feature -- Measurement

	run_count: INTEGER is
			-- Number of runs for selected test
		require
			valid_index: valid_test_index (index)
		deferred
		end
	 
	total_run_count: INTEGER is
			-- Number of total runs
		require
			not_empty: not is_empty
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from i := 1 until i > test_count loop
				select_test (i)
				if selected_test.total_run_count > Result then 
					Result := selected_test.total_run_count
				end
				i := i + 1
			end
			select_test (old_idx)
		ensure
			index_unchanged: index = old index
		end

	 contained_passed_tests: INTEGER is
	 		-- Number of contained passed tests
		do
			calculate_results
			Result := passed_count
		end

	 contained_failed_tests: INTEGER is
	 		-- Number of contained failed tests
		do
			calculate_results
			Result := failed_count
		end

feature -- Status report

	has (t: TESTABLE): BOOLEAN is
			-- is `t' in container?
		require
			test_exists: t /= Void
		deferred
		end
		
	stop_on_failure: BOOLEAN
			-- Does a failure stop execution?

	failure_stop: BOOLEAN is
			-- Shall execution be stopped for selected test?
		do
			Result := not selected_test.has_passed (run_count)
		end

	has_execution_time (n: INTEGER): BOOLEAN is
			-- Has run `n' of any test a recorded execution time?
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from 
				i := 1 
			until 
				not Result or i > test_count 
			loop
				select_test (i)
				if selected_test.has_results and 
					n <= selected_test.run_count then
					Result := selected_test.has_execution_time (n)
				end
				i := i + 1
			end
			select_test (old_idx)
		ensure then
			index_unchanged: index = old index
		end
	 
	has_any_execution_time: BOOLEAN is
			-- Has any run of any test a recorded execution time?
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from 
				i := 1 
			until 
				Result or i > run_count 
			loop
				select_test (i)
				Result := selected_test.has_any_execution_time
				i := i + 1
			end
			select_test (old_idx)
		ensure then
			index_unchanged: index = old index
		end
	 
	has_passed (n: INTEGER): BOOLEAN is
			-- Has run `n' of all tests passed?
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from 
				i := 1 
				Result := True
			until 
				not Result or i > test_count 
			loop
				select_test (i)
				if selected_test.has_results and 
					n <= selected_test.total_run_count then
					Result := selected_test.has_passed (n)
				end
				i := i + 1
			end
			select_test (old_idx)
		ensure then
			index_unchanged: index = old index
		end
	
	is_exception (n: INTEGER): BOOLEAN is
			-- Did run `n' throw an exception in any test?
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			from 
				i := 1 
				Result := True
			until 
				not Result or i > test_count 
			loop
				select_test (i)
				if selected_test.has_results and 
					n <= selected_test.total_run_count then
					Result := selected_test.is_exception (n)
				end
				i := i + 1
			end
			select_test (old_idx)
		ensure then
			index_unchanged: index = old index
		end


feature -- Status setting

	enable_stop is
			-- Enable stop on failure.
		do
			stop_on_failure := True
		ensure
			enabled: stop_on_failure
		end

	disable_stop is
			-- Disable stop on failure.
		do
			stop_on_failure := False
		ensure
			disabled: not stop_on_failure
		end

	set_standard_output (o: IO_MEDIUM) is
			-- Set standard output to `o'.
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			Precursor (o)
			from i := 1 until i > test_count loop
				select_test (i)
				selected_test.set_standard_output (o)
				i := i + 1
			end
		end

feature -- Output

	put_summary (f: LOG_FACILITY) is
			-- Output test summary to `f'.
		local
			old_test: INTEGER
			i: INTEGER
		do
			old_test := index
			from i := 1 until i > test_count loop
				select_test (i)
				if selected_test.has_results then
					selected_test.put_summary (f)
				end
				i := i + 1
			end
			select_test (old_test)
		end
	 
	 put_failure_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output failure information for run `n' to `f'.
		local
			old_test: INTEGER
			i: INTEGER
		do
			old_test := index
			from i := 1 until i > test_count loop
				select_test (i)
				if selected_test.has_results and 
					n <= selected_test.total_run_count and
					not selected_test.has_passed (n) then
					selected_test.put_failure_information (f, n)
				end
				i := i + 1
			end
			select_test (old_test)
		end
	 
	 put_timing_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output timing information for run `n' to `f'.
		local
			old_test: INTEGER
			i: INTEGER
		do
			old_test := index
			from i := 1 until i > test_count loop
				select_test (i)
				if selected_test.has_results and 
					n <= selected_test.total_run_count and
				   selected_test.has_execution_time (n) then
					selected_test.put_timing_information (f, n)
				end
				i := i + 1
			end
			select_test (old_test)
		end
	 
feature {NONE} -- Implementation

	cached: BOOLEAN
			-- Is a pass/fail result cached?

	passed_count: INTEGER
			-- Cached number of passed tests

	failed_count: INTEGER
			-- Cached number of failed tests

	calculate_results is
			-- Calculate number of passed and failed tests.
		local
			old_idx: INTEGER
			i: INTEGER
		do
			if not cached then
				old_idx := index
				from i := 1 until i > test_count loop
					select_test (i)
					if selected_test.all_tests_passed then
						passed_count := passed_count + 1
					else
						failed_count := failed_count + 1
					end
					i := i + 1
				end
				cached := True
				select_test (old_idx)
			end
		ensure
			cached: cached
			index_unchanged: index = old index
		end
		
invariant

	count_constraint: cached implies
			test_count = contained_passed_tests + contained_failed_tests

end -- class TEST_CONTAINER

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
