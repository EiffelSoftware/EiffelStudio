indexing
	description: "[
		Objects that provide common functionality needed for implementations of {EIFFEL_TEST_PROCESSOR_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR

inherit
	EIFFEL_TEST_PROCESSOR_I

	EIFFEL_TEST_COLLECTION
		rename
			are_tests_available as is_test_suite_valid
		undefine
			events
		end

	EIFFEL_TEST_SUITE_OBSERVER
		redefine
			on_test_changed
		end

feature -- Access

	test_suite: !EIFFEL_TEST_SUITE_S
			-- <Precursor>
		do
			Result ?= internal_test_suite
		end

feature {NONE} -- Access

	internal_test_suite: ?like test_suite
			-- Internal storage for `test_suite'

feature -- Status report

	is_test_suite_valid: BOOLEAN
			-- <Precursor>
		do
			Result := internal_test_suite /= Void and then
			          internal_test_suite.is_interface_usable and then
			          internal_test_suite.is_project_initialized
		end

	is_idle: BOOLEAN
			-- <Precursor>

	is_stop_requested: BOOLEAN
			-- <Precursor>

feature -- Status setting

	request_stop is
			-- <Precursor>
		do
			is_stop_requested := True
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	frozen proceed is
			-- <Precursor>
		do
			is_idle := False
			proceed_process
			is_idle := True
		end

	frozen stop is
			-- <Precursor>
		do
			stop_process
			is_idle := False
			is_stop_requested := False
		end

feature {NONE} -- Status setting

	attach_test_suite (a_test_suite: like test_suite)
			-- <Precursor>
		do
			if internal_test_suite /= Void then
				internal_test_suite.disconnect_events (Current)
			end
			internal_test_suite := a_test_suite
			internal_test_suite.connect_events (Current)
		end

	frozen start_process (a_arg: like argument)
			-- <Precursor>
		do
			start_process_internal (a_arg)
			is_idle := True
		end

	start_process_internal (a_arg: like argument)
			-- Start performing a task for given arguments.
			--
			-- Note: `start_process' does not need to care about the idle status.
			--
			-- `a_arg': Arguments defining the task.
		require
			test_suite_valid: is_test_suite_valid
			ready: is_ready (test_suite)
			a_arg_valid: is_valid_argument (a_arg, test_suite)
		deferred
		end

	proceed_process is
			-- Proceed with actual task
		require
			running: is_running
			not_idle: not is_idle
		deferred
		end

	stop_process is
			-- Stop task
		require
			running: is_running
			finished: is_finished
		deferred
		ensure
			not_running: not is_running
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_test_changed (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_item: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			if tests.has (a_item) then
				test_changed_event.publish ([Current, a_item])
			end
		end

end
