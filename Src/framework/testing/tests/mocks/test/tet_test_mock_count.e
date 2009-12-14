note
	description: "[
		{TET_TEST_MOCK} that simply counts to some number in each call to `step' before providing a
		test result.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TET_TEST_MOCK_COUNT

inherit
	TET_TEST_MOCK

feature {NONE} -- Access

	execution_steps: NATURAL = 100

	execution_counter: NATURAL

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := 0 < execution_counter and execution_counter < execution_steps
		end

	is_aborted: BOOLEAN
		do
			Result := not has_next_step and 0 < execution_counter
		end

feature -- Status setting

	step
			-- <Precursor>
		do
			execution_counter := execution_counter + 1
			if not has_next_step then
				create {EQA_EMPTY_RESULT} last_result.make ("dummy", "")
				execution_counter := 0
			end
		end

	cancel
			-- <Precursor>
		do
			execution_counter := execution_steps
		end

feature {TET_EXECUTOR_MOCK} -- Status setting

	start
			-- Start the execution of `Current'
		do
			execution_counter := 1
		end

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
