indexing
	description: "[
		Represents an outcome of TEST_I, which can be either pass, fail
		or unresolved. Unresolved describes the situation in which
		it could not be determined whether a test passed or failed.	
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_OUTCOME_I

feature -- Status report

	is_pass: BOOLEAN
			-- Did the implementation under test pass the test?
		deferred
		end

	is_fail: BOOLEAN
			-- Did the implementation under test fail the test?
		deferred
		end

	is_unresolved: BOOLEAN
			-- Is the test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		ensure
			definition: Result = not (is_pass or is_fail)
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

end
