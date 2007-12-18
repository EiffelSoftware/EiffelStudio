class TEST_$NAME

inherit
	TEST_SETUP
		$REDEFINE_DEFAULT_RESCUE
		end

create
	make

feature {NONE} -- Creation

	make (test_name: STRING) is
			-- Run test `test_name'.
		require
			non_void_test_name: test_name /= Void
		do
			name := test_name
			test ($BODY_ACTION, $RESCUE_ACTION, $ROUTINE_ACTION)
			if not is_failed then
				io.put_string ("Test " + name + ": OK")
				io.put_new_line
			end
		end

feature {NONE} -- Test

	test (ba, ra: INTEGER; ea: INTEGER) is
			-- Test that once feature `item' called in
			-- conditions specified by `ba' and `ra'
			-- behaves according `ea'.
		local
			i: INTEGER
			j: INTEGER
			a: INTEGER
		do
			if
				has_assertions or else
				ba /= action_assertion and then
				ra /= action_assertion and then
				ea /= action_assertion
			then
					-- Precondition violation should not affect
					-- a final result of a once routine
				test_once (action_precondition, ba, ra, action_precondition)
				test_once (action_failure, ba, ra, action_failure)
				test_once (action_developer, ba, ra, action_developer)
				test_once (action_system, ba, ra, action_system)

					-- Adjust expected exception if required
				a := ea
				if
					$RAISES_RESCUE_EXCEPTION and then
					ba /= action_nothing and then
					ra /= action_nothing
				then
						-- Exceptions in rescue are obselete
					a := ra
				end

					-- Run real test
				test_once (action_nothing, ba, ra, a)

					-- Next runs should not change result
				from
					i := action_first
				until
					i > action_last
				loop
					from
						j := action_first
					until
						j > action_last
					loop
						test_once (action_nothing, i, j, a)
						j := j + 1
					end
					i := i + 1
				end
		
					-- Precondition violation should not depend
					-- on final result of once routine
				test_once (action_precondition, ba, ra, action_precondition)
				test_once (action_failure, ba, ra, action_failure)
				test_once (action_developer, ba, ra, action_developer)
				test_once (action_system, ba, ra, action_system)
			end
		end

feature {NONE} -- Output

	report_test_result (actual_action: INTEGER) is
			-- Report whether actual result matches an expected one.
		do
			if actual_action /= expected_action then
				if not is_failed then
					io.put_string ("Test " + name + ": FAILED")
					io.put_new_line
					is_failed := true
				end
				io.put_character ('%T')
				if precondition_action /= action_nothing then
					io.put_string ("Precondition: ")
					io.put_string (action_name (precondition_action))
					io.put_string (" ")
				end
				io.put_string ("Expected: ")
				io.put_string (action_name (expected_action))
				io.put_string (" but got: ")
				io.put_string (action_name (actual_action))
				io.put_new_line
			end
		end

	action_name (a: INTEGER): STRING is
			-- Name of the action `a'
		do
			inspect a
			when action_nothing      then Result := "No exception"
			when action_exception    then Result := "Exception"
			when action_assertion    then Result := "Assertion violation"
			when action_precondition then Result := "Precondition violation"
			when action_failure      then Result := "Routine failure"
			when action_developer    then Result := "Developer exception"
			when action_system       then Result := "System/signal/hardware exception"
			else                          Result := "Unknown result %"" + a.out + "%""
			end
		end

