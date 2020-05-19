note
	description: "[
		Core implementation for root class of test executor. The test evaluator is used by the
		testing tool to run tests and retrieve results. Any descendant of this class should be used as
		the root class of an interpreter. Descendants need to provide {EQA_EVALUATOR} information on
		what test classes/routines are available and be able to create instances of them.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EQA_EVALUATOR

inherit

	EXECUTION_ENVIRONMENT

	INTERNAL

	EQA_EXTERNALS

	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		local
			l_socket: like socket
		do
			parse_arguments
			create l_socket.make_client_by_address_and_port ((create {INET_ADDRESS_FACTORY}).create_loopback, port)
			l_socket.set_blocking
			l_socket.set_nodelay
			l_socket.connect

				-- In case we could not connect, we have noticed that on IPv6 systems, it is possible
				-- that EiffelStudio will only create the IPv4 socket on Linux. So we try again in IPv4.
			if not l_socket.is_connected then
				create l_socket.make_client_by_address_and_port ((create {INET_ADDRESS_IMPL_V4}).loopback_address, port)
				l_socket.set_blocking
				l_socket.set_nodelay
				l_socket.connect
			end
			socket := l_socket
			main_loop
		end

	parse_arguments
			-- Initialize `Current' according to command line arguments.
		local
			l_args: like arguments
		do
			l_args := arguments
			if l_args.argument_count >= 2 then
				port := l_args.argument (1).to_integer
 				create testing_directory.make_from_string (l_args.argument (2))
			else
					-- See value in {ETEST_EVALUATOR_CONNECTION} from EiffelStudio's code.
				port := 49200
				testing_directory := current_working_path
			end
		ensure
			port_initialized: port > 0
		end

	main_loop
			-- Receive test routines to be executed through `socket' and send obtained test results back.
		require
			socket_attached: socket /= Void
			socket_connected: socket.is_connected
			socket_open_write: socket.is_open_write
		local
			l_result: like execute_test
			l_done: BOOLEAN
			l_environment: EQA_ENVIRONMENT
		do
			from
				create l_environment
			until
				l_done
			loop
				if
					attached {TUPLE [test_name, class_name: detachable STRING_8; body_id: INTEGER_32]} retrieved_from_medium (socket) as l_retrieved and then
					attached l_retrieved.test_name as l_test_name and then attached l_retrieved.class_name as l_class_name
				then
						-- TODO: initialize working directory and environment variables for system level testing
					l_environment.put (l_test_name, {EQA_TEST_SET}.test_name_key)
					l_environment.put (testing_directory.name, {EQA_TEST_SET}.testing_directory_key)

					l_result := execute_test (l_class_name, l_retrieved.body_id)
					socket.put_boolean (True)
					store_in_medium (l_result, socket)

					l_environment.reset
				else
						-- If we retrieved something unexpected, we close the socket and terminate.
					if not socket.is_closed then
						socket.close
					end
					l_done := True
				end
			end
		rescue
			if not socket.is_closed then
				socket.close
			end
		end

feature {NONE} -- Access: Connection

	port: INTEGER
			-- Port number executor is listening to
			--
			-- Note: command linne arg #1

	socket: NETWORK_STREAM_SOCKET
			-- Socket used to communicate to executor

	is_stream_invalid: BOOLEAN
			-- Could stream not be initialized or was it closed early?

feature {NONE} -- Access: Test execution

	testing_directory: PATH
			-- Test execution directory
			--
			-- Note: command line arg #2

feature {NONE} -- Execution

	execute_test (a_name: READABLE_STRING_32; a_rout_id: INTEGER): EQA_PARTIAL_RESULT
			-- Execute test routine in test class.
		local
			l_type: like dynamic_type_from_string
		do
			l_type := dynamic_type_from_string ({STRING_32} "EQA_TEST_EVALUATOR [attached " + a_name.as_upper + "]")
			check attached {EQA_TEST_EVALUATOR [EQA_TEST_SET]} new_instance_of (l_type) as l_eval then
				Result := l_eval.execute (agent invoke_routine (?, a_rout_id))
			end
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
