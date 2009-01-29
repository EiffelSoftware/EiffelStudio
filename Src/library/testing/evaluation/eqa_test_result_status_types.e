note
	description: "[
		Type flags used by {TEST_OUTCOME_I} to indicate the outcome of a {TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_RESULT_STATUS_TYPES

feature -- Access

	passed: NATURAL_8 = 1
			-- Implementation passed last test execution

	failed: NATURAL_8 = 2
			-- Implementation failed last test execution

	unresolved: NATURAL_8 = 3
			-- Last test response was unresolvable

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
