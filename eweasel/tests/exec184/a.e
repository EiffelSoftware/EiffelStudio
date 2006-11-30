class A [G]

feature -- Access

	s: STRING is
			-- Result is a once manifest string
		require
			precondition_tester.test (once "pre")
		do
			Result := once "abc"
		ensure
			postcondition_tester.test (once "post")
			old old_expression_tester1.test (once "old1")
			old_expression_tester2.test (old once "old2")
		end

feature -- Assertion testers

	invariant_tester: ASSERTION_TESTER is
			-- Testes for class invariant
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	precondition_tester: ASSERTION_TESTER is
			-- Tester for precondition
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	postcondition_tester: ASSERTION_TESTER is
			-- Tester for postcondition
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	old_expression_tester1: ASSERTION_TESTER is
			-- Tester for old expression
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	old_expression_tester2: ASSERTION_TESTER is
			-- Tester for old expression
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

invariant

	invariant_tester.test (once "inv")

end