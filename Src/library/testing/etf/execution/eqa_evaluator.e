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

feature {NONE} -- Initialization

	frozen make
			-- Initialize `Current'
		do
			create arguments.make
			arguments.execute (agent start)
		end

	start
			-- Initialize output and start processing commands.
		require
			arguments_valid: arguments.is_successful
		local
			l_quit, l_done: BOOLEAN
			n: NATURAL
			l_stream: like stream
		do
			if not l_quit then
				initialize_stream
				l_stream := stream
				check l_stream /= Void end
				from until
					l_done
				loop
					l_done := True
					l_stream.read_natural_32
					if l_stream.bytes_read = {PLATFORM}.natural_32_bytes then
						n := l_stream.last_natural_32
						if n > 0 then
							if is_valid_index (n) then
								run_test (n)
								l_done := False
							end
						end
					end
				end
				l_stream.put_natural (0)
				close_stream
			end
		rescue
			if is_stream_invalid then
				if arguments.has_port_option then
					io.output.put_string ("Could not write to socket on port ")
					io.output.put_integer (arguments.port_option)
				else
					io.output.put_string ("Count not write to file ")
					io.output.put_string (arguments.file_option)
				end
				io.output.put_new_line
				die (1)
			elseif exception = {EXCEP_CONST}.signal_exception or
			       exception = {EXCEP_CONST}.operating_system_exception then
					--| assuming process was killed on user request
				l_quit := True
				retry
			end
		end

feature {NONE} -- Access

	arguments: EQA_EVALUATOR_ARGUMENT_PARSER
			-- Command line arguments

	evaluator: EQA_TEST_EVALUATOR
			-- Evaluator for executing tests
		require
			arguments_valid: arguments.is_successful
		once
			create Result
			Result.set_record_output (arguments.has_output_option)
		ensure
			result_attached: Result /= Void
		end

	stream: detachable IO_MEDIUM
			-- Represents the communication medium between interpreter and client
			--
			-- Note: this can be a socket or a raw file

	is_stream_invalid: BOOLEAN
			-- Could stream not be initialized or was it closed early?

feature -- Status report

	is_valid_index (a_index: NATURAL): BOOLEAN
			-- Is `a_index' a valid?
		deferred
		end

feature {NONE} -- Status setting

	initialize_stream
			-- Initialize `stream'.
		local
			l_rescued: BOOLEAN
			l_socket: NETWORK_STREAM_SOCKET
		do
			if not l_rescued then
				if arguments.has_port_option then
					create l_socket.make_client_by_port (arguments.port_option, "localhost")
					l_socket.connect
					l_socket.set_blocking
					if not l_socket.is_open_write then
						raise ("bad_socket")
					end
					stream := l_socket
				else
					create {RAW_FILE} stream.make_open_write (arguments.file_option)
				end
			end
		ensure
			stream_initialized: attached stream as l_s and then l_s.is_open_write
			stream_supports_storable: attached stream as l_s2 and then l_s2.support_storable
		rescue
			is_stream_invalid := True
		end

	close_stream
			-- Close `stream' unless standard out
		local
			l_stream: like stream
		do
			l_stream := stream
			check l_stream /= Void end
			if not l_stream.is_closed then
				l_stream.close
			end
		end

feature {NONE} -- Query		

	test_set_instance (a_index: NATURAL): EQA_TEST_SET
			-- Instance of a test set class.
		require
			a_index_valid: is_valid_index (a_index)
		deferred
		ensure
			result_attached: Result /= Void
		end

	test_procedure (a_index: NATURAL): PROCEDURE [ANY, TUPLE [EQA_TEST_SET]]
			-- Agent for a test procedure.
		require
			a_index_valid: is_valid_index (a_index)
		deferred
		ensure
			result_attached: Result /= Void
		end

	test_name (a_index: NATURAL): READABLE_STRING_8
			-- Name of the test procedure
		require
			a_index_valid: is_valid_index (a_index)
		deferred
		ensure
			result_attached: Result /= Void
			result_valid: test_set_instance (a_index).is_valid_name (Result)
		end

feature {NONE} -- Execution

	run_test (a_index: NATURAL)
			-- Run test with `a_index'.
		require
			stream_initialized: attached stream as l_s and then l_s.is_open_write
			a_index_valid: is_valid_index (a_index)
		local
			l_result: detachable EQA_TEST_RESULT
			l_stream: like stream
		do
			evaluator.execute (test_set_instance (a_index), test_procedure (a_index), test_name (a_index))
			l_stream := stream
			check l_stream /= Void end
			if l_stream.extendible then
				l_stream.put_natural (a_index)
				l_result := evaluator.last_result
				check l_result /= Void end
				l_stream.independent_store (l_result)
			else
				is_stream_invalid := True
			end
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
