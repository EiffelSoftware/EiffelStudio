indexing
	description:

		"Parses AutoTest log files and builds test case results"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_LOG_PARSER

inherit

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	EXCEP_CONST
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

	AUT_SHARED_CONSTANTS

	AUT_REQUEST_PROCESSOR

create
	make

feature {NONE} -- Initialization

	make (a_system: like system; an_error_handler: like error_handler) is
			-- Create new log file parser.
		require
			a_system_not_void: a_system /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			system := a_system
			error_handler := an_error_handler
			create variable_table.make (system)
			create response_parser.make (system)
			create request_parser.make (system, an_error_handler)
			create request_history.make (5000)
		ensure
			system_set: system = a_system
		end

feature -- Status report

	has_error: BOOLEAN
			-- Was an error detected during last parsing?

feature -- Access

	request_history: DS_ARRAYED_LIST [AUT_REQUEST]
			-- Requests as parsed in the log file;
			-- note that requests know their response too.

feature -- Parsing

	parse_stream (an_input_stream: KI_TEXT_INPUT_STREAM) is
			-- Parse log from `an_input_stream'.
			-- Save parsed requests along with their responses in `request_history'.
		require
			an_input_stream_not_void: an_input_stream /= Void
			an_input_stream_open_read: an_input_stream.is_open_read
		local
			line: STRING
		do
			found_request_count := 0
			reported_request_count := 0
			request_parser.set_filename (an_input_stream.name)
			from
				has_error := False
				create last_response_text.make (default_response_length)
				variable_table.wipe_out
				line_number := 1
			until
				an_input_stream.end_of_input or has_error
			loop
				an_input_stream.read_line
					-- We ignore empty lines.
				if not an_input_stream.last_string.is_empty then
					line := an_input_stream.last_string.twin

					if line.count >= 2 and then line.substring (1, 2).same_string ("--") then
							-- We are in the comment line. If this line matches the start request,
							-- the start request will be handled, otherwise, the line is ignored.
						if line.same_string (proxy_has_started_and_connected_message) then
							-- We are in the "start" request.
							report_request_line (line)
						end
					else
						if line.count >= interpreter_log_prefix.count and then line.substring (1, interpreter_log_prefix.count).same_string (interpreter_log_prefix) then
								-- We are inside a response comment-block
							report_response_line (line)
						else
								-- Report that some request other than "start" request is found in current line.
							report_request_line (line)
						end
					end
				end
				line_number := line_number + 1
			end
			if found_request_count = reported_request_count + 1 then
				report_last_request
			end
		end

feature {NONE} -- Reporting

	report_response_line (a_line: STRING) is
			-- Report that `a_line' of response from interpreter is found.
		require
			a_line_attached: a_line /= Void
			a_line_valid: a_line.count >= interpreter_log_prefix.count and then a_line.substring (1, interpreter_log_prefix.count).same_string (interpreter_log_prefix)
			last_response_attached: last_response_text /= Void
		do
			if a_line.count > interpreter_log_prefix.count then
				last_response_text.append_string (a_line.substring (interpreter_log_prefix.count + 1, a_line.count))
			end
			last_response_text.append_character ('%N')
		end

	report_request_line (a_line: STRING) is
			-- Report that `a_line' of some type of request is found.
			-- This request should not be a "start" request.
		require
			a_line_attached: a_line /= Void
			not_a_line_is_empty: not a_line.is_empty
			last_response_attached: last_response_text /= Void
		do
			if request_parser.last_request /= Void then
					-- We found another request, so we need to report the last one we found,
					-- along with its response.
				report_last_request
				last_response_text.wipe_out
			end

				-- Now we parse the newly found request line.
			request_parser.set_line_number (line_number)
			request_parser.set_input (a_line)
			request_parser.parse

			has_error := request_parser.has_error
			if not has_error then
				found_request_count := found_request_count + 1
			end
		end

	report_last_request is
			-- Report `last_request' in `request_parser'.
		require
			last_request_exists: request_parser.last_request /= Void
		do
			request_history.force_last (request_parser.last_request)
			request_parser.last_request.process (Current)
			reported_request_count := reported_request_count + 1
		end

feature {NONE} -- Processsing

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if last_response_text.is_empty then
				create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
			else
				create l_response_stream.make (last_response_text)
				response_parser.set_input_stream (l_response_stream)
				response_parser.parse_invoke_response
				l_last_response := response_parser.last_response
				if l_last_response.is_normal then
					if not l_last_response.is_exception then
						variable_table.define_variable (a_request.target, a_request.target_type)
					end
				end
			end
			a_request.set_response (l_last_response)
		end

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			check last_response_text.is_empty end
			a_request.set_response (create {AUT_NORMAL_RESPONSE}.make (""))
			variable_table.wipe_out
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		local
			l_last_response: AUT_RESPONSE
		do
			if last_response_text.is_empty then
				create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
			else
				create {AUT_NORMAL_RESPONSE} l_last_response.make (last_response_text)
			end
			a_request.set_response (l_last_response)
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if last_response_text.is_empty then
				create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
			else
				if variable_table.is_variable_defined (a_request.target) then
					a_request.set_target_type (variable_table.variable_type (a_request.target))
				end
				create l_response_stream.make (last_response_text)
				response_parser.set_input_stream (l_response_stream)
				response_parser.parse_invoke_response
				l_last_response := response_parser.last_response
			end
			a_request.set_response (l_last_response)
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if last_response_text.is_empty then
				create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
			else
				create l_response_stream.make (last_response_text)
				response_parser.set_input_stream (l_response_stream)
				response_parser.parse_assign_expression_response
				l_last_response := response_parser.last_response
			end
			a_request.set_response (l_last_response)
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if last_response_text.is_empty then
				create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
			else
				create l_response_stream.make (last_response_text)
				response_parser.set_input_stream (l_response_stream)
				response_parser.parse_type_of_variable_response
				l_last_response := response_parser.last_response
				if l_last_response.is_normal then
					if not l_last_response.is_exception then
						variable_table.define_variable (
							a_request.variable,
							base_type (l_last_response.text))
					end
				end
				l_last_response := response_parser.last_response
			end
			a_request.set_response (l_last_response)
		end

feature{NONE} -- Implementation

	found_request_count: INTEGER
			-- Number of found requests.

	reported_request_count: INTEGER
			-- Number of reported requests.

	variable_table: AUT_VARIABLE_TABLE
			-- Table that maps variables to their types

	line_number: INTEGER
			-- Current line number in the log file

	system: SYSTEM_I
			-- system

	request_parser: AUT_REQUEST_PARSER
			-- Request parser

	response_parser: AUT_STREAM_RESPONSE_PARSER
			-- Response parser

	default_response_length: INTEGER is 1024
			-- Default length in byte for `last_response_text'

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	last_response_text: STRING
			-- Last found response from interpreter

invariant
	system_attached: system /= Void
	error_handler_attached: error_handler /= Void
	request_parser_not_void: request_parser /= Void
	response_parser_not_void: response_parser /= Void
	variable_table_not_void: variable_table /= Void
	request_history_not_void: request_history /= Void
	no_void_request_in_history: not request_history.has (Void)
--	last_start_index_large_enough: last_start_index >= 1 -- TODO: reenable and fix bug! (inv does not hold before processing and after start request)
--	last_start_index_small_enough: last_start_index <= request_history.count -- TODO: reenable and fix bug! (inv does not hold before processing and after start request)

end
