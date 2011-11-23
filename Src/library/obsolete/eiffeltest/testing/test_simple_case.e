note
	description:
		"Test cases that consist of a complete test and produce a result"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_SIMPLE_CASE inherit

	SINGLE_TEST
		redefine
			run_without_rescue
		end

feature {NONE} -- Initialization

	make
			-- Create test.
		do
			create test_results.make
		ensure
			result_counter_created: test_results /= Void
		end

feature -- Status report

	Is_complete_test: BOOLEAN = True
			-- Is test a complete test? (Answer: yes)

	Produces_result: BOOLEAN = True
			-- Does test produce result? (Answer: yes)

	Top_level_allowed: BOOLEAN = True
			-- Can test be inserted in the top level of test hierarchy?
			-- (Answer: Yes)

	has_current_passed: BOOLEAN
			-- Has currently ongoing test passed (so far)?
		require
			results_available: has_current_result
		do
			Result := test_results.has_current_passed
		end

	is_current_exception: BOOLEAN
			-- Did currently ongoing test throw an exception?
		require
			results_available: has_current_result
		do
			Result := test_results.is_current_exception
		end

	has_expected_result: BOOLEAN
			-- Is there an expected result?
		do
			Result := exception_expected xor expected_result /= Void
		end

feature -- Status setting

	set_expected_result (r: TEST_RUN_RESULT)
			-- Set expected result to `r'.
		do
			exception_expected := r.is_exception
			if not exception_expected then
				expected_result := r.has_passed
			end
		ensure
			result_setting_ok: has_expected_result
		end

	clear_expected_result
			-- Clear expected result
		do
			expected_result := Void
		ensure
			result_cleared: not has_expected_result
		end
		
feature {NONE} -- Basic operation

	assert_timing (d: DOUBLE)
			-- Assert `d' seconds execution timing.
		require
			positive_time: d > 0
		do
			expected_time := d
		ensure
			time_set: expected_time.item = d
		end

feature {NONE} -- Constants

	Expected_result_text: STRING = "Unexpected result"
	
	No_tests_text: STRING = "No tests in this test case!"

feature {NONE} -- Implementation

	expected_result: BOOLEAN_REF
			-- Expected result
		
	expected_time: DOUBLE_REF
			-- Expected execution time
			
	run_without_rescue
			-- Run test without exception trapping.
		local
			res: BOOLEAN
			start: TIME
			finish: TIME
			diff: TIME_DURATION
			f: FORMAT_DOUBLE
		do
			create start.make_now
			Precursor
			create finish.make_now
			diff := finish.relative_duration (start)
			if expected_time /= Void then
				create f.make (9, 4)
				f.no_justify
				assert (diff.fine_seconds_count <= expected_time.item,
					"Expected time exceeded (Expected: " +
					f.formatted (expected_time.item) + " s, Actual: " +
					f.formatted (diff.fine_seconds_count) + " s)")
			end
			if not has_current_result then
				test_results.add_failure (No_tests_text)
			elseif has_expected_result then
				if expected_result /= Void then
					res := has_current_passed
					test_results.clear_current_result
					assert (equal (res, expected_result.item), 
						Expected_result_text)
				elseif exception_expected then
					res := is_current_exception
					test_results.clear_current_result
					assert (equal (res, exception_expected), 
						Expected_result_text)
				else
					check
						impossible_case: False
							-- This case cannot happen.
					end
				end
			end
			test_results.set_execution_time (diff)
				check
					result_available: has_current_result
						-- Because there has been at least one assertion
				end
		end

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




end -- class TEST_CASE

