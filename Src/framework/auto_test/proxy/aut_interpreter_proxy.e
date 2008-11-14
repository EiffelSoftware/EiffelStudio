indexing
	description:

		"Proxy for Erl-G interpreters"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_INTERPRETER_PROXY

inherit
	AUT_RESPONSE_PARSER
		rename
			make as make_response_parser
		redefine
			parse_response
		end

	PROCESS_FACTORY
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

	UNIX_SIGNALS
		export {NONE} all end

	EXECUTION_ENVIRONMENT
		rename
			system as execution_system
		export
			{NONE} all
		end

	AUT_SHARED_INTERPRETER_INFO

	EXCEPTIONS
		rename
			ignore as exc_ignore,
			catch as exc_catch,
			meaning as exc_meaning
		end

	COMPILER_EXPORTER

	AUT_SHARED_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_executable_file_name: STRING;
			a_system: like system;
			an_interpreter_log_filename: STRING;
			a_proxy_log_filename: STRING;
			a_error_handler: like error_handler) is
			-- Create a new proxy for the interpreter found at `an_executable_file_name'.
		require
			an_executable_file_name_not_void: an_executable_file_name /= Void
			a_system_not_void: a_system /= Void
			an_interpreter_log_filename_not_void: an_interpreter_log_filename /= Void
			a_proxy_log_filename_not_void: a_proxy_log_filename /= Void
			a_error_handler_not_void: a_error_handler /= Void
		do
			create variable_table.make (a_system)
			create raw_response_analyzer
			make_response_parser (a_system)

				-- You can only do this after the compilation of the interpreter.
			injected_feature_body_id := interpreter_root_class.feature_named (feature_name_for_byte_code_injection).real_body_id (interpreter_root_class.types.first)
			injected_feature_pattern_id := interpreter_root_class.feature_named (feature_name_for_byte_code_injection).real_pattern_id (interpreter_root_class.types.first)

				-- Setup request printers.
			create socket_data_printer.make (system, variable_table)
			create log_stream.make_empty

				-- We have two printers here because one printer will print byte-code into an IPC socket,
				-- but we also want the test cases to be readable, so we use a text printer to print those
				-- test cases into plain text.
			create request_printer.make
			request_printer.extend (create {AUT_REQUEST_TEXT_PRINTER}.make (system, log_stream))
			request_printer.extend (socket_data_printer)

			executable_file_name := an_executable_file_name
			melt_path := file_system.dirname (executable_file_name)
			interpreter_log_filename := an_interpreter_log_filename
			create proxy_log_file.make (a_proxy_log_filename)
			proxy_log_file.open_write

			create response_printer.make_with_prefix (proxy_log_file, interpreter_log_prefix)

			log_line ("-- A new proxy has been created.")
			proxy_start_time := system_clock.date_time_now
			error_handler := a_error_handler
			timeout := default_timeout
			set_is_logging_enabled (True)
		ensure
			executable_file_name_set: executable_file_name = an_executable_file_name
			system_set: system = a_system
			proxy_log_file_created: proxy_log_file /= Void
			error_handler_set: error_handler = a_error_handler
			timeout_set: timeout = default_timeout
			is_logging_enabled: is_logging_enabled
		end

feature -- Status

	is_ready: BOOLEAN
			-- Is client ready for new commands?

	is_running: BOOLEAN is
			-- Is the client currently running?
		do
			Result := process /= Void and then process.is_running
		ensure
			result_implies_attached: Result implies process /= Void
			result_implies_running: Result implies process.is_running
		end

	is_launched: BOOLEAN is
			-- Has the client been launched?
			-- Note that `is_launched' will be True also when the child has
			-- terminated in the meanwhile.
		do
			Result := process /= Void and then process.is_launched
		ensure
			result_implies_attached: Result implies process /= Void
			result_implies_launched: Result implies process.is_launched
		end

	is_in_replay_mode: BOOLEAN
			-- Is Current in replay mode?
			-- If so, no extra "type" request will be generated
			-- after every "assign" request and every query invokation.
			-- Default: False

	is_logging_enabled: BOOLEAN
			-- Should inter-process communication between the proxy and the interpreter
			-- be logged into a file?
			-- Default: True

