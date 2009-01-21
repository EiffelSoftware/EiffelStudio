note
	description: "[
		Executor that runs tests in the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_DEBUGGER_I

inherit
	TEST_EXECUTOR_I
		redefine
			is_valid_typed_configuration
		end

feature {NONE} -- Query

	is_valid_typed_configuration (a_conf: like conf_type): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_valid_evaluator_count: Result implies a_conf.evaluator_count = 1
		end


end
