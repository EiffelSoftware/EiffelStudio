indexing
	description:
		"Testable components consisting out of a single test"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class SINGLE_TEST inherit

	TESTABLE

	EXCEPTIONS
		export
			{NONE} all
		end
		
feature -- Access

	test_results: TEST_CASE_RESULT
			-- Results of test

feature -- Measurement

	run_count: INTEGER
			-- Number of runs

	total_run_count: INTEGER is
			-- Number of runs
			-- (Equal to `run_count' for single tests.)
		do
			Result := run_count
		end

feature -- Status report
	
	Is_test_container: BOOLEAN is False
			-- is test a container? (Answer: no)
	 
	Has_random_generator: BOOLEAN is False
			-- Does current object have access to a random number generator?
			-- (Answer: no)
	 
	is_rescue_enabled: BOOLEAN is
			-- Is exception trapping enabled?
		do
			Result := not rescue_disabled_flag
		end
	
	is_prefix_set: BOOLEAN is
			-- Is prefix set?
		do
			Result := prefix_string /= Void
		end

	is_reason_set: BOOLEAN is
			-- Is reason set?
		do
			Result := reason /= Void
		end

	has_current_result: BOOLEAN is
			-- Has a current result been recorded?
		do
			Result := test_results /= Void and then
				test_results.has_current_result
		end
		
	is_ready: BOOLEAN is
			-- Is test ready to be executed?
		do
			Result := (not Top_level_allowed implies is_container_set) and 
				is_number_set and is_name_set
		end

	has_passed (n: INTEGER): BOOLEAN is
			-- Has run `n' of test passed?
		local
			old_run: INTEGER
		do
			old_run := test_results.run
			test_results.select_run (n)
			Result := test_results.has_passed
			test_results.select_run (old_run)
		end
	 
	is_exception (n: INTEGER): BOOLEAN is
			-- Did run `n' of test throw an exception?
		local
			old_run: INTEGER
		do
			if has_results then
				old_run := test_results.run
				test_results.select_run (n)
				Result := test_results.is_exception
				test_results.select_run (old_run)
			end
		end
	 
	has_execution_time (n: INTEGER): BOOLEAN is
			-- Has run `n' of test a recorded execution time?
		local
			old_run: INTEGER
		do
			old_run := test_results.run
			test_results.select_run (n)
			Result := test_results.has_execution_time
			test_results.select_run (old_run)
		end
	 
	has_any_execution_time: BOOLEAN is
			-- Does any test have a recorded execution time?
		local
			old_run: INTEGER
			i: INTEGER
		do
			old_run := test_results.run
			from
				i := 1
			until
				Result or i > run_count
			loop
				test_results.select_run (i)
				Result := test_results.has_any_execution_time
				i := i + 1
			end
			test_results.select_run (old_run)
		ensure then
			run_unchanged: test_results.run = old test_results.run
		end

feature -- Status setting

	set_prefix (s: STRING) is
			-- Set prefix to `s'.
		require
			not_set: not is_prefix_set
			non_empty_string: s /= Void and then not s.is_empty
		do
			prefix_string := s
		ensure
			prefix_set: prefix_string = s
		end

	set_reason (s: STRING) is
			-- Set reason to `s'.
		require
			not_set: not is_reason_set
			non_empty_string: s /= Void and then not s.is_empty
		do
			reason := s
		ensure
			reason_set: reason = s
		end

	reset_messages is
			-- Reset optional messages.
		do
			prefix_string := Void
			reason := Void
		ensure
			no_prefix: not is_prefix_set
			no_reason: not is_reason_set
		end
		
	enable_rescue is
			-- Enable exception trapping.
		do
			rescue_disabled_flag := False
		ensure
			enabled: is_rescue_enabled
		end
	 
	disable_rescue is
			-- Disable exception trapping.
		do
			rescue_disabled_flag := True
		ensure
			disabled: not is_rescue_enabled
		end
	 
	clear_results is
			-- Clear results.
		do
			test_results.clear_results
		end 

feature -- Basic operations

	execute is
			-- Execute test.
		do
			run_count := run_count + 1
			if is_rescue_enabled then
				run_with_rescue
			else
				run_without_rescue
			end
				check
					result_available_if_expected: 
							produces_result implies has_current_result
						-- Because if test produces a result, one has been
						-- established by now
				end
			if produces_result then test_results.finish_recording end
			if has_standard_output then standard_output.put_character ('.') end
		ensure then
			recording_finished: not has_current_result
			one_more_run: produces_result implies run_count = old run_count + 1
			run_count_consistent: produces_result implies 
					(run_count = test_results.run_count)
		end

	do_test is
			-- Do test action.
		deferred
		end
	
feature {NONE} -- Basic operations

	assert (a: BOOLEAN; n: STRING) is
			-- Check if assertion `a' with name `n' holds.
		require
			produces_result: produces_result
			name_exists: n /= Void
			reason_or_name: is_reason_set xor not name.is_empty
		do
			check_assertion (a, n)
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_equal (a, b: ANY) is
			-- Assert that `a' and `b' are equal.
		require
			produces_result: produces_result
		do
			check_assertion (equal (a, b), 
				"expected: <" + b.out + "> but was: <" + a.out + ">")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_not_equal (a, b: ANY) is
			-- Assert that `a' and `b' are not equal.
		require
			produces_result: produces_result
		do
			check_assertion (not equal (a, b), 
				"Unexpected value: <" + a.out + ">")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_equal_double (a, b, delta: DOUBLE) is
			-- Assert that floating point number `a' and `b' are equal.
		require
			produces_result: produces_result
		local
			minval: DOUBLE
			maxval: DOUBLE
		do
			minval := a.min (b)
			maxval := a.max (b)
			check_assertion ((maxval - minval <= delta), 
				"DOUBLEs not equal, expected delta: " + delta.out +
				" actual delta: " + (maxval - minval).out)
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_void (a: ANY; n: STRING) is
			-- Assert that `a' is Void and supply name `n'.
		require
			produces_result: produces_result
			name_exists: n /= Void
		do
			check_assertion (a = Void, "<" + n + "> is not Void!")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_not_void (a: ANY; n: STRING) is
			-- Assert that `a' is not Void and supply name `n'.
		require
			produces_result: produces_result
			name_exists: n /= Void
		do
			check_assertion (a /= Void, "<" + n + "> is Void!")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_same (a, b: ANY) is
			-- Assert that `a' and `b' are the same objects.
		require
			produces_result: produces_result
		do
			check_assertion (a = b, 
				"<" + a.out + "> is not the same object as <" + b.out + ">!")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_not_same (a, b: ANY) is
			-- Assert that `a' and `b' are not the same objects.
		require
			produces_result: produces_result
		do
			check_assertion (a = b, 
				"<" + a.out + "> is the same object as <" + b.out + ">!")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	assert_exception is
			-- Assert that an exception is thrown.
			-- ATTENTION: Has to be called *before* the exception occurs.
		require
			produces_result: produces_result
		do
			exception_expected := True
		ensure
			exception_flag_set: exception_expected
		end
		
	pass is
			-- Add a pass.
		require
			produces_result: produces_result
		do
			check_assertion (True, "")
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

	fail (r: STRING) is
			-- Add a failure with reason `r'.
		require
			produces_result: produces_result
			non_empty_reason: r /= Void and then not r.is_empty
		do
			check_assertion (False, r)
		ensure
			prefix_reset: not is_prefix_set
			reason_reset: not is_reason_set
		end

feature -- Output

	put_summary (f: LOG_FACILITY) is
			-- Output test summary to `f'.
		do
			f.put_summary (Current)
		end
	 
	 put_failure_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output failure information for run `n' to `f'.
		do
			f.put_failure_information (Current, n)
		end
	 
	 put_timing_information (f: LOG_FACILITY; n: INTEGER) is
	 		-- Output timing information for run `n' to `f'.
		do
			f.put_timing_information (Current, n)
		end
	 
feature {NONE} -- Inapplicable

	seed: INTEGER is
			-- Random seed
		do
		end
	 
	set_seed (s: INTEGER) is
			-- Set seed to `s'.
		do
		end

feature {NONE} -- Implementation

	reason: STRING
			-- Optional alternate reason

	rescue_disabled_flag: BOOLEAN
			-- Is exception trapping disabled?

	exception_expected: BOOLEAN
			-- Is expected that test throws an exception?
			
	prefix_string: STRING
			-- Optional prefix
	
	check_assertion (a: BOOLEAN; m: STRING) is
			-- Check if assertion `a' holds. If not, register failure with
			-- failure message `m' or alternate message `reason', if set.
		require
			produces_result: produces_result
			message_exists: m /= Void
		local
			msg: STRING
		do
			if a then
				test_results.add_pass
			else
				if reason /= Void then 
					msg := clone (reason) 
				else
					msg := clone (m)
				end

				if prefix_string /= Void then
					msg.prepend (": ")
					msg.prepend (prefix_string)
				end
				test_results.add_failure (msg)
				reset_messages
			end
		ensure
			no_prefix: not is_prefix_set
			no_reason: not is_reason_set
		end

	run_with_rescue is
			-- Run test with exception trapping.
		require
			trapping_enabled: is_rescue_enabled
		local
			retried: BOOLEAN
			e: EXCEPTION_INFO
		do
			if not retried then 
				run_without_rescue 
				if exception_expected then
					fail ("Expected exception was not thrown!")
				end
			end
		rescue
			if exception_expected then
				test_results.clear_current_result
				pass
			else
				create e
				if is_developer_exception then
					e.set_type (clone (developer_exception_name))
					e.set_tag_name ("[No tag]")
				else
					e.set_type (clone (meaning (original_exception)))
					e.set_tag_name (clone (original_tag_name))
				end
				e.set_origin_class (clone (original_class_name))
				e.set_origin_feature (clone (original_recipient_name))
					check
						complete: e.complete
							-- Because all information has been filled in.
					end
				test_results.add_exception (e)
				tear_down
			end
			retried := True
			retry
		end

	run_without_rescue is
			-- Run test without exception trapping.
		do
			set_up
			do_test
	 		tear_down
		end

	compare_exception_info (src, dest: EXCEPTION_INFO): BOOLEAN is
			-- Does `src' denote the same exception as `dest'?
		require
			no_void_source: src /= Void
			destination_complete: dest /= Void and then dest.complete
		local
			src_list: ARRAYED_LIST [STRING]
			dest_list: ARRAYED_LIST [STRING]
		do
			create src_list.make (4)
			create dest_list.make (4)
			src_list.extend (src.type)
			dest_list.extend (dest.type)

			if not src.origin_class.is_empty then
				src_list.extend (src.origin_class)
				dest_list.extend (dest.origin_class)
			end

			if not src.origin_feature.is_empty then
				src_list.extend (src.origin_feature)
				dest_list.extend (dest.origin_feature)
			end

			if not src.tag_name.is_empty then
				src_list.extend (src.tag_name)
				dest_list.extend (dest.tag_name)
			end

			check
				count_equal: src_list.count = dest_list.count
					-- Because items have been inserted pairwise into the list.
			end

			from
				src_list.start
				dest_list.start
				Result := True
			until
				not Result or else src_list.after
			loop
				Result := equal (src_list.item, dest_list.item)
				src_list.forth
				dest_list.forth
			end
		end
		
invariant

	no_empty_prefix: prefix_string /= Void implies not prefix_string.is_empty
	no_empty_reason: reason /= Void implies not reason.is_empty
	run_count_equality: run_count = total_run_count

end -- class SINGLE_TEST

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