feature -- Access

	timeout: INTEGER
			-- Client timeout in seconds

	last_request: AUT_REQUEST
			-- Last request sent via this proxy

	variable_table: AUT_VARIABLE_TABLE
			-- Table for index and types of object in object pool

	proxy_log_filename: STRING is
			-- File name of proxy log
		do
			Result := proxy_log_file.name
		ensure
			filename_not_void: Result /= Void
			valid_filename: Result.is_equal (proxy_log_file.name)
		end

feature -- Settings

	set_timeout (a_timeout: INTEGER) is
			-- Set `timeout' with `a_timeout'.
		require
			a_timeout_valid: a_timeout > 0
		do
			timeout := a_timeout
		ensure
			timeout_set: timeout = a_timeout
		end

	set_is_logging_enabled (b: BOOLEAN) is
			-- Set `is_logging_enabled' with `b'.
		do
			is_logging_enabled := b
		ensure
			is_logging_enabled_set: is_logging_enabled = b
		end

	set_is_in_replay_mode (b: BOOLEAN) is
			-- Set `is_in_replay_mode' with `b'.
		do
			is_in_replay_mode := b
		ensure
			is_in_replay_mode_set: is_in_replay_mode = b
		end

	set_proxy_log_filename (a_filename: like proxy_log_filename) is
			-- Make `a_filename' the new proxy filename.
		require
			a_filename_not_void: a_filename /= Void
		do
			if proxy_log_file.is_open_write then
				proxy_log_file.close
			end
			create proxy_log_file.make (a_filename)
			proxy_log_file.open_write
			log_line ("-- An existing proxy has switched to this log file.")
		end

feature -- Execution

	start is
			-- Start the client.
		require
			not_running: not is_running
		local
			l_listener: AUT_SOCKET_LISTENER
		do
			log_time_stamp ("start")
			create {AUT_START_REQUEST} last_request.make (system)
			variable_table.wipe_out

				-- Create socket and start listening on `port'.
			if socket /= Void and then socket.exists and then not socket.is_closed then
				socket.cleanup
			end

--				-- Initialize a new socket for IPC.
--				-- Fixeme: port number is increased every time when we try to launch the interpreter
--				-- It should be possible to reuse port number, but when I tried it, I always got
--				-- socket connection problems. Jason 2008.10.21
--			fixme ("Try to reuse port number.")
--			port := next_port_number
--			create l_socket.make_server_by_port (port)
--			l_socket.set_blocking
--			l_socket.listen (1)

			create l_listener.make
			l_listener.open_new_socket
			if l_listener.is_listening then
				port := l_listener.current_port

					-- Launch interpreter process.			
				launch_process

				if is_running then

						-- Get socket to communicate with interpreter.
