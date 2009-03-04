note
	description: "[
			Objects that represent the state of a {TEST_ROOT_APPLICATION}, also called evaluator. An
			evaluator can be launched for a given list of tests to execute. The controller will communicate
			with the evaluator in a separate thread to receive test results.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EVALUATOR_CONTROLLER

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

	status: attached TEST_EVALUATOR_STATUS
			-- Status showing testing progress

	launch_time: attached DATE_TIME
			-- Date and time evaluator was last launched
		require
			running: is_running
		local
			l_launch_time: like internal_launch_time
		do
			l_launch_time := internal_launch_time
			check l_launch_time /= Void end
			Result := l_launch_time
		end

	assigner: attached TEST_EXECUTION_ASSIGNER
			-- Assigner for retrieving test to be executed

feature {NONE} -- Access

	internal_launch_time: detachable like launch_time
			-- Internal storage for `launch_time'

	receiver: TEST_RESULT_RECEIVER
			-- Receiver for incoming test results
		once
			create Result
		end

	last_port: INTEGER
			-- Port last receiver launched by `Current' opened a socket

	execution_environment: attached EXECUTION_ENVIRONMENT
			-- Helper class providing `sleep' routine.
		once
			create Result
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is-evaluator currently running?

feature {TEST_EXECUTOR_I} -- Status setting

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

	frozen terminate
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

	arguments: attached ARRAYED_LIST [attached STRING]
			-- Arguments used to launch evaluator
		local
			l_port, l_root: attached STRING
		do
			create Result.make (5)

			Result.force ("-p")
			create l_port.make (6)
			l_port.append_integer (last_port)
			Result.force (l_port)
			Result.force ("-o")
			Result.force ("-eif_root")
			create l_root.make (20)
			l_root.append ({TEST_EVALUATOR_SOURCE_WRITER}.class_name)
			l_root.append_character ('.')
			l_root.append ({TEST_EVALUATOR_SOURCE_WRITER}.root_feature_name)
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

	launch_evaluator (a_args: attached LIST [attached STRING])
			-- Launch evaluator executable
			--
			-- `a_args': Arguments for launching evaluator process
		require
			running: is_running
			a_args_not_empty: not a_args.there_exists (agent {attached STRING}.is_empty)
		deferred
		end

	is_evaluator_running: BOOLEAN
			-- Is evaluator executable running?
		require
			running: is_running
		deferred
		end

	terminate_evaluator
			-- Terminate evaluator executable
		require
			running: is_running
		deferred
		ensure
			evaluator_not_running: not is_evaluator_running
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
