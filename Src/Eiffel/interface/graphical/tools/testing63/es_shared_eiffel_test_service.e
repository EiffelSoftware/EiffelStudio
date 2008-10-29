indexing
	description: "[
		Shared access to testing facilities.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_EIFFEL_TEST_SERVICE

inherit
	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_class_removed
		end

feature {NONE} -- Access

	frozen test_suite: !SERVICE_CONSUMER [EIFFEL_TEST_SUITE_S]
			-- Access to a test suite service {EIFFEL_TEST_SUITE_S} consumer
		once
			manager.add_observer (Current)
			create Result
		end

	background_executor_type: !TYPE [EIFFEL_TEST_BACKGROUND_EXECUTOR_I]
			-- Type for executor used to execute tests in background
		do
			Result := {EIFFEL_TEST_BACKGROUND_EXECUTOR_I}
		end

	debug_executor_type: !TYPE [EIFFEL_TEST_DEBUGGER_I]
			-- Type for executor that runs tests in the debugger
		do
			Result := {EIFFEL_TEST_DEBUGGER_I}
		end

	extractor_factory_type: !TYPE [EIFFEL_TEST_EXTRACTOR_I]
			-- Factory type for test case extraction
		do
			Result := {EIFFEL_TEST_EXTRACTOR_I}
		end

	manual_factory_type: !TYPE [EIFFEL_TEST_FACTORY_I]
			-- Type for manual test creation
		do
			Result := {EIFFEL_TEST_FACTORY_I}
		end

feature {NONE} -- Events

	on_class_removed (a_class: CLASS_I)
			-- <Precursor>
		do
			if {l_class: !EIFFEL_CLASS_I} a_class and then test_suite.is_service_available then
				test_suite.service.synchronize_with_class (l_class)
			end
		end

end
