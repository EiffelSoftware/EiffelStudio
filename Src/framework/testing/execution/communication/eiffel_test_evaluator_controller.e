indexing
	description: "[
			Objects that represent the state of a {TEST_ROOT_APPLICATION}, also called evaluator. An
			evaluator can be launched for a given list of tests to execute. The controller will communicate
			with the evaluator in a separate thread to receive test results.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_EVALUATOR_CONTROLLER

feature {NONE} -- Initialization

	make (a_map: like map)
			-- Initialize `Current'.
			--
			-- `a_map': Mapping of tests and indexes in compiled evaluator.
		do
			map := a_map
		ensure
			map_set: map = a_map
		end

feature -- Access

	status: !like internal_status
			-- Testing progress
		require
			launched: is_launched
		do
			Result ?= internal_status
		end

	launch_time: !DATE_TIME
			-- Date and time evaluator was last launched
		require
			launched: is_launched
		do
			Result ?= internal_launch_time
		end

	map: !EIFFEL_TEST_EVALUATOR_MAP
			-- Map containing tests compiled into evaluator

feature {NONE} -- Access

	internal_status: ?EIFFEL_TEST_EVALUATOR_STATUS

	internal_launch_time: ?like launch_time
			-- Internal storage for `launch_time'

	receiver: EIFFEL_TEST_RESULT_RECEIVER
			-- Receiver for incoming test results
		once
			create Result
		end

feature -- Status report

	is_ready: BOOLEAN
			-- Can `Current' be launched?
		deferred
		end

	is_launched: BOOLEAN
			-- Has evaluator been launched?
		do
			Result := internal_status /= Void
		end

	is_running: BOOLEAN
			-- Is evaluator currently running?
		require
			launched: is_launched
		deferred
		ensure
			result_implies_is_launched: Result implies is_launched
		end

	is_terminated: BOOLEAN
			-- Was evaluator stopped through call to `terminate'.

	has_completed: BOOLEAN
			-- Did evaluator execute all tests so far?
		require
			launched: is_launched
		do
			Result := not status.has_remaining_tests
		end

feature -- Status setting

	frozen launch (a_list: !DS_LINEAR [!EIFFEL_TEST_I]) is
			-- Launch list of tests.

			-- `a_list': List of tests that `Current' should tell evaluator to execute.
		require else
			not_launched: not is_launched
			ready: is_ready
			a_list_in_map: a_list.for_all (agent (map.tests).has)
		do
			create internal_launch_time.make_now
			create internal_status.make (a_list)
			receiver.receive (status)
			launch_evaluator (receiver.last_port)
		ensure then
			launched: is_launched
		end

	frozen terminate is
			-- Terminate evaluator if running.
		require
			launched: is_launched
		do
			is_terminated := True
			terminate_evaluator
		ensure
			not_running: not is_running
		end

	reset is
			-- Reset status and `is_launched'
		require
			not_running: not is_running
		do
			internal_status := Void
			internal_launch_time := Void
			is_terminated := False
		ensure
			not_launched: not is_launched
			not_terminated: not is_terminated
		end

feature	{NONE} -- Implementation

	launch_evaluator (a_port: INTEGER) is
			-- Launch evaluator executable
		require
			launched: is_launched
			a_port_valid: a_port >= 49152 and a_port <= 65535
		deferred
		end

	terminate_evaluator is
			-- Terminate evaluator executable
		require
			launched: is_launched
		deferred
		ensure
			not_running: not is_running
		end


end