--					l_socket.accept
--					fixme ("If interpreter process dies now, current thread will be blocked forever.")
--					(create {EXECUTION_ENVIRONMENT}).sleep (1000000000)
--					socket := l_socket.accepted

					if {l_socket: like socket} l_listener.wait_for_connection (5000) then
						socket := l_socket
						process.set_timeout (timeout)
						log_stream.string.wipe_out
						last_request.process (request_printer)
						flush_process
						log_line (proxy_has_started_and_connected_message)
						log_line (itp_start_time_message + error_handler.duration_to_now.second_count.out)
						parse_start_response
						last_request.set_response (last_response)
						if last_response.is_bad then
							log_bad_response
						end
						is_ready := is_running
					else
						log_line ("-- Error: Interpreter was not able to connect.")
					end
				else
					log_line ("-- Error: Could not start and connect to interpreter.")
				end
			else
				log_line ("-- Error: Could not find available port for listening.")
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	stop is
			-- Close connection to client and terminate it.
			-- If the client is not responsive to a regular shutdown,
			-- its process will be forced to shut down
		require
			is_running: is_launched
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				if process.is_running then

					create {AUT_STOP_REQUEST} last_request.make (system)
					last_request.process (request_printer)
					flush_process
					parse_stop_response
					last_request.set_response (last_response)
						-- Give the `process' 50 milliseconds to terminate itself
					process.wait_for_exit_with_timeout (50)
					if not process.has_exited then
							-- Force shutdown of `process' because it has not terminated regularly
						log_line ("-- Warning: proxy was not able to terminate interpreter.")

							-- Set flag to indicate that the interpreter should be terminated.
							-- When `time_out_checker_thread' sees this flag, it will terminate the interpreter.
						process.terminate
						log_line ("-- Warning: proxy forced termination of interpreter.")
					else
						log_line ("-- Proxy has terminated interpreter.")
					end
				end
				if socket /= Void then
					cleanup_socket
				end
			end
		ensure
			last_request_not_void: last_request /= Void
		rescue
			l_retried := True
			cleanup_socket
			retry
		end

	create_object (a_receiver: ITP_VARIABLE; a_type: TYPE_A; a_procedure: FEATURE_I; an_argument_list: DS_LINEAR [ITP_EXPRESSION]) is
			-- Create new object of type `a_type' using creation
			-- procedure `a_feature' and the arguments `an_argument_list'.
			-- Store the created object in variable `a_receiver'.
		require
			is_launched: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_type_not_void: a_type /= Void
			a_type_not_expanded: not a_type.is_expanded
			a_procedure_not_void: a_procedure /= Void
			a_procedure_is_not_infix_or_prefix: not a_procedure.is_prefix and then not a_procedure.is_infix
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			normal_response: AUT_NORMAL_RESPONSE
			l_arg_list: DS_LINEAR [ITP_EXPRESSION]
			l_request: AUT_CREATE_OBJECT_REQUEST
		do
			log_time_stamp ("exec")
			l_arg_list := an_argument_list
			if l_arg_list = Void then
				create {DS_LINKED_LIST [ITP_EXPRESSION]} l_arg_list.make
			end
			create l_request.make (system, a_receiver, a_type, a_procedure, l_arg_list)

			last_request := l_request
			last_request.process (request_printer)
			flush_process
			parse_invoke_response
			last_request.set_response (last_response)
			if not last_response.is_bad then
				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
					end
					if normal_response.exception = Void then
						variable_table.define_variable (a_receiver, a_type)
					end
				end
			end
			stop_process_on_problems (last_response)
		ensure
			last_request_not_void: last_request /= Void
		end

	invoke_feature (a_type: TYPE_A; a_feature: FEATURE_I; a_target: ITP_VARIABLE; an_argument_list: DS_LINEAR [ITP_EXPRESSION]) is
			-- Invoke feature `a_feature' from `a_type' with arguments `an_argument_list'.
		require
			is_running: is_launched
			is_ready: is_ready
			a_feature_not_void: a_feature /= Void
			a_feature_is_not_infix_or_prefix: not a_feature.is_prefix and then not a_feature.is_infix
			class_has_feature: has_feature (variable_table.variable_type (a_target).associated_class, a_feature)
			a_target_not_void: a_target /= Void
			a_target_defined: variable_table.is_variable_defined (a_target)
			no_void_target: not variable_table.variable_type (a_target).is_none
			an_argument_list_not_void: an_argument_list /= Void
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			l_invoke_request: AUT_INVOKE_FEATURE_REQUEST
			l_feature: FEATURE_I
			l_target_type: TYPE_A
		do
			log_time_stamp ("exec")
			l_target_type := variable_table.variable_type (a_target)
			l_feature := l_target_type.associated_class.feature_of_rout_id (a_feature.rout_id_set.first)

				-- Adjust feature according to the actual type of `a_target'.
				-- This is needed because of feature renaming. If we don't do this,
				-- in the replay mode, there will be a problem, either because some feature is not found,
				-- or the type of argument are not correct.
			create l_invoke_request.make (system, l_feature.feature_name, a_target, an_argument_list)
			l_invoke_request.set_target_type (l_target_type)

			last_request := l_invoke_request
			last_request.process (request_printer)
			flush_process
			parse_invoke_response
			last_request.set_response (last_response)
			if not last_response.is_bad or last_response.is_error then
				is_ready := True
			end
			stop_process_on_problems (last_response)
		ensure
			last_request_not_void: last_request /= Void
		end

	invoke_and_assign_feature (a_receiver: ITP_VARIABLE; a_type: TYPE_A; a_query: FEATURE_I; a_target: ITP_VARIABLE; an_argument_list: DS_LINEAR [ITP_EXPRESSION]) is
			-- Invoke query `a_query' from `a_type' with arguments `an_argument_list'.
			-- Store result in variable `a_receiver'.
		require
			is_running: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_query_not_void: a_query /= Void
			a_query_is_not_infix_or_prefix: not a_query.is_prefix and then not a_query.is_infix
			class_has_query: has_feature (variable_table.variable_type (a_target).associated_class, a_query)
			a_target_not_void: a_target /= Void
			a_target_defined: variable_table.is_variable_defined (a_target)
			no_void_target: not variable_table.variable_type (a_target).is_none
			an_argument_list_not_void: an_argument_list /= Void
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			normal_response: AUT_NORMAL_RESPONSE
			l_invoke_request: AUT_INVOKE_FEATURE_REQUEST
		do
			log_time_stamp ("exec")
			create l_invoke_request.make_assign (system, a_receiver, a_query.feature_name, a_target, an_argument_list)
			l_invoke_request.set_target_type (a_type)
			last_request := l_invoke_request
			last_request.process (request_printer)
			flush_process
			parse_invoke_response
			last_request.set_response (last_response)
			if not last_response.is_bad then
				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
					end
				end
			end
			stop_process_on_problems (last_response)
			if is_ready and normal_response /= Void and then normal_response.exception = Void then
				if not is_in_replay_mode then
						-- If we are not in replay mode, we generate "type" request to get the
						-- dynamic type of the assignment target. If we are in replay mode,
						-- the "type" request will be already in the replay list, so we don't need to
						-- generate them automatically.					
					retrieve_type_of_variable (a_receiver)
				end
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	assign_expression (a_receiver: ITP_VARIABLE; an_expression: ITP_EXPRESSION) is
			-- Assign `a_constant' to `a_receiver'.
		require
			is_launched: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_constant_not_void: an_expression /= Void
		do
			create {AUT_ASSIGN_EXPRESSION_REQUEST} last_request.make (system, a_receiver, an_expression)
			last_request.process (request_printer)
			flush_process
			parse_invoke_response
			last_request.set_response (last_response)
			if not last_response.is_bad or last_response.is_error  then
				is_ready := True
			end
			stop_process_on_problems (last_response)
			if is_ready and then not is_in_replay_mode then
					-- If we are not in replay mode, we generate "type" request to get the
					-- dynamic type of the assignment target. If we are in replay mode,
					-- the "type" request will be already in the replay list, so we don't need to
					-- generate them automatically.
				retrieve_type_of_variable (a_receiver)
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	retrieve_type_of_variable (a_variable: ITP_VARIABLE) is
			-- Retrieve the type of variable `a_variable' and
			-- store the result in `variable_type_table'.
		require
			a_variable_not_void: a_variable /= Void
			is_running: is_launched
			is_ready: is_ready
		local
			normal_response: AUT_NORMAL_RESPONSE
		do
			create {AUT_TYPE_REQUEST} last_request.make (system, a_variable)
			last_request.process (request_printer)
			flush_process
			is_waiting_for_type := True
			parse_type_of_variable_response
			is_waiting_for_type := False
			last_request.set_response (last_response)
			if not last_response.is_bad then
				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
						no_exception: normal_response.exception = Void
						valid_type: base_type (normal_response.text, interpreter_root_class) /= Void
					end
					variable_table.define_variable (a_variable, base_type (normal_response.text, interpreter_root_class))
				end
			end
			stop_process_on_problems (last_response)
		ensure
			last_request_not_void: last_request /= Void
		end

