indexing
	description: "[
		Represents the result from executing one of the stages in
		an eiffel test.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_ROUTINE_INVOCATION_RESPONSE_I

feature -- Query

	is_normal: BOOLEAN
			-- Was the execution successful? (I.e. no exception has been thrown)
		do
			Result := not (is_bad or is_exceptional)
		ensure
			definition: Result = not (is_bad or is_exceptional)
		end

	is_bad: BOOLEAN
			-- Was the response gotten not in the expected format?
		deferred
		ensure
			result_implies_not_exceptional: Result implies not is_exceptional
		end

	is_exceptional: BOOLEAN
			-- Has an exception been thrown during the execution?
		deferred
		end

	has_been_aborted: BOOLEAN
			-- Has the execution been aborted?
		deferred
		ensure
			result_implies_is_bad: Result implies is_bad
		end

feature -- Access

	exception: EIFFEL_TEST_ROUTINE_INVOCATION_EXCEPTION_I
			-- Exception thrown during the execution
		require
			exceptional: is_exceptional
		deferred
		end

	output: !STRING
			-- Output produced by test
		deferred
		end


end
