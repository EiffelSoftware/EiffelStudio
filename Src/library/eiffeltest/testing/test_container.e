indexing
	description:
		"Containers storing testable components"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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
			not_empty: not empty
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
	 
end -- class TEST_CONTAINER

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
