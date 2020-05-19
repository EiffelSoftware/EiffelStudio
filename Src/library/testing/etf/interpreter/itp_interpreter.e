note
	description: "[
		Interpreter for line based Eiffel like interpreter language.
		Depends on a generated Erl-G reflection library.
		]"
	author: "Andreas Leitner"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class ITP_INTERPRETER

inherit
	ANY

	EXCEPTIONS
		export {NONE} all end

	ARGUMENTS_32
		export {NONE} all end

	ITP_SHARED_CONSTANTS
		export {NONE} all end

	ERL_CONSTANTS
		export {NONE} all end

	EXECUTION_ENVIRONMENT
		rename
			command_line as command_line_arguments
		export
			{NONE} all
		end

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

	EQA_EXTERNALS

create
	execute

feature {NONE} -- Initialization

	execute
			-- Execute interpreter.
			-- Command line for current: interpreter <port> <melt feature id> <log file>
			-- <port> is the port number used in socket IPC
			-- <melt feature id> is the feature body ID whose byte-code is to be injected
			-- <log file> is the file to store logs.
		local
			l_log_filename: IMMUTABLE_STRING_32
			l_server_url: IMMUTABLE_STRING_32
			l_port: INTEGER
		do
			if argument_count /= 5 then
				check Wrong_number_of_arguments: False end
			end
				-- Read command line argument
				-- Note that `l_server_ulr' is still read even though not used
				-- because we use the loopback of the current machine to communicate
				-- and thus avoid firewall issues.
			l_server_url := argument (1)
			l_port := argument (2).to_integer
			byte_code_feature_body_id := argument (3).to_integer
			byte_code_feature_pattern_id := argument (4).to_integer
			l_log_filename := argument (5)

				-- Redirect standard output to `output_buffer'.
			create output_buffer.make (buffer_size)
			create error_buffer.make (buffer_size)

				-- Create object pool
			create object_store.make

				-- Create log file.
			create log_file.make_with_name (l_log_filename)
			log_file.open_append
			if not log_file.is_open_write then
				report_error ("could not open log file '" + {UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_log_filename) + "'.")
				die (1)
			end

			start (l_port, (create {INET_ADDRESS_FACTORY}).create_loopback)

				-- Close log file.
			log_file.close
		end

	start (a_port: INTEGER; a_server_url: INET_ADDRESS)
			-- Connect to EiffelStudio and initiate `main_loop'.
		require
			a_server_url_attached: a_server_url /= Void
			a_port_valid: a_port >= 0
		local
			l_trace: STRING
		do
			create socket.make_client_by_address_and_port (a_server_url, a_port)
			socket.connect
			socket.set_blocking
			socket.set_nodelay
				-- Wait for test cases and then execute test cases in a loop.
			log_message ("<session>%N")
			main_loop
			log_message ("</session>%N")
		rescue
				-- Get an one line trace by replacing new line characters with space, since
				-- the stream parser from proxy cannot deal with multi line error messages.
				-- TODO: Added support for multi line error message.
			if attached exception_trace as l_excpt_trace then
				l_trace := l_excpt_trace.twin
				l_trace.replace_substring_all ("%N", " ")
				log_internal_error (l_excpt_trace)
			else
				l_trace := "Unknown error"
				log_internal_error (l_trace)
			end
			log_message ("</session>%N")
			report_error ({STRING} "internal. " + l_trace)
			die (1)
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occurred while parsing?

	is_last_protected_execution_successfull: BOOLEAN
			-- Was the last protected execution successfull?
			-- (i.e. did it not trigger an exception)

	should_quit: BOOLEAN
			-- Should main loop quit?

	is_request_type_valid (a_type: NATURAL_32): BOOLEAN
			-- Is `a_type' a valid request type?
		do
			Result :=
				a_type = start_request_flag or else
				a_type = quit_request_flag or else
				a_type = execute_request_flag or else
				a_type = type_request_flag
		end

