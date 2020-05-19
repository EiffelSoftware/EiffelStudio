note
	description: "[
		Test result from an execution where setup was exceptional
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_PARTIAL_RESULT

inherit
	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	make

feature {NONE} -- Initialization

	make (a_start_date: like start_date; a_setup_response: attached like setup_response; an_output: READABLE_STRING_8)
			-- Initialize `Current' with exceptional setup response.
			--
			-- `a_start_date': Date/time when test was launched.
			-- `a_setup_response': Response from setup stage.
			-- `an_output': Output gathered during test execution.
		require
			a_setup_response_attached: a_setup_response /= Void
			an_output_attached: an_output /= Void
		do
			start_date := a_start_date
			setup_response := a_setup_response
			create output.make_from_string (an_output)
			create finish_date.make_now
		ensure
			start_date_set: start_date = a_start_date
			setup_response_set: setup_response = a_setup_response
			output_set: output.same_string (an_output)
		end

feature -- Access

	start_date: DATE_TIME
			-- Date/time when test was launched

	finish_date: DATE_TIME
			-- Date and time when `Current' was obtained

	frozen duration: DATE_TIME_DURATION
			-- Duration of test execution
		do
			Result := finish_date.relative_duration (start_date)
		ensure
			result_attached: Result /= Void
		end

	setup_response: EQA_TEST_INVOCATION_RESPONSE
			-- Response from setup stage

	output: IMMUTABLE_STRING_8
			-- More detailed information regarding the test result

	tag: READABLE_STRING_32
			-- Short tag describing status of `Current'
		do
			if attached setup_response.exception as l_exception then
				Result := l_exception.tag_name
			else
				create {STRING_32} Result.make_empty
			end
		end

feature -- Status report

	is_pass: BOOLEAN
			-- Did test pass?
		do
		end

	is_fail: BOOLEAN
			-- Did test fail?
		do
		end

	is_unresolved: BOOLEAN
			-- Is test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		ensure
			definition: Result = not (is_pass or is_fail)
		end

	is_maintenance_required: BOOLEAN
			-- Does the test need to be fixed?
		do
			Result := True
		ensure
			unresolved_implies_result: is_unresolved implies Result
		end

feature -- Mismatch correction

	correct_mismatch
			-- <Precursor>
		do
			if attached {like output} mismatch_information.item (output_name) as l_output then
				create output.make_from_string (l_output)
			else
				Precursor
			end
		end

feature {NONE} -- Constants

	output_name: STRING_8 = "output"

invariant
	pass_or_fail_or_unresolved: is_pass or is_fail or is_unresolved

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
