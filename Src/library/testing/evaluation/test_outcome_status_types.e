indexing
	description: "[
		Type flags used by {TEST_OUTCOME_I} to indicate the outcome of a {TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OUTCOME_STATUS_TYPES

feature -- Access

	passed: NATURAL_8 = 1
			-- Implementation passed last test execution

	failed: NATURAL_8 = 2
			-- Implementation failed last test execution

	unresolved: NATURAL_8 = 3
			-- Last test response was unresolvable

end
