note
	description: "[
		Test result from an execution where setup was exceptional
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_ETEST_PARTIAL_RESULT

inherit
	EQA_RESULT
		rename
			information as output
		end

	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	make

feature {NONE} -- Initialization

	make (a_setup_response: attached like setup_response; an_output: READABLE_STRING_8)
			-- Initialize `Current' with exceptional setup response.
		require
			a_setup_response_attached: a_setup_response /= Void
			an_output_attached: an_output /= Void
		do
			setup_response := a_setup_response
			create output.make_from_string (an_output)
			create date.make_now
		ensure
			setup_response_set: setup_response = a_setup_response
			output_set: output.same_string (an_output)
		end

feature -- Access

	date: DATE_TIME
			-- <Precursor>

	setup_response: EQA_TEST_INVOCATION_RESPONSE
			-- Response from setup stage

	output: IMMUTABLE_STRING_8
			-- <Precursor>

	tag: READABLE_STRING_8
			-- <Precursor>
		local
			l_exception: EQA_TEST_INVOCATION_EXCEPTION
		do
			if setup_response.is_exceptional then
				l_exception := setup_response.exception
				Result := l_exception.tag_name
			else
				Result := ""
			end
		end

feature -- Status report

	is_pass: BOOLEAN
			-- <Precursor>
		do
		end

	is_fail: BOOLEAN
			-- <Precursor>
		do
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
				output := create {STRING}.make_from_string (l_output)
			else
				Precursor
			end
		end

feature {NONE} -- Constants

	output_name: STRING = "output"

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