feature {NONE} -- Handlers

	report_type_request
		require
			last_request_attached: last_request /= Void
			last_request_is_type_request: last_request_type = type_request_flag
		local
			b: BOOLEAN
			l_index: INTEGER
			l_value: detachable ANY
			l_object_store: like object_store
			l_type: STRING_8
		do
			if attached {STRING} last_request as l_obj_index then
				log_message ("report_type_request start%N")
				l_index := l_obj_index.to_integer
				l_object_store := object_store
				if l_object_store.is_variable_defined (l_index) then
					l_value := l_object_store.variable_value (l_index)
					if l_value = Void then
						create l_type.make (4)
						l_type.append (none_type_name)
					else
						create l_type.make (64)

							-- We disable assertion checking here because `l_value'.`generating_type' is
							-- a qualified call, if `l_value' has invariant violation, an exception will be thrown,
							-- causing the interpreter to generate an error. The invariant of `l_value' was violated
							-- indirectly by other objects.
							-- In this case, we don't want a failure here, we want a failure when we actually
							-- try to use `l_value'.
						b := {ISE_RUNTIME}.check_assert (False)
						l_type.append (l_value.generating_type.name)
						b := {ISE_RUNTIME}.check_assert (b)
					end
					print_line_and_flush (l_type)
				else
					report_error ({STRING} "Variable `v_" + l_index.out + "' not defined.")
				end
				log_message ("report_type_request end%N")
			else
				report_error (invalid_request_format_error)
			end

				-- Send response to the proxy.
			refresh_last_response_flag
			last_response := [output_buffer, error_buffer]
			send_response_to_socket
		end

	report_quit_request
		do
			should_quit := True
		end

	report_start_request
		do
		end

	report_execute_request
			-- Report execute request.
		require
			last_request_attached: last_request /= Void
			last_request_is_execute_request: last_request_type = execute_request_flag
		local
			l_bcode: detachable STRING
			l_cstring: C_STRING
		do
			if attached {TUPLE [l_byte_code: detachable STRING; l_data: detachable ANY]} last_request as l_last_request then
				l_bcode := l_last_request.l_byte_code
				if l_bcode = Void then
					report_error (byte_code_not_found_error)
				elseif l_bcode.count = 0 then
					report_error (byte_code_length_error)
				else
					log_message ("report_execute_request start%N")
						-- Inject received byte-code into byte-code array of Current process.
					create l_cstring.make (l_bcode)
					override_byte_code_of_body (
						byte_code_feature_body_id,
						byte_code_feature_pattern_id,
						l_cstring.item,
						l_bcode.count)

						-- Run the feature with newly injected byte-code.
					execute_protected
					log_message ("report_execute_request end%N")
				end
			else
				report_error (invalid_request_format_error)
			end

				-- Send response to the proxy.
			refresh_last_response_flag
			last_response := [output_buffer, error_buffer]
			send_response_to_socket
		end

	refresh_last_response_flag
			-- Refresh the value of `last_response_flag' according to current status.
		do
			if has_error then
				last_response_flag := internal_error_respones_flag
			elseif is_last_invariant_violated then
				last_response_flag := invariant_violation_on_entry_response_flag
			else
				last_response_flag := normal_response_flag
			end
		end

feature {NONE} -- Error Reporting

	report_error (a_reason: READABLE_STRING)
		require
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		do
			error_buffer.append ({STRING} "error: " + a_reason + "%N")
			has_error := True
		ensure
			has_error: has_error
		end

	log_internal_error (a_reason: STRING)
			-- Put `a_reason' in log file.
		require
			a_reason_attached: a_reason /= Void
			not_a_reason_is_empty: not a_reason.is_empty
		do
			log_file.put_string ("<error type='internal'>%N")
			log_file.put_string ("%T<reason>%N<![CDATA[%N")
			log_file.put_string_general (a_reason)
			log_file.put_string ("]]>%N</reason>%N")
			log_file.put_string ("</error>%N")
		end

