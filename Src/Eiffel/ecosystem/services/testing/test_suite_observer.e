indexing
	description: "[
		Observer for events in {TEST_SUITE_S}	
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SUITE_OBSERVER

inherit
	TEST_COLLECTION_OBSERVER

feature {TEST_SUITE_S} -- Events

	on_executor_activated (a_test_suite: !TEST_SUITE_S)
			-- Called when `a_test_suite' activates an executor.
		require
			interface_usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_suite_has_active_executor: a_test_suite.has_active_executor
		do
		end

	on_executor_deactivated (a_test_suite: !TEST_SUITE_S; a_executor: !TEST_EXECUTOR_I)
			-- Called when `a_test_suite' deactivates `a_executor'.
		require
			interface_usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			not_a_test_suite_has_active_executor: not a_test_suite.has_active_executor
			not_a_executor_running: not a_executor.is_running
		do
		end

end