feature -- Response parsing

	parse_response is
			-- Parse response from interpreter, store it in `last_response'.
		do
			Precursor

				-- Print `last_response' into log file when `is_logging_enabled'.
			if is_logging_enabled then
				last_response.process (response_printer)
			end
		end

	parse_start_response is
			-- Parse the response issued by the interpreter after it has been
			-- started.
		do
			parse_empty_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_stop_response is
			-- Parse the response issued by the interpreter after it received a stop request.
		do
			parse_empty_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_invoke_response is
			-- Parse the response issued by the interpreter after a
			-- create-object/create-object-default/invoke-feature/invoke-and-assign-feature
			-- request has been sent.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_assign_expression_response  is
			-- Parse response issued by interpreter after receiving an
			-- assign-expresion request.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_type_of_variable_response is
			-- Parse response issued by interpreter after receiving a
			-- retrieve-type-of-variable request.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_empty_response is
			-- Parse a response consisting of no characters.
		do
			raw_response_analyzer.set_raw_response (create {AUT_RAW_RESPONSE}.make ("", "", False))
			last_response := raw_response_analyzer.response
		end

feature {NONE} -- Process scheduling

	process: AUT_PROCESS_CONTROLLER
			-- Process controller

	request_count: NATURAL_64
			-- Number of requests that have been sent to interpreter so far

