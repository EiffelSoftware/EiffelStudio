indexing
	description: "[
		Objects that provide common functionality needed for implementations of {TEST_PROCESSOR_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_PROCESSOR

inherit
	TEST_PROCESSOR_I

	TEST_COLLECTION
		rename
			make as make_collection
		undefine
			events
		end

	TEST_SUITE_OBSERVER
		redefine
			on_test_changed
		end

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
		do
			test_suite := a_test_suite
			test_suite.connect_events (Current)
			make_collection
		end

feature -- Access

	test_suite: !TEST_SUITE_S
			-- <Precursor>

feature {NONE} -- Access

	internal_progress: like progress
			-- Internal storage of `progress'

feature -- Status report

	is_idle: BOOLEAN
			-- <Precursor>

	is_stop_requested: BOOLEAN
			-- <Precursor>

	progress: REAL
			-- <Precursor>
		do
			if is_finished then
				Result := {REAL} 1.0
			else
				Result := internal_progress
			end
		end

feature -- Status setting

	request_stop is
			-- <Precursor>
		do
			is_stop_requested := True
		end

feature {TEST_SUITE_S} -- Status setting

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

	frozen start_process (a_arg: like argument)
			-- <Precursor>
		do
			start_process_internal (a_arg)
			internal_progress := {REAL} 0.0
			is_idle := True
		end

	start_process_internal (a_arg: like argument)
			-- Start performing a task for given arguments.
			--
			-- Note: `start_process' does not need to care about the idle status.
			--
			-- `a_arg': Arguments defining the task.
		require
			test_suite_valid: are_tests_available
			ready: is_ready
			a_arg_valid: is_valid_argument (a_arg)
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

feature {TEST_SUITE_S} -- Events

	on_test_changed (a_collection: !ACTIVE_COLLECTION_I [!TEST_I]; a_item: !TEST_I)
			-- <Precursor>
		do
			if tests.has (a_item) then
				test_changed_event.publish ([Current, a_item])
			end
		end

invariant
	internal_progress_valid: internal_progress >= {REAL} 0.0 and internal_progress <= {REAL} 1.0

end