feature {NONE} -- Status

	is_failed: BOOLEAN
			-- Has this test failed?

	is_process_relative: BOOLEAN is $IS_PROCESS_RELATIVE
			-- Is once feature `item' process-relative?

feature {NONE} -- Constants

	action_first: INTEGER is 1
			-- First action number

	action_nothing: INTEGER is 1
			-- No exception

	action_exception: INTEGER is 2
			-- Any exception

	action_assertion: INTEGER is 3
			-- Any assertion violation

	action_precondition: INTEGER is 4
			-- Precondition violation

	action_failure: INTEGER is 5
			-- Routine failure

	action_developer: INTEGER is 6
			-- Developer exception

	action_system: INTEGER is 7
			-- System/signal/hardware exception

	action_last: INTEGER is 7
			-- Last action number

feature {NONE} -- Test data

	name: STRING
			-- Test name

	precondition_action: INTEGER
			-- Action to be performed in precondition

	body_action: INTEGER
			-- Action to be performed in body

	rescue_action: INTEGER
			-- Action to be performed in rescue

	expected_action: INTEGER
			-- Expected action of once feature

feature {NONE} -- Tests

	test_once (pa: INTEGER; ba: INTEGER; ra: INTEGER; a: INTEGER) is
			-- Test that once feature `item' called in
			-- conditions specified by `pa', `ba' and `ra'
			-- behaves according `a'.
		do
			precondition_action := pa
			body_action := ba
			rescue_action := ra
			expected_action := a
			if is_process_relative then
				launch
				join_all
			else
				execute
			end
		end

	execute is
			-- Call once routine and test its result.
		local
			retried: BOOLEAN
			actual_action: INTEGER
			e: INTEGER
		do
			if
				not has_assertions and then
				(precondition_action /= action_nothing or else
				expected_action = action_precondition)
			then
					-- Assertion violation is expected,
					-- but assertions are not monitored:
					-- report success.
				actual_action := expected_action
			else
				if retried then
					e := exceptions.exception
					if e = exceptions.Precondition then
						actual_action := action_precondition
					elseif e = exceptions.Routine_failure then
						actual_action := action_failure
					elseif e = exceptions.Developer_exception then
						actual_action := action_developer
					elseif
						e = exceptions.Check_instruction or else
						e = exceptions.Class_invariant or else
						e = exceptions.Loop_invariant or else
						e = exceptions.Loop_variant or else
						e = exceptions.Postcondition
					then
						actual_action := action_assertion
					elseif
						e = exceptions.Signal_exception or else
						e = exceptions.External_exception or else
						e = exceptions.Operating_system_exception or else
						e = exceptions.Floating_point_exception
					then
						actual_action := action_system
					else
						actual_action := action_exception
					end
				else
					actual_action := item (body_action)
				end
			end
			report_test_result (actual_action)
		rescue
			retried := true
			retry
		end

feature {NONE} -- Once routine and rescue handlers

	item (value: INTEGER): INTEGER is
			-- Once feature that returns `value' passed
			-- in the first call to it unless there is an exception
		indexing
			once_status: "$ONCE_STATUS"
		require
			precondition_action = action_precondition implies false
			precondition_action = action_failure implies failed
			precondition_action = action_developer implies helper.raised ("precondition")
			precondition_action = action_system implies (1 // (value - value)) = 0
		once
				-- Set result to non-default value
			Result := Result - 1
				-- Raise exception if required
			inspect body_action
			when action_nothing   then
			when action_assertion then check false end
			when action_developer then exceptions.raise ("body")
			when action_system    then (1 // (value - value)).do_nothing
			end
				-- Set final result to `value'
			Result := Result + value + 1
		$RESCUE_START
			inspect rescue_action
			when action_nothing   then
			when action_assertion then check false end
			when action_developer then exceptions.raise ("rescue")
			when action_system    then (1 // (value - value)).do_nothing
			end
		$RESCUE_STOP
		end

	default_rescue is
			-- Behave according to `rescue_action'.
		do
			inspect rescue_action
			when action_nothing   then
			when action_assertion then check false end
			when action_developer then exceptions.raise ("default_rescue")
			when action_system    then (1 // (rescue_action - rescue_action)).do_nothing
			end
		end

feature {NONE} -- Helper functions

	failed: BOOLEAN is
			-- A function that fails
		local
			x: INTEGER
		do
			x := x // x
		rescue
			-- No "retry": cause routine to fail
		end

	exceptions: EXCEPTIONS is
			-- An instance of a class EXCEPTIONS
		once
			create Result
		ensure
			Result /= Void
		end

	helper: TEST_HELPER is
			-- An instance of a class TEST_HELPER
		once
			create Result
		ensure
			Result /= Void
		end

end