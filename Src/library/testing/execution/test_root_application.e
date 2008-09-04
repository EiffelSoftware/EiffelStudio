indexing
	description: "[
		Core implementation for root class of test executor. The test evaluator is used by the
		testing tool to run tests and retrieve results. Any descendant of this class should be used as
		the root class of an interpreter. Descendants need to provide {TEST_ROOT_APPLICATION} information on
		what test classes/routines are available and be able to create instances of them.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_ROOT_APPLICATION

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	frozen make is
			-- Initialize `Current'
		do
			create arguments.make
			arguments.execute (agent start)
		end

	start is
			-- Initialize output and start processing commands.
		require
			arguments_valid: arguments.is_successful
		local
			l_quit, l_bad_argument: BOOLEAN
			l_index: STRING
			n: NATURAL
		do
			if not l_quit then
				initialize_stream
				from
					arguments.values.start
				until
					arguments.values.after
				loop
					l_index := arguments.values.item_for_iteration
					if l_index.is_natural then
						n := l_index.to_natural
						if is_valid_index (n) then
							run_test (n)
							io.output.put_string ("ran tests ")
							io.output.put_natural (n)
							io.output.put_new_line
						else
							l_bad_argument := True
						end
					else
						l_bad_argument := True
					end
					if l_bad_argument then
						io.output.put_string (arguments.values.item_for_iteration)
						io.output.put_string (" is not a valid test index")
						die (1)
					end
					arguments.values.forth
				end
				--stream.put_character ('0')
				io.output.put_string ("terminating normally...%N")
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

	arguments: !TEST_ARGUMENT_PARSER
			-- Command line arguments

	evaluator: !TEST_EVALUATOR
			-- Evaluator for executing tests
		require
			arguments_valid: arguments.is_successful
		once
			create Result
			Result.set_record_output (arguments.has_output_option)
		end

	stream: !IO_MEDIUM
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

	initialize_stream is
			-- Initialize `stream'.
		local
			l_rescued: BOOLEAN
			l_socket: !NETWORK_STREAM_SOCKET
		do
			if not l_rescued then
				if arguments.has_port_option then
					create l_socket.make_client_by_port (arguments.port_option, "localhost")
					l_socket.connect
					if not l_socket.is_open_write then
						raise ("bad_socket")
					end
					stream := l_socket
				else
					create {RAW_FILE} stream.make_open_write (arguments.file_option)
				end
			end
		ensure
			stream_initialized: stream.is_open_write
			stream_supports_storable: stream.support_storable
		rescue
			is_stream_invalid := True
		end

	close_stream is
			-- Close `stream' unless standard out
		do
			if not stream.is_closed then
				stream.close
			end
		end

feature {NONE} -- Query		

	test_set_instance (a_index: NATURAL): !TEST_SET is
			-- Instance of a test set class.
		require
			a_index_valid: is_valid_index (a_index)
		deferred
		end

	test_procedure (a_index: NATURAL): !PROCEDURE [ANY, TUPLE [TEST_SET]] is
			-- Agent for a test procedure.
		require
			a_index_valid: is_valid_index (a_index)
		deferred
		end

feature {NONE} -- Execution

	run_test (a_index: NATURAL)

		require
			stream_initialized: stream.is_open_write
			a_index_valid: is_valid_index (a_index)
		do
			io.output.put_string ("trying to run " + a_index.out + "...%N")
			evaluator.execute (test_set_instance (a_index), test_procedure (a_index))
			io.output.put_string ("done with " + a_index.out + "%N")
			io.output.put_string ("stream: ")
			print (stream)
			io.output.new_line
			if stream.extendible then
				io.output.put_string ("stream IS extendible (open write: "); io.output.flush
				io.output.put_boolean (stream.is_open_write)
				io.output.put_boolean (stream.is_writable)
				io.output.put_string ("%Nsending id%N");io.output.flush
				--stream.put_character ('1')
				io.output.put_string ("sending outcome%N"); io.output.flush
				stream.independent_store (evaluator.last_outcome)
				io.output.put_string ("done%N"); io.output.flush
			else
				io.output.put_string ("stream NOT extendible (open write: "); io.output.flush
				io.output.put_boolean (stream.is_open_write)
				io.output.put_boolean (stream.is_writable)
				io.output.put_string ("%N")
				is_stream_invalid := True
			end
		end

end
