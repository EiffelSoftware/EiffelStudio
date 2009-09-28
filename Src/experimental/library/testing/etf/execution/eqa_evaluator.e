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

deferred class
	EQA_EVALUATOR

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

	EQA_EVALUATION_INFO
		export
			{NONE} all
		end

	EQA_EXTERNALS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	launch
			-- Initialize `Current'

		local
			l_socket: like socket
		do
			parse_arguments
			create l_socket.make_client_by_address_and_port ((create {INET_ADDRESS_FACTORY}).create_loopback, port)
			l_socket.set_blocking
			l_socket.set_nodelay
			l_socket.connect
			socket := l_socket
			main_loop
		end

	parse_arguments
			-- Initialize `Current' according to command line arguments.
		local
			l_args: ARGUMENTS
		do
			l_args := (create {EXECUTION_ENVIRONMENT}).command_line
			port := l_args.argument (1).to_integer
			byte_code_feature_body_id := l_args.argument (2).to_integer
			byte_code_feature_pattern_id := l_args.argument (3).to_integer
			set_test_directory (l_args.argument (4))
		ensure
			port_initialized: port > 0
			body_id_initialized: byte_code_feature_body_id > 0
		end

	main_loop
			-- Receive test routines to be executed through `socket' and send obtained test results back.
		require
			socket_attached: socket /= Void
			socket_connected: socket.is_connected
			socket_open_write: socket.is_open_write
		local
			l_evaluator: like execute_test
			l_bc: STRING
			l_done: BOOLEAN
		do
			from until
				l_done
			loop
				if attached {TUPLE [byte_code, name: STRING]} socket.retrieved as l_retrieved then
					l_bc := l_retrieved.byte_code

						-- Replace byte code
					eif_override_byte_code_of_body (
						byte_code_feature_body_id,
						byte_code_feature_pattern_id,
						pointer_for_byte_code (l_bc), l_bc.count)

						-- TODO: initialize working directory and environment variables for system level testing
					set_test_name (l_retrieved.name)

					l_evaluator := execute_test
					socket.put_boolean (True)
					socket.independent_store (l_evaluator.last_result)
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

feature {NONE} -- Access

	port: INTEGER
			-- Port number executor is listening to

	byte_code_feature_body_id: INTEGER
			-- ID for feature whose byte-code is to be injected

	byte_code_feature_pattern_id: INTEGER
			-- Pattern ID for feature whose byte-code is to be injected

	socket: NETWORK_STREAM_SOCKET
			-- Socket used to communicate to executor

	is_stream_invalid: BOOLEAN
			-- Could stream not be initialized or was it closed early?

feature {NONE} -- Execution

	execute_test: EQA_TEST_EVALUATOR [EQA_TEST_SET]
			-- Run current test and return evaluator containing result.
			--
			-- Note: this routine's byte code will be replaced for every test execution.
		deferred
		ensure
			result_attached: Result /= Void
			result_executed: Result.has_result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
