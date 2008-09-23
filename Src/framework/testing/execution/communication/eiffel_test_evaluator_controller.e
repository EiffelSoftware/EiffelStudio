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

inherit
	THREAD_CONTROL

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

	last_port: INTEGER
			-- Port last receiver launched by `Current' opened a socket

feature -- Status report

	is_launched: BOOLEAN
			-- Has evaluator been launched?
		do
			Result := internal_status /= Void
		end

	is_running: BOOLEAN
			-- Is evaluator currently running?
		require
			launched: is_launched
		do
			Result := status.is_receiving or is_evaluator_running
		ensure
			result_implies_is_launched: Result implies is_launched
		end

	is_terminated: BOOLEAN
			-- Was evaluator stopped through call to `terminate'.

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	frozen launch (a_list: !DS_LINEAR [!EIFFEL_TEST_I]) is
			-- Launch list of tests.

			-- `a_list': List of tests that `Current' should tell evaluator to execute.
		require else
			not_launched: not is_launched
			a_list_in_map: a_list.for_all (agent (map.tests).has)
		do
			create internal_launch_time.make_now
			create internal_status.make (a_list)
			receiver.receive (status)
			last_port := receiver.last_port
			launch_evaluator (arguments (a_list))
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
			if status.is_listening then
					-- The evaluator was not able to connect to the receiver so we have to terminate the
					-- thread by connecting to the listener port directly.
				close_connection
			end
			status.stop_receiving
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

feature {NONE} -- Query

	arguments (a_list: !DS_LINEAR [!EIFFEL_TEST_I]): !ARRAYED_LIST [!STRING] is
			-- Arguments used to launch evaluator
		require
			a_list_in_map: a_list.for_all (agent (map.tests).has)
		local
			l_idx, l_port, l_root: !STRING
			l_array: !ARRAYED_LIST [!STRING]
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
		do
			create Result.make (a_list.count + 5)

			from
				l_cursor := a_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_idx ?= map.index (l_cursor.item).out
				Result.force (l_idx)
				l_cursor.forth
			end

			Result.force ("-p")
			l_port ?= last_port.out
			Result.force (l_port)
			Result.force ("-o")
			Result.force ("-eif_root")
			create l_root.make (20)
			l_root.append ({EIFFEL_TEST_EVALUATOR_SOURCE_WRITER}.class_name)
			l_root.append_character ('.')
			l_root.append ({EIFFEL_TEST_EVALUATOR_SOURCE_WRITER}.root_feature_name)
			Result.force (l_root)
		end

feature	{NONE} -- Implementation

	close_connection
			-- Close port last launched receiver is listening on by connecting to it and immediatly closing
			-- the connection.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			create l_socket.make_client_by_port (last_port, "localhost")
			l_socket.connect
			l_socket.close
		end

	launch_evaluator (a_args: !LIST [!STRING]) is
			-- Launch evaluator executable
			--
			-- `a_args': Arguments for launching evaluator process
		require
			launched: is_launched
			a_args_not_empty: not a_args.there_exists (agent {!STRING}.is_empty)
		deferred
		end

	is_evaluator_running: BOOLEAN
			-- Is evaluator executable running?
		require
			launched: is_launched
		deferred
		end

	terminate_evaluator is
			-- Terminate evaluator executable
		require
			launched: is_launched
		deferred
		ensure
			evaluator_not_running: not is_evaluator_running
		end

end
