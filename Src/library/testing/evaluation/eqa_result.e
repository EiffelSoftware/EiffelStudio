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
	EQA_RESULT

inherit
	EQA_PARTIAL_RESULT
		rename
			make as make_result
		redefine
			is_pass,
			is_fail,
			is_maintenance_required,
			tag
		end

create
	make

feature {NONE} -- Initialization

	make (a_start_date: like start_date;
	      a_setup_response: attached like setup_response;
	      a_test_response: attached like test_response;
	      a_teardown_response: attached like teardown_response;
	      an_output: READABLE_STRING_8)
			-- Initialize `Current' with responses for all three stages.
		require
			a_setup_response_attached: a_setup_response /= Void
			a_test_response_attached: a_test_response /= Void
			a_teardown_response_attached: a_teardown_response /= Void
			an_output_attached: an_output /= Void
			a_setup_response_clean: not a_setup_response.is_exceptional
		do
			make_result (a_start_date, a_setup_response, an_output)
			setup_response := a_setup_response
			test_response := a_test_response
			teardown_response := a_teardown_response
		ensure
			setup_response_set: setup_response = a_setup_response
			test_response_set: test_response = a_test_response
			teardown_response_set: teardown_response = a_teardown_response
			output_set: output.same_string (an_output)
		end

feature -- Access

	test_response: EQA_TEST_INVOCATION_RESPONSE
			-- Response from test stage

	teardown_response: EQA_TEST_INVOCATION_RESPONSE
			-- Response from teardown stage

	tag: READABLE_STRING_8
			-- If available, short tag describing stats of `Current'
		do
			if test_response.is_exceptional then
				Result := test_response.exception.tag_name
			elseif teardown_response.is_exceptional then
				Result := teardown_response.exception.tag_name
			else
				Result := Precursor
			end
		end

feature -- Status report

	is_pass: BOOLEAN
			-- <Precursor>
		do
			Result := not test_response.is_exceptional
		ensure then
			result_implies_clean_test_response: Result implies not test_response.is_exceptional
		end

	is_fail: BOOLEAN
			-- <Precursor>
		do
			if is_test_response_valid then
				Result := test_response.is_exceptional
			end
		ensure then
			result_implies_valid_test_response: Result implies is_test_response_valid
			result_implies_test_response_exceptional: Result implies test_response.is_exceptional
		end

	is_maintenance_required: BOOLEAN
			-- <Precursor>
		do
			Result := test_response.is_exceptional or not is_test_response_valid
		ensure then
			test_response_invalid_implies_result: not is_test_response_valid implies Result
			teardown_exceptional_implies_result: test_response.is_exceptional implies Result
		end

	is_test_response_valid: BOOLEAN
			-- Is test response valid?
			--
			-- Note: the test response is valid if setup stage was not exceptional and no precondition
			--       violation occured which was caused by a call from TEST_INTERPRETER or any (!) call
			--       from an agent.
		do
			Result := not test_response.is_exceptional or else not test_response.exception.is_test_invalid
		ensure
			definition: Result implies (not test_response.is_exceptional or else not test_response.exception.is_test_invalid)
		end

invariant
	setup_clean: not setup_response.is_exceptional

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
