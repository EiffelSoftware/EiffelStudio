indexing
	description: "[
		Shared access to testing facilities.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_EIFFEL_TEST_SERVICE


feature {NONE} -- Access

	frozen test_suite: !SERVICE_CONSUMER [!EIFFEL_TEST_SUITE_S]
			-- Access to a test suite service {EIFFEL_TEST_SUITE_S} consumer
		once
			create Result
		end

	background_executor_type: !TYPE [EIFFEL_TEST_BACKGROUND_EXECUTOR_I]
			-- Type for executor used to execute tests in background
		do
			Result ?= {EIFFEL_TEST_BACKGROUND_EXECUTOR_I}
		end

	debug_executor_type: !TYPE [EIFFEL_TEST_DEBUGGER_I]
			-- Type for executor that runs tests in the debugger
		do
			Result ?= {EIFFEL_TEST_DEBUGGER_I}
		end

end
