indexing
	description:
		"Results of executing a test suite"

	status:	"See note at end of class"
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
	
end -- class TEST_SUITE_RESULT

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
