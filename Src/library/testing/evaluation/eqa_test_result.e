note
	description: "[
		Responce produced from executing an Eiffel test
		
		TEST_OUTCOME holds information about the tree stages each test execution consists of: setup, test
		and teardown. Based on that information it tries to determine whether the implementation passes
		or fails the test. If an unexpected error occurred during execution, it will blame the test by
		setting `is_maintenance_required' to True. Somethimes the error prevents to determine wheter the
		implementaion has passed or failed the test. In that case a outcome is said to be unresolved.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_RESULT

create
	make, make_with_setup, make_without_response

feature {NONE} -- Initialization

	make_without_response (a_date: like date; a_is_user_abort: like is_user_abort)
			-- Initialize `Current' without any responses.
			--
			-- `a_date': Date when outcome was produced.
			-- `a_is_user_abort': Are the responces missing due to user abort?
		require
			a_date_attached: a_date /= Void
		do
			date_cache := a_date
			time_since_epoche := date.relative_duration (create {DATE_TIME}.make (1970, 1, 1, 0, 0, 0)).seconds_count.as_integer_32
			is_user_abort := a_is_user_abort
		ensure
			date_set: a_date = date
			is_user_abort_set: is_user_abort = a_is_user_abort
			no_response: not has_response
		end

	make_with_setup (a_setup_response: attached like setup_response; a_date: like date)
			-- Initialize `Current' with exceptional setup response.
			--
		require
			a_setup_response_exceptional: a_setup_response.is_exceptional
			a_date_attached: a_date /= Void
		do
			make_without_response (a_date, False)
			setup_response := a_setup_response
		ensure
			date_set: a_date = date
			has_response: has_response
			setup_exceptional: not is_setup_clean
		end

	make (a_setup_response: attached like setup_response; a_test_response: attached like test_response;
	      a_teardown_response: attached like teardown_response; a_date: like date)
			-- Initialize `Current' with responses for all three stages.
		require
			a_setup_response_clean: not a_setup_response.is_exceptional
			a_date_attached: a_date /= Void
		do
			make_with_setup (a_setup_response, a_date)
			test_response := a_test_response
			teardown_response := a_teardown_response
		ensure
			date_set: a_date = date
			has_response: has_response
			setup_clean: is_setup_clean
		end

feature -- Access

	date: DATE_TIME
			-- Date and time `Current' was retrieved
			--
			-- Note: the date can not be stored as attached, since it is currently not possible to pass
			--       objects of type {DATE_TIME} between void-safe systems and ones which are not.
		local
			l_cache: like date_cache
		do
			l_cache := date_cache
			if l_cache = Void then
				create l_cache.make_from_epoch (time_since_epoche)
				date_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

	setup_response: detachable EQA_TEST_INVOCATION_RESPONSE
			-- Response from setup stage

	test_response: detachable EQA_TEST_INVOCATION_RESPONSE
			-- Response from test stage

	teardown_response: detachable EQA_TEST_INVOCATION_RESPONSE
			-- Response from teardown stage

feature {NONE} -- Access

	time_since_epoche: INTEGER_32
			-- Number of seconds since epoche for `date'

	date_cache: detachable like date
			-- Cache for `date'

feature -- Status report

	is_pass: BOOLEAN
			-- <Precursor>
		local
			l_response: like test_response
		do
			if is_setup_clean then
				l_response := test_response
				check l_response /= Void end
				Result := not l_response.is_exceptional
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			result_implies_clean_test_response: Result implies not
				(attached test_response as l_tr and then l_tr.is_exceptional)
		end

	is_fail: BOOLEAN
			-- <Precursor>
		local
			l_response: like test_response
		do
			if is_test_response_valid then
				l_response := test_response
				check l_response /= Void end
				Result := l_response.is_exceptional
			end
		ensure
			result_implies_valid_test_response: Result implies is_test_response_valid
			result_implies_test_response_exceptional: Result implies
				(attached  test_response as l_tr and then l_tr.is_exceptional)
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
				Result := {EQA_TEST_RESULT_STATUS_TYPES}.passed
			elseif is_fail then
				Result := {EQA_TEST_RESULT_STATUS_TYPES}.failed
			else
				Result := {EQA_TEST_RESULT_STATUS_TYPES}.unresolved
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

	is_user_abort: BOOLEAN
			-- Are the responces missing due to user abort?

	is_setup_clean: BOOLEAN
			-- Does `Current' contain a test stage response?
		local
			l_response: like setup_response
		do
			if has_response then
				l_response := setup_response
				check l_response /= Void end
				Result := not l_response.is_exceptional
			end
		ensure
			result_implies_has_response: Result implies has_response
			result_implies_clean_setup: Result implies
				(attached setup_response as l_sr and then not l_sr.is_exceptional)
		end

	is_test_response_valid: BOOLEAN
			-- Is test response valid?
			--
			-- Note: the test response is valid if setup stage was not exceptional and no precondition
			--       violation occured which was caused by a call from TEST_INTERPRETER or any (!) call
			--       from an agent.
		local
			l_response: like test_response
		do
			if is_setup_clean then
				l_response := test_response
				check l_response /= Void end
				Result := not l_response.is_exceptional or else not l_response.exception.is_test_invalid
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			definition: Result implies (attached test_response as l_tr and then
				(not l_tr.is_exceptional or else l_tr.exception.is_test_invalid))
		end

	is_teardown_clean: BOOLEAN
			-- Is tear down
		local
			l_response: like teardown_response
		do
			if is_setup_clean then
				l_response := teardown_response
				check l_response /= Void end
				Result := not l_response.is_exceptional
			end
		ensure
			result_implies_clean_setup: Result implies is_setup_clean
			result_implies_clean_teardown: Result implies
				(attached teardown_response as l_tr and then l_tr.is_exceptional)
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

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
