indexing
	description: "[
		Responce produced from executing an eiffel test
		
		TEST_EXECUTION_RESPONCE_I holds information about the tree stages each test execution
		consists of: setup, test and teardown. Based on that information it tries to determine
		whether the implementation passes or fails the test. If an unexpected error occurred
		during execution, it will blame the test by setting `is_maintenance_required' to True.
		Somethimes the error prevents to determine wheter the implementaion has passed or
		failed the test. In that case a outcome is said to be unresolved.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_OUTCOME_I

feature -- Access

	date: !DATE_TIME
			-- Date and time `Current' was retrieved
		deferred
		end

	setup_response: EIFFEL_TEST_ROUTINE_INVOCATION_RESPONSE_I
			-- Response from setup stage
		deferred
		end

	test_response: EIFFEL_TEST_ROUTINE_INVOCATION_RESPONSE_I
			-- Response from test stage
		deferred
		end

	teardown_response: EIFFEL_TEST_ROUTINE_INVOCATION_RESPONSE_I
			-- Response from teardown stage
		deferred
		end

feature -- Status report

	is_pass: BOOLEAN
			-- <Precursor>
		do
			Result := test_response /= Void and then test_response.is_normal
		end

	is_fail: BOOLEAN
			-- <Precursor>
		do
			Result := test_response /= Void and then
				(test_response.is_exceptional and not has_bad_context)
		end

	is_unresolved: BOOLEAN
			-- Is the test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		end

	status: NATURAL_8
			-- Status indicating status of `is_pass', `is_fail' and `is_unresolved'
		do
			if is_pass then
				Result := {EIFFEL_TEST_OUTCOME_STATUS_TYPES}.passed
			elseif is_fail then
				Result := {EIFFEL_TEST_OUTCOME_STATUS_TYPES}.failed
			else
				Result := {EIFFEL_TEST_OUTCOME_STATUS_TYPES}.unresolved
			end
		end

	is_maintenance_required: BOOLEAN
			-- Does the test need to be fixed?
		do
			Result := has_compile_error or has_bad_communication or has_bad_context
		end

	has_bad_context: BOOLEAN
			-- Does the test case seem to have an invalid context?
			--
			-- (This is the case when an exception was raised during setup)
		do
			if not has_compile_error then
				if setup_response.is_normal then
					if test_response.is_exceptional then
						Result := test_response.exception.trace_depth = 1 and then
							test_response.exception.code = test_response.exception.precondition
					end
				else
					Result := setup_response.is_exceptional
				end
			end
		end

	has_compile_error: BOOLEAN
			-- Did the test produce a compiler error?
		do
			Result := setup_response = Void
		ensure
			definition: Result = (setup_response = Void)
		end

	has_bad_communication: BOOLEAN
			-- Did a communication error occur during execution?
		do
			if not has_compile_error then
				if setup_response.is_normal then
					if test_response.is_normal then
						Result := teardown_response.is_bad
					else
						Result := test_response.is_bad
					end
				else
					Result := setup_response.is_bad
				end
			end
		end

	has_been_aborted: BOOLEAN
			-- Has the test execution been aborted?
			-- (Could have been aborted by the user or a time out)
		do
			if has_compile_error then
				if setup_response.is_normal then
					if test_response.is_normal then
						Result := teardown_response.has_been_aborted
					else
						Result := test_response.has_been_aborted
					end
				else
					Result := setup_response.has_been_aborted
				end
			end
		ensure
			result_implies_bad_communication: Result implies has_bad_communication
		end

feature {NONE} -- Implementation

	one_of (a: BOOLEAN; b: BOOLEAN; c: BOOLEAN): BOOLEAN
		-- Is exactly one out of the three variables `a', `b', `c' true?
		do
			Result := (a xor b xor c) and not (a and b and c)
		ensure
			definition: (a xor b xor c) and not (a and b and c)
		end

invariant
	one_of_pass_fail_unresolved: one_of (is_pass, is_fail, is_unresolved)
	setup_normal_equals_test_not_void: (setup_response /= Void and then setup_response.is_normal) = (test_response /= Void)
	test_not_bad_equals_teardown_not_void: (test_response /= Void and then test_response.is_normal) = (teardown_response /= Void)
	unresolved_implies_maintenance: is_unresolved implies is_maintenance_required
	maintenance_implies_one_error: one_of (has_bad_context, has_compile_error, has_bad_communication)
	no_maintenance_implies_no_error: (not is_maintenance_required) implies not (has_bad_context or has_compile_error or has_bad_communication)

end
