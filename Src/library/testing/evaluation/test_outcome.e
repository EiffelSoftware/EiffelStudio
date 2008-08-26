indexing
	description: "[
		Responce produced from executing an eiffel test
		
		TEST_OUTCOME holds information about the tree stages each test execution consists of: setup, test
		and teardown. Based on that information it tries to determine whether the implementation passes
		or fails the test. If an unexpected error occurred during execution, it will blame the test by
		setting `is_maintenance_required' to True. Somethimes the error prevents to determine wheter the
		implementaion has passed or failed the test. In that case a outcome is said to be unresolved.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OUTCOME

create
	make, make_with_setup, make_without_response

feature {NONE} -- Initialization

	make_without_response (a_date: like date)
			-- Initialize `Current' without any responses.
		do
			date := a_date
		ensure
			date_set: a_date = date
			not_response: not has_response
		end

	make_with_setup (a_setup_response: like setup_response; a_date: like date)
			-- Initialize `Current' with exceptional setup response.
			--
		require
			a_setup_response_exceptional: a_setup_response.is_exceptional
		do
			date := a_date
			setup_response := a_setup_response
		ensure
			has_response: has_response
			setup_exceptional: not is_setup_clean
		end

	make (a_setup_response: like setup_response; a_test_response: like test_response;
	      a_teardown_response: like teardown_response; a_date: like date) is
			-- Initialize `Current' with responses for all three stages.
		require
			a_setup_response_clean: not a_setup_response.is_exceptional
		do
			date := a_date
			setup_response := a_setup_response
			test_response := a_test_response
			teardown_response := a_teardown_response
		ensure
			has_response: has_response
			setup_clean: is_setup_clean
		end

feature -- Access

	date: !DATE_TIME
			-- Date and time `Current' was retrieved

	setup_response: ?TEST_INVOCATION_RESPONSE
			-- Response from setup stage

	test_response: ?TEST_INVOCATION_RESPONSE
			-- Response from test stage

	teardown_response: ?TEST_INVOCATION_RESPONSE
			-- Response from teardown stage

feature -- Status report

	is_pass: BOOLEAN
			-- <Precursor>
		do
			if is_setup_clean then
				Result := not test_response.is_exceptional
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			result_implies_clean_test_response: Result implies test_response.is_exceptional
		end

	is_fail: BOOLEAN
			-- <Precursor>
		do
			if is_test_response_valid then
				Result := test_response.is_exceptional
			end
		ensure
			result_implies_valid_test_response: Result implies is_test_response_valid
			result_implies_test_response_exceptional: Result implies test_response.is_exceptional
		end

	is_unresolved: BOOLEAN
			-- Is the test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		ensure
			definition: Result = not (is_pass or is_fail)
			result_implies_maintainance_required: Result implies is_maintenance_required
		end

	status: NATURAL_8
			-- Status indicating status of `is_pass', `is_fail' and `is_unresolved'
		do
			if is_pass then
				Result := {TEST_OUTCOME_STATUS_TYPES}.passed
			elseif is_fail then
				Result := {TEST_OUTCOME_STATUS_TYPES}.failed
			else
				Result := {TEST_OUTCOME_STATUS_TYPES}.unresolved
			end
		end

	is_maintenance_required: BOOLEAN
			-- Does the test need to be fixed?
		do
			Result := not (is_test_response_valid and is_teardown_clean)
		ensure
			test_response_invalid_implies_result: not is_test_response_valid implies Result
			teardown_exceptional_implies_result: not is_teardown_clean implies Result
		end

	has_response: BOOLEAN
			-- Does outcome contain any response?
			--
			-- Note: if this is not the case, it ususaly means the test through an exception from which the
			--       evaluator was not able to recover from.
		do
			Result := setup_response /= Void
		ensure
			result_implies_setup_response_attached: Result implies (setup_response /= Void)
		end

	is_setup_clean: BOOLEAN
			-- Does `Current' contain a test stage response?
		do
			if has_response then
				Result := not setup_response.is_exceptional
			end
		ensure
			result_implies_has_response: Result implies has_response
			result_implies_clean_setup: Result implies not setup_response.is_exceptional
		end

	is_test_response_valid: BOOLEAN
			-- Is test response valid?
			--
			-- Note: the test response is valid if setup stage was not exceptional and no precondition
			--       violation occured which was caused by a call from TEST_INTERPRETER or any (!) call
			--       from an agent.
		do
			if is_setup_clean then
				Result := not test_response.is_exceptional or else (test_response.exception.trace_depth > 1 or
					test_response.exception.code /= test_response.exception.precondition)
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			definition: Result implies (not test_response.is_exceptional or else (test_response.exception.trace_depth > 1 or
					test_response.exception.code /= test_response.exception.precondition))
		end

	is_teardown_clean: BOOLEAN
			-- Is tear down
		do
			if is_setup_clean then
				Result := not teardown_response.is_exceptional
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			result_implies_clean_teardown: Result implies not teardown_response.is_exceptional
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
	setup_clean_implies_test_response_attached: is_setup_clean implies test_response /= Void
	setup_clean_implies_teardown_response_attached: is_setup_clean implies teardown_response /= Void

end
