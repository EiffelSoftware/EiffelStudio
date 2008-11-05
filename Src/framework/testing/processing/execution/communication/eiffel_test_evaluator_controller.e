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

	make (a_assigner: like assigner)
			-- Initialize `Current'.
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
		do
			assigner := a_assigner
			create status.make (assigner)
		ensure
			assigner_set: assigner = a_assigner
		end

feature -- Access

	status: !EIFFEL_TEST_EVALUATOR_STATUS
			-- Status showing testing progress

	launch_time: !DATE_TIME
			-- Date and time evaluator was last launched
		require
			running: is_running
		do
			Result ?= internal_launch_time
		end

	assigner: !EIFFEL_TEST_EXECUTION_ASSIGNER
			-- Assigner for retrieving test to be executed

feature {NONE} -- Access

	internal_launch_time: ?like launch_time
			-- Internal storage for `launch_time'

	receiver: EIFFEL_TEST_RESULT_RECEIVER
			-- Receiver for incoming test results
		once
			create Result
		end

	last_port: INTEGER
			-- Port last receiver launched by `Current' opened a socket

	execution_environment: !EXECUTION_ENVIRONMENT
			-- Helper class providing `sleep' routine.
		once
			create Result
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is-evaluator currently running?

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	frozen launch
			-- Launch list of tests.

			-- `a_list': List of tests that `Current' should tell evaluator to execute.
		require
			not_running: not is_running
		do
			is_running := True
			create internal_launch_time.make_now
			receiver.receive (status)
			last_port := receiver.last_port
			launch_evaluator (arguments)
		ensure
			running: is_running
		end

	frozen terminate is
			-- Terminate evaluator if running.
		require
			running: is_running
		do
			terminate_evaluator
			if not status.is_disconnected then
					-- The evaluator might be still waiting for a connection or is currently still connected to
					-- the result receiver. However to make sure all connections are closed we first try connect
					-- to any still listining port and then wait until it is closed.
				close_connection
				from until
					not status.is_connected
				loop
					execution_environment.sleep (1000)
				end
			end
			is_running := False
			internal_launch_time := Void
		ensure
			not_running: not is_running
		end

feature {NONE} -- Query

	arguments: !ARRAYED_LIST [!STRING] is
			-- Arguments used to launch evaluator
		local
			l_idx, l_port, l_root: !STRING
			l_array: !ARRAYED_LIST [!STRING]
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
		do
			create Result.make (5)

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
			running: is_running
			a_args_not_empty: not a_args.there_exists (agent {!STRING}.is_empty)
		deferred
		end

	is_evaluator_running: BOOLEAN
			-- Is evaluator executable running?
		require
			running: is_running
		deferred
		end

	terminate_evaluator is
			-- Terminate evaluator executable
		require
			running: is_running
		deferred
		ensure
			evaluator_not_running: not is_evaluator_running
		end

end
