note
	description:

		"Parses AutoTest log files and passes requests/responses to an {AUT_PROXY_EVENT_OBSERVER}"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_LOG_PARSER

inherit
	AUT_PROXY_EVENT_PRODUCER
		rename
			make as make_producer
		end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	EXCEP_CONST
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

	AUT_SHARED_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_system: like system; an_error_handler: like error_handler)
			-- Create new log file parser.
		require
			a_system_not_void: a_system /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			make_producer

			system := a_system
			error_handler := an_error_handler
			create response_parser.make (system)
			create request_parser.make (system, an_error_handler)
		ensure
			system_set: system = a_system
		end

feature -- Status report

	has_error: BOOLEAN
			-- Was an error detected during last parsing?

	is_executing: BOOLEAN = False
			-- <Precursor>

	is_replaying: BOOLEAN do end
			-- <Precursor>

feature -- Parsing

	parse_stream (an_input_stream: KI_TEXT_INPUT_STREAM)
			-- Parse log from `an_input_stream'.
			-- Save parsed requests along with their responses in `request_history'.
		require
			an_input_stream_not_void: an_input_stream /= Void
			an_input_stream_open_read: an_input_stream.is_open_read
		local
			line: STRING
		do
			request_parser.set_filename (an_input_stream.name)
			from
				has_error := False
				create last_response_text.make (default_response_length)
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
		end

feature {NONE} -- Reporting

	report_response_line (a_line: STRING)
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

	report_request_line (a_line: STRING)
			-- Report that `a_line' of some type of request is found.
			-- This request should not be a "start" request.
		require
			a_line_attached: a_line /= Void
			not_a_line_is_empty: not a_line.is_empty
			last_response_attached: last_response_text /= Void
		local
			l_response_stream: KL_STRING_INPUT_STREAM
			l_last_response: detachable AUT_RESPONSE
		do
				-- Report previously received response if any
			if attached last_response_text as l_response_text and then not l_response_text.is_empty then
				create l_response_stream.make (l_response_text)
				response_parser.set_input_stream (l_response_stream)
				response_parser.parse_invoke_response
				l_last_response := response_parser.last_response
				check l_last_response /= Void end
				report_event (l_last_response)

				last_response_text.wipe_out
			end

				-- Now we parse the newly found request line.
			request_parser.set_line_number (line_number)
			request_parser.set_input (a_line)
			request_parser.parse

			has_error := request_parser.has_error
			if not has_error and attached request_parser.last_request as l_last_request then
				report_event (l_last_request)
			end
		end

feature{NONE} -- Implementation

	line_number: INTEGER
			-- Current line number in the log file

	system: SYSTEM_I
			-- system

	request_parser: AUT_REQUEST_PARSER
			-- Request parser

	response_parser: AUT_STREAM_RESPONSE_PARSER
			-- Response parser

	default_response_length: INTEGER = 1024
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
--	last_start_index_large_enough: last_start_index >= 1 -- TODO: reenable and fix bug! (inv does not hold before processing and after start request)
--	last_start_index_small_enough: last_start_index <= request_history.count -- TODO: reenable and fix bug! (inv does not hold before processing and after start request)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
