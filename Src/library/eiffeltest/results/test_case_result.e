indexing
	description:
		"Results of test cases"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TEST_CASE_RESULT inherit

	TEST_RESULT
		undefine
			copy, is_equal
		end
	
	ACTIVE_CONTAINER [CASE_RESULT_RECORD [ASSERTION_RESULT]]
		rename
			index as run, count as run_count, valid_index as valid_run_index, 
			go_i_th as select_run
		export
			{NONE} item, extend, replace, remove
		undefine
			copy, is_equal
		end
		
	ARRAYED_ADAPTER [CASE_RESULT_RECORD [ASSERTION_RESULT]]
		rename
			make as list_make, index as run, valid_index as valid_run_index, 
			go_i_th as select_run
		export
			{NONE} all
		end
		
create
	
	make

feature {NONE} -- Initialization

	make is
			-- Create result.
		do
			create current_record.make
			list_make (0)
		end

feature -- Access

	failure_reason (n: INTEGER): STRING is
			-- Failure reason of assertion `n'
		require
			valid_assertion_number: valid_assertion_index (n)
			run_failed: not is_assertion_pass (n)
		do
			Result := i_th (run).failure_reason (n)
		ensure
			non_empty_reason: Result /= Void and then not Result.is_empty
		end

	exception_info (n: INTEGER): EXCEPTION_INFO is
			-- Exception info of assertion `n'
		require
			valid_assertion_number: valid_assertion_index (n)
			is_exception: not is_assertion_pass (n) and 
					is_assertion_exception (n)
		do
			Result := i_th (run).exception_info (n)
		ensure
			complete_info: Result /= Void and then Result.complete
		end

	execution_time: DOUBLE is
			-- Execution time of selected run
		require
			time_recorded: has_execution_time
		do
			Result := i_th (run).execution_time.fine_seconds_count
		end
		
feature -- Measurement

	passed_tests: INTEGER
			-- Number of passed tests

	failed_tests: INTEGER
			-- Number of failed tests

	exceptions: INTEGER
			-- Number of thrown exceptions
			
	assertions: INTEGER is
			-- Number of recorded assertions in selected run
		require
			results_available: has_results
		do
			Result := i_th (run).assertion_count
		end
		
feature -- Status report

	has_current_result: BOOLEAN is
			-- Has a current result been recorded?
		do
			Result := not current_record.is_empty
		end

	all_tests_passed: BOOLEAN is
			-- Did all tests pass?
		do
			Result := (has_results and failed_tests = 0)
		end

	has_any_execution_time: BOOLEAN is
			-- Has any run an execution time recorded?
		local
			old_run: INTEGER
			i: INTEGER
		do
			old_run := run
			from 
				i := 1 
			until 
				Result or i > run_count 
			loop
				select_run (i)
				Result := has_execution_time
				i := i + 1
			end
			select_run (run)
		end

	has_passed: BOOLEAN is
			-- Has selected run passed?
		do
			Result := i_th (run).passed
		end

	has_execution_time: BOOLEAN is
			-- Has execution time been recorded?
		do
			Result := i_th (run).has_execution_time
		end

	is_exception: BOOLEAN is
			-- Has selected run thrown an exception?
		do
			Result := i_th (run).is_exception
		end

	has_current_passed: BOOLEAN is
			-- Has currently recorded test passed (so far)?
		require
			recording: has_current_result
		do
			Result := current_record.passed
		end

	is_current_exception: BOOLEAN is
			-- Did currently recorded test throw an exception (yet)?
		require
			recording: has_current_result
		do
			Result := current_record.is_exception
		end

	is_assertion_pass (n: INTEGER): BOOLEAN is
			-- Is assertion `n' of selected run a pass?
		require
			results_available: has_results
			valid_assertion_index: valid_assertion_index (n)
		do
			Result := i_th (run).is_assertion_pass (n)
		end

	is_assertion_exception (n: INTEGER): BOOLEAN is
			-- Is assertion `n' of selected run a pass?
		require
			results_available: has_results
			valid_assertion_index: valid_assertion_index (n)
		do
			Result := i_th (run).is_assertion_exception (n)
		end

	insertable (v: like current_record): BOOLEAN is
			-- Can `v' be inserted?
		do
			Result := True
		end

	has_results: BOOLEAN is
			-- Are there test results available?
		do
			Result := not is_empty
		end

	valid_assertion_index (n: INTEGER): BOOLEAN is
			-- Is assertion index `n' valid?
		require
			not_empty: has_results
		do
			Result := (1 <= n and n <= assertions)
		ensure
			valid_index_range: 1 <= n and n <= assertions
		end

feature -- Element change

	add_pass is
			-- Add pass.
		local
			a: ASSERTION_RESULT
		do
			create a.make_true
			current_record.extend (a)
		ensure
			empty_implies_pass: current_record.is_empty implies
					current_record.passed
			not_empty_implies_no_change: not current_record.is_empty implies
					(current_record.passed = old current_record.passed)
		end

	add_failure (reason: STRING) is
			-- Add failure with `reason'.
		require
			non_empty_reason: reason /= Void and then not reason.is_empty
		local
			a: ASSERTION_RESULT
		do
			create a.make_false (reason)
			current_record.extend (a)
		ensure
			not_exception_implies_failed: 
				not current_record.is_exception implies
				(not current_record.passed and not
				current_record.is_exception)
		end

	add_exception (ex: EXCEPTION_INFO) is
			-- Add exception `ex'.
		require
			exception_exists: ex /= Void
			info_complete: ex.complete
		local
			a: ASSERTION_RESULT
		do
			create a.make_exception (ex)
			current_record.extend (a)
		ensure
			is_exception: current_record.is_exception
		end

	set_execution_time (t: TIME_DURATION) is
			-- Set execution time to `t'.
		do
			current_record.set_execution_time (t)
		ensure
			time_set: current_record.execution_time = t
		end

feature -- Element change

	finish_recording is
			-- Store record and start new record.
		require
			current_result_available: has_current_result
		do
			if current_record.passed then
				passed_tests := passed_tests + 1
			else
				failed_tests := failed_tests + 1
			end
			if current_record.is_exception then
				exceptions := exceptions + 1
			end
			if is_empty then run := 1 end
			extend (current_record)
			create current_record.make
		ensure
			one_more_run: run_count = old run_count + 1
			pass_counted: old current_record.passed implies 
				passed_tests = old passed_tests + 1
			failed_counted: old not current_record.passed implies 
				failed_tests = old failed_tests + 1
			exceptions_counted: old current_record.is_exception implies 
				exceptions = old exceptions + 1
			exception_means_failed: (exceptions = old exceptions + 1) implies
				failed_tests = old failed_tests + 1
			new_record: not has_current_result
		end

feature -- Removal
	
	clear_results is
			-- Clear test results.
		do
			make
			passed_tests := 0
			failed_tests := 0
			exceptions := 0
		ensure then
			nothing_recorded: not has_current_result
		end

	clear_current_result is
			-- Clear current result record.
		do
			create current_record.make
		ensure then
			nothing_recorded: not has_current_result
		end

feature {NONE} -- Implementation

	current_record: CASE_RESULT_RECORD [ASSERTION_RESULT]
			-- Result record of actual test run

invariant

	all_tests_passed_definition: 
			all_tests_passed = (has_results and failed_tests = 0)
	current_record_exists: current_record /= Void
	valid_run_index: has_results implies valid_run_index (run)
	result_counting_consistent: run_count = count
	
end -- class TEST_CASE_RESULT

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