feature{NONE} -- Process scheduling

	stdout_reader: AUT_THREAD_SAFE_LINE_READER
			-- Non blocking reader for client-stdout
			-- This is a walkaround for the problem that the process libarry
			-- cannot launch interpreter just with input redirected.

	is_waiting_for_type: BOOLEAN
			-- Are we waiting for repsone for a type request
			-- This is a walkaround for the problem that the process libarry
			-- cannot launch interpreter just with input redirected.

	launch_process is
			-- Launch `process'.
		local
			arguments: ARRAYED_LIST [STRING]
			l_body_id: INTEGER
		do
				-- $MELT_PATH needs to be set here in only to allow debugging.
			execution_environment.set_variable_value ("MELT_PATH", melt_path)
			create stdout_reader.make

				-- We need `injected_feature_body_id'-1 because the underlying C array is 0-based.
			l_body_id := injected_feature_body_id - 1
			create arguments.make_from_array (<<"localhost", port.out, l_body_id.out, injected_feature_pattern_id.out, interpreter_log_filename, "-eif_root", interpreter_root_class_name + "." + interpreter_root_feature_name>>)

			create process.make (executable_file_name, arguments, ".")
			process.set_timeout (0)
			process.launch (agent stdout_reader.put_string)
		end

	flush_process is
			-- Send request data into interpreter through `socket'.
			-- If error occurs, close `socket'.
		local
			failed: BOOLEAN
		do
			if not failed then
				is_ready := False
				if process.input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
					log (log_stream.string)
					request_count := request_count + 1
					process.set_timeout (timeout)
					if socket /= Void and then socket.is_open_write and socket.extendible then
						socket.put_natural (1)
						socket.independent_store (socket_data_printer.last_request)
					end
				else
					log_line ("-- Error: could not send instruction to interpreter due its input stream being closed.")
				end
				log_stream.string.wipe_out
			end
		rescue
			failed := True
			retry
		end

	stop_process_on_problems (a_response: AUT_RESPONSE) is
			-- Stop `process' if a class invariant has occured in the interpreter or
			-- a bad response has been received.
			-- The interpreter will shut down in case of a class invariant, because the
			-- system will be in an invalid state.
		require
			a_response_not_void: a_response /= Void
		local
			normal_response: AUT_NORMAL_RESPONSE
		do
			if is_running then
				if a_response.is_bad then
					if not process.force_terminated then
						stop
					end
					log_line ("-- Proxy has terminated interpreter due to bad behavior.")
				elseif a_response.is_error then
					-- Do nothing
				else
					normal_response ?= a_response
					check
						normal_response_not_void: normal_response /= Void
					end
					if normal_response.exception /= Void then
						if normal_response.exception.code = Class_invariant then
							stop
							log_line ("-- Proxy has terminated interpreter due to class invariant violation.")
						end
					end
				end
			else
				log_line ("-- Interpreter seems to have quit on its own.")
			end
		end

feature -- Socket IPC

	port: INTEGER
			-- Port number used for socket IPC

	min_port: INTEGER = 49152
			-- Minimal port number

	port_cell: CELL [INTEGER] is
			-- Cell to contain port number.
		once
			create Result.put (min_port)
		ensure
			result_attached: Result /= Void
		end

	next_port_number: INTEGER is
			-- Next port number to connect through socket
		do
			fixme ("Ideally, we should reuse the same port number.")
			Result := port_cell.item
			port_cell.put (Result + 1)
		end

	socket: NETWORK_STREAM_SOCKET
			-- Socked used to

	cleanup is
			-- Clean up Current proxy.
		do
			if socket /= Void then
				cleanup_socket
			end
		end

	cleanup_socket is
			-- Cleanup `socket'.
		require
			socket_attached: socket /= Void
		do
			if socket.exists and then not socket.is_closed then
				socket.close
			end
		end

	retrieve_response is
			-- Retrieve response from the interpreter,
			-- store it in `last_raw_response'.
		local
			l_data: TUPLE [output: STRING; is_interpreter_error: BOOLEAN; error: STRING]
			l_retried: BOOLEAN
			l_socket: like socket
		do
			if not l_retried then
				l_socket := socket
				from
				until
					l_socket.readable or l_socket.is_closed
				loop
					sleep (10000)
				end

				if l_socket.is_readable then
					l_socket.read_natural_32
					l_data ?= l_socket.retrieved
					process.set_timeout (0)
					if l_data /= Void then
						create last_raw_response.make (l_data.output, l_data.error, l_data.is_interpreter_error)

							-- Fixme: This is a walk around for the issue that we cannot launch a process
							-- only with standard input redirected. Remove the following line when fixed,
							-- because everything that the interpreter output should come from `l_data.output'.
							-- Jason 2008.10.22
						replace_output_from_socket_by_pipe_data
					else
						last_raw_response := Void
					end
				end
			end
		rescue
			l_retried := True
			last_raw_response := Void
			retry
		end

	replace_output_from_socket_by_pipe_data is
			-- Replace output received from `socket' by output received from
			-- pipe reader `stdout_reader'.
			-- Fixme: This is a walk around for the issue that we cannot launch a process
			-- only with standard input redirected. Jason 2008.10.22
		do
			fixme ("Remove this feature when the bug described in header comment is fixed.")
			check last_raw_response_attached: last_raw_response /= Void end
			if not is_waiting_for_type then
				if stdout_reader.has_read_line then
						-- Because pipe reading is done in a separate thread,
						-- we cannot guarantee the compete output from interpreter
						-- has been read at this point.
					stdout_reader.try_read_all_lines
					if stdout_reader.last_string /= Void then
						last_raw_response.set_output (stdout_reader.last_string)
					end
				end
			end
		end

