indexing
	description:
		"Results of executing a test suite"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TEST_SUITE_RESULT inherit

	TEST_RESULT
		undefine
			copy, is_equal, run_count
		end

	ACTIVE_CONTAINER [TEST_RUN_RESULT]
		rename
			index as run, count as run_count, valid_index as valid_run_index, 
			go_i_th as select_run
		export
			{NONE} item, extend, replace, remove
		undefine
			copy, is_equal
		end
		
	ARRAYED_ADAPTER [TEST_RUN_RESULT]
		rename
			make as list_make, index as run, count as run_count, 
			valid_index as valid_run_index, go_i_th as select_run
		export
			{NONE} all
		end
		
	RESULT_STATE_CONSTANTS
		undefine
			copy, is_equal
		end

create
	
	make

feature {NONE} -- Initialization

	make is
			-- Create result.
		do
			list_make (0)
		end

feature -- Measurement

	passed_tests: INTEGER
			-- Number of passed tests
	 
	failed_tests: INTEGER
			-- Number of failed tests
	 
	exceptions: INTEGER
			-- Number of thrown exceptions
	 
feature -- Status report

	all_tests_passed: BOOLEAN is
			-- Have all test runs passed?
		local
			old_run: INTEGER
			i: INTEGER
		do
			if has_results then
				old_run := run
				from
					i := 1
					Result := True
				until
					not Result or i > run_count
				loop
					select_run (i)
					Result := has_passed
					i := i + 1
				end
				select_run (old_run)
			end
		ensure then
			run_unchanged: run = old run
		end
	 
	has_passed: BOOLEAN is
			-- Has selected run passed?
		do
			Result := (item.state = Passed_state)
		end

	is_exception: BOOLEAN is
			-- Has selected run thrown an exception?
		do
			Result := (item.state = Exception_state)
		end

	insertable (v: TEST_RUN_RESULT): BOOLEAN is
			-- Can `v' be inserted?
		do
			Result := True
		end

	has_results: BOOLEAN is
			-- Are there test results available?
		do
			Result := run_count > 0
		end

feature -- Element change

	add_result (res: LINEAR [TEST_RUN_RESULT]) is
			-- Add result from subresults `res'.
		require
			results_not_empty: res /= Void and then not res.is_empty
		local
			final_res: TEST_RUN_RESULT
		do
			from 
				res.start 
			until 
				res.after or (final_res /= Void and then
					final_res.state = Exception_state)
			loop
				if res.item /= Void and then (final_res = Void or else 
					res.item.state > final_res.state) then 
					final_res := res.item
				end
				res.forth
			end
			
			passed_tests := passed_tests + final_res.passed_tests
			failed_tests := failed_tests + final_res.failed_tests
			exceptions := exceptions + final_res.exceptions
			extend (final_res)
		end

feature -- Removal
	
	clear_results is
			-- Clear test results.
		do
			passed_tests := 0
			failed_tests := 0
			exceptions := 0
		end

invariant

	all_tests_passed_definition: 
			all_tests_passed = (has_results and failed_tests = 0)
	valid_run_index: has_results implies valid_run_index (run)
	
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




end -- class TEST_SUITE_RESULT

