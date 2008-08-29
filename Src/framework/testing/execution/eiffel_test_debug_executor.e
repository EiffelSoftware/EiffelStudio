indexing
	description: "[
		Executor running tests in the debugger
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_DEBUG_EXECUTOR

inherit
	EIFFEL_TEST_EXECUTOR

feature {NONE} -- Factory

	create_evaluator: !EIFFEL_TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		do
			create {EIFFEL_TEST_DEBUG_EVALUATOR_CONTROLLER} Result.make (map)
		end

end
