indexing
	description: "[
		Represents the result from executing one of the stages in an eiffel test.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_INVOCATION_RESPONSE

create
	make_normal, make_exceptional

feature {NONE} -- Initialization

	make_normal (an_output: like output) is
			-- Create new normal response.
		do
			output := an_output
		ensure
			output_set: output = an_output
			not_exceptional: not is_exceptional
		end

	make_exceptional (an_output: like output; an_exception: like exception) is
			-- Create new exceptional response.
		do
			output := an_output
			internal_exception := an_exception
		ensure
			output_set: output = an_output
			exceptional: is_exceptional
			exception_set: exception = an_exception
		end

feature -- Query

	is_exceptional: BOOLEAN
			-- Has an exception been thrown during the execution?
		do
			Result := internal_exception /= Void
		end

feature -- Access

	exception: !EQA_TEST_INVOCATION_EXCEPTION
			-- Exception thrown during the execution
		require
			exceptional: is_exceptional
		do
			Result := internal_exception.as_attached
		end

	output: !STRING
			-- Output produced by test

feature {NONE} -- Access

	internal_exception: ?like exception
			-- Internal storage for `exception'

end