feature {NONE} -- Logging

	log_file: PLAIN_TEXT_FILE
			-- Log file

	log_instance (an_object: detachable ANY)
			-- Log an XML representation of `an_object' to `log_file'.
		do
			log_message ("<instance<![CDATA[%N")
			if an_object = Void then
				log_message ("Void%N")
			else
				log_message (an_object.tagged_out)
			end
			log_message ("]]>%N</instance>%N")
		end

	log_message (a_message: READABLE_STRING_GENERAL)
			-- Log message `a_messgae' to `log_message'.
		require
			a_message_not_void: a_message /= Void
		do
			log_file.put_string_general (a_message)
		end

	report_trace
			-- Report trace information into `error_buffer'.
		require
--			has_exception: An exception happened before
		local
			l_buffer: like error_buffer
			l_exception_code: INTEGER
			l_recipient: like recipient_name
			l_recipient_class_name: like class_name
			l_tag: like tag_name
			l_trace: like exception_trace
			l_meaning: like meaning
		do
				-- Gather exception information.
			l_exception_code := exception
			l_meaning := meaning (l_exception_code)
			l_tag := tag_name
			l_recipient := recipient_name
			if attached class_name as l_class_name then
				l_recipient_class_name := l_class_name
			else
				l_recipient_class_name := "UNKNOWN_CLASS"
			end
			if attached exception_trace as l_exception_trace then
				l_trace := l_exception_trace
			else
				l_trace := "Unknown exception trace"
			end

			if l_meaning = Void then
				l_meaning := ""
			end
			if l_recipient = Void then
				l_recipient := ""
			end
			check l_class_name_not_void: l_recipient_class_name /= Void end
			if l_tag = Void then
				l_tag := ""
			end

				-- Print exception into buffer which will be transfered through socket to proxy.
			l_buffer := error_buffer
			l_buffer.append (l_exception_code.out)
			l_buffer.append_character ('%N')
			l_buffer.append (l_recipient)
			l_buffer.append_character ('%N')
			l_buffer.append (l_recipient_class_name)
			l_buffer.append_character ('%N')
			l_buffer.append (l_tag)
			l_buffer.append_character ('%N')
			l_buffer.append (is_last_invariant_violated.out)
			l_buffer.append_character ('%N')
			l_buffer.append (l_trace)

				-- Store exception into log file.
			log_message ("<call_result type='exception'>%N")
			log_message ({STRING_32} "%T<meaning value='" + l_meaning + "'/>%N")
			log_message ({STRING_32} "%T<tag value='" + l_tag + "'/>%N")
			log_message ("%T<recipient value='" + l_recipient + "'/>%N")
			log_message ("%T<class value='" + l_recipient_class_name + "'>%N")
			log_message ({STRING} "%T<invariant violation on entry='" + is_last_invariant_violated.out + "'>%N")
			log_message ("%T<exception_trace>%N<![CDATA[%N")
			log_message (l_trace)
			log_message ("]]>%N</exception_trace>%N")
			log_message ("</call_result>%N")
		end

feature {NONE} -- IO Buffer

	output_buffer: STRING_8
			-- Buffer used to store standard output from Current process
			-- Fixme: Should store standard error also, but due to an implementation
			-- limitation in STD_FILES, we cannot redirect standard error to a buffer.
			-- So stderr will be ignored for the moment. Jason 2008.10.18

	error_buffer: STRING
			-- Buffer to store error information (either interpreter error or exception trace from testee feature)
			-- Note: Error here does not mean standard error from testee feature, stderr error should be handled by
			-- `output_buffer'.

	wipe_out_buffer
			-- Clear `output_buffer' and `error_buffer'.
		do
			output_buffer.wipe_out
			error_buffer.wipe_out
		ensure
			output_buffer_cleared: output_buffer.is_empty
			error_buffer_cleared: error_buffer.is_empty
		end

	buffer_size: INTEGER = 4096
			-- Size in byte for `output_buffer'

feature {NONE} -- Socket IPC

	socket: NETWORK_STREAM_SOCKET
			-- Socket used for communitation between proxy and current interpreter

	last_request_type: NATURAL_32
			-- Type of the last request retrieved by `retrieve_request'.

	last_request: detachable ANY
			-- Last received request by `retrieve_request'
			-- `flag' indicates request type,
			-- `data' stores data needed for that reques type.

	last_response_flag: NATURAL_32
			-- Flag indicating the status of the response
			-- See {ITP_SHARED_CONSTANTS} for valid values

	last_response: detachable ANY
			-- Last response to be sent back to the proxy

	retrieve_request
			-- Retrieve request from proxy and store it in `last_request'.
			-- Blocking if no request is received.
			-- Close socket on error.
		require
			socket_attached: socket /= Void
			socket_open: socket.is_open_read
		local
			l_retried: BOOLEAN
		do
			last_request := Void
			last_response := Void
			is_last_invariant_violated := False

			if not l_retried then
					-- Get request from proxy through `socket'.
					-- This will block Current process.
				socket.read_natural_32
				last_request_type := socket.last_natural_32

				if attached {like last_request} retrieved_from_medium (socket) as l_request then
					last_request := l_request
				end
			end
		rescue
			l_retried := True
			last_request := Void
			if not socket.is_closed then
				socket.close
			end
			retry
		end

	send_response_to_socket
			-- Send response stored in `output_buffer' and `error_buffer' into `socket'.
			-- If error occurs, close `socket'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				socket.put_natural_32 (last_response_flag)
				if attached last_response as l_last_response then
					store_in_medium (l_last_response, socket)
				end
			end
		rescue
			l_retried := True
			has_error := True
			socket.close
			retry
		end

	print_line_and_flush (a_text: READABLE_STRING_8)
			-- Print `a_text' followed by a newline and flush output stream.
		require
			a_text_not_void: a_text /= Void
		do
			output_buffer.append (a_text)
			output_buffer.append_character ('%N')
		end

feature {NONE} -- Parsing

	parse
			-- Parse input and call corresponding handler routines (`report_*').
		require
			not_has_error: not has_error
		do
			if is_request_type_valid (last_request_type) then
				if last_request = Void then
					report_error ("Received data is not recognized as a request.")
				else
					inspect
						last_request_type
					when execute_request_flag then
						report_execute_request
					when type_request_flag then
						report_type_request

					when start_request_flag then
						report_start_request

					when quit_request_flag then
						report_quit_request
					end
				end
			else
				report_error (invalid_request_type_error)
			end
		end