feature -- Logging

	log_line (a_string: STRING) is
			-- Log `a_string' followed by a new-line character to `log_file'.
		require
			a_string_not_void: a_string /= Void
		do
			log (a_string)
			log ("%N")
		end

feature {NONE} -- Logging

	log (a_string: STRING) is
			-- Log `a_string' to `log_file'.
		require
			a_string_not_void: a_string /= Void
		do
			if is_logging_enabled and then proxy_log_file.is_open_write then
				proxy_log_file.put_string (a_string)
				proxy_log_file.flush
			end
		end

	log_bad_response is
			-- Log that we received a bad response.
		do
			log_line ("-- Proxy received a bad response.")
		end

	log_time_stamp (a_tag: STRING) is
			-- Log tag `a_tag' with timing information.
		local
			time_now: DT_DATE_TIME
			duration: DT_DATE_TIME_DURATION
		do
			time_now := system_clock.date_time_now
			duration := time_now.duration (proxy_start_time)
			duration.set_time_canonical
			log ("-- time stamp: ")
			log (a_tag)
			log ("; ")
			log (duration.second_count.out)
			log ("; ")
			log_line (duration.millisecond_count.out)
		end

feature {NONE} -- Implementation

	executable_file_name: STRING
			-- File name of interpreter executable

	interpreter_log_filename: STRING
			-- File name of the interpreters log

	melt_path: STRING
			-- Path where melt file of test client resides

	request_printer: AUT_REQUEST_PROCESSORS
			-- Request printer

	socket_data_printer: AUT_REQUEST_PRINTER
			-- Printer to generate socket data for interpreter

	log_stream: KL_STRING_OUTPUT_STREAM
			-- Output stream used by `request_printer' for log file generation

	injected_feature_body_id: INTEGER
			-- Feature body ID of the feature whose byte-code is to be injected

	injected_feature_pattern_id: INTEGER
			-- Pattern ID of the feature whose byte-code is to be injected

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	response_printer: AUT_RESPONSE_LOG_PRINTER
			-- Log printer

	proxy_start_time: DT_DATE_TIME
			-- Time when Current proxy started.

	proxy_log_file: KL_TEXT_OUTPUT_FILE
			-- Proxy log file

	default_timeout: INTEGER is 5
			-- Default value in second for `timeout'

invariant
	is_running_implies_reader: is_running implies (stdout_reader /= Void)
	request_printer_not_void: request_printer /= Void
	executable_file_name_not_void: executable_file_name /= Void
	melt_path_not_void: melt_path /= Void
	not_running_implies_not_ready: not is_running implies not is_ready
	is_ready_implies_is_running: is_ready implies is_running
	proxy_log_file_not_void: proxy_log_file /= Void
	interpreter_log_file_name_not_void: interpreter_log_filename /= Void
	error_handler_not_void: error_handler /= Void
	variable_table_attached: variable_table /= Void
	socket_data_printer_attached: socket_data_printer /= Void
	response_printer_attached: response_printer /= Void
	raw_response_analyzer_attached: raw_response_analyzer /= Void


end