feature {NONE} -- Object pool

	object_store: ITP_STORE
			-- Object store

feature {NONE} -- Byte code

	byte_code_feature_body_id: INTEGER
			-- ID for feature whose byte-code is to be injected

	byte_code_feature_pattern_id: INTEGER
			-- Pattern ID for feature whose byte-code is to be injected

	execute_protected
			-- Execute `procedure' in a protected way.
		local
			failed: BOOLEAN
		do
			is_last_protected_execution_successfull := False
			if not failed then
				execute_byte_code
				is_last_protected_execution_successfull := True
			end
		rescue
			failed := True
			report_trace
			if exception = Class_invariant then
					-- A class invariant cannot be recovered from since we
					-- don't know how many and what objects are now invalid
				should_quit := True
			end
			retry
		end

	execute_byte_code
			-- Execute test case
			-- The test case will be written as byte-code.
		local
			v_1: detachable STRING
		do
			v_1 := Void
		end

	store_variable_at_index	(a_object: ANY; a_index: INTEGER)
			-- Store `a_object' at `a_index' in `object_store'.
		do
			object_store.assign_value (a_object, a_index)
		end

	variable_at_index (a_index: INTEGER): detachable ANY
			-- Object in `object_store' at position `a_index'.
		do
			Result := object_store.variable_value (a_index)
		end

	main_loop
			-- Main loop
		do
			from
			until
				should_quit or else socket.is_closed
			loop
				wipe_out_buffer
				retrieve_request
				if not has_error then
					parse
				end
			end
		end

feature{NONE} -- Error message

	invalid_request_format_error: STRING = "Invalid request format."

	byte_code_not_found_error: STRING = "No byte-code is found in request."

	byte_code_length_error: STRING = "Length of retrieved byte-code is not the same as specified in request."

	invalid_request_type_error: STRING = "Request type is invalid."

feature{NONE} -- Invariant checking

	is_last_invariant_violated: BOOLEAN
			-- Is the class invariant violated when `check_invariant' is invoked
			-- the last time?

	check_invariant (o: detachable ANY)
			-- Check if the class invariant `o' is satisfied.
			-- If not satisfied, set `is_last_invariant_violated' to True
			-- and raise the exception.
			-- If satisfied, set `is_last_invariant_violated' to False.
			-- if `o' is detached, set `is_last_invariant_violated' to False and do nothing.
		do
			if attached {ANY} o as l_obj then
				l_obj.do_nothing
			end
		rescue
			is_last_invariant_violated := True
		end

invariant
	log_file_open_write: log_file.is_open_write
	store_not_void: object_store /= Void
	output_buffer_attached: output_buffer /= Void
	error_buffer_attached: error_buffer /= Void
	socket_attached: socket /= Void

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

