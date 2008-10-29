indexing
	description:

		"Parses interpreter responses from an input stream"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_STREAM_RESPONSE_PARSER

inherit

	AUT_RESPONSE_PARSER
		redefine
			make
		end

	AUT_SHARED_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Create new parser for interpreter responses.
		do
			Precursor (a_system)
			create {KL_STRING_INPUT_STREAM} input_stream.make ("")
		end

feature -- Access

	input_stream: KI_TEXT_INPUT_STREAM
			-- Input stream

	last_string: STRING
			-- Last string parsed

feature -- Settings

	set_input_stream (an_input_stream: like input_stream) is
			-- Set `input_stream' to `an_input_stream'.
		require
			an_input_stream_not_void: an_input_stream /= Void
		do
			input_stream := an_input_stream
		ensure
			input_stream_set: input_stream= an_input_stream
		end

feature  -- Parsing

	parse_invoke_response is
			-- Parse the response issued by the interpreter after a
			-- create-object/create-object-default/invoke-feature/invoke-and-assign-feature
			-- request has been sent.
		local
			output: STRING
		do
			create last_response_text.make (default_response_length)
			try_parse_multi_line_value
			if last_string = Void then
				parse_error
				if last_string = Void then
					create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
				else
					create {AUT_ERROR_RESPONSE} last_response.make (last_string.twin)
				end
			else
				output := last_string.twin
				parse_status
				if last_string = Void then
					create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
				else
					if is_status_success_message (last_string) then
						create {AUT_NORMAL_RESPONSE} last_response.make (output)
					else
						parse_exception
						if last_exception = Void then
							create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
						else
							create {AUT_NORMAL_RESPONSE} last_response.make_exception (output, last_exception)
						end
					end
				end
				if not last_response.is_bad then
					parse_done
					if last_string = Void then
						create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
					end
				end
			end
			last_response_text := Void
		ensure then
			last_response_not_void: last_response /= Void
		end


	parse_assign_expression_response  is
			-- Parse response issued by interpreter after receiving an
			-- assign-expresion request.
		do
			parse_invoke_response
--			create last_response_text.make (default_response_length)
--			try_parse_multi_line_value
--			if last_string = Void then
--				create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
--			else
--				parse_status
--				if last_string = Void then
--					create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
--				else
--					check is_status_success_message (last_string) end
--					parse_done
--					if last_string = Void then
--						create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
--					else
--						create {AUT_NORMAL_RESPONSE} last_response.make ("")
--					end
--				end
--			end
--			last_response_text := Void
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_type_of_variable_response is
			-- Parse response issued by interpreter after receiving a
			-- retrieve-type-of-variable request.
		local
			output: STRING
		do
			create last_response_text.make (default_response_length)
			parse_type_name
			if last_string = Void then
				create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
			else
				output := last_string.twin
				parse_status
				if last_string = Void then
					create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
				else
					parse_done
					if last_string = Void then
						create {AUT_BAD_RESPONSE} last_response.make (last_response_text)
					else
						create {AUT_NORMAL_RESPONSE} last_response.make (output)
					end
				end
			end
			last_response_text := Void
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_start_response is
			-- Parse the response issued by the interpreter after it has been
			-- started.
		do
		end

	parse_stop_response is
			-- Parse the response issued by the interpreter after it received a stop request.
		do
		end

	retrieve_response is
			-- Retrieve response from the interpreter,
			-- store it in `last_raw_response'.
		do
		end

feature {NONE} -- Implementation

	parse_empty_response is
			-- Parse a response consisting of no characters.
		do
		end

	parse_type_name is
			-- Parse type name and make it available via `las_string'.
			-- Set `last_string' to `Void' in case of error.
		require
			last_response_text_not_void: last_response_text /= Void
		do
			try_parse_multi_line_value
			if last_string /= Void then
				if base_type (last_string, interpreter_root_class) = Void then
					last_string := Void
				end
			end
		ensure
			result_or_error:
				last_string = Void or else
				(base_type (last_string, interpreter_root_class) /= Void)
		end

	parse_status is
			-- Parse "status:" response.
			-- Have `last_string' have the textual version of the parsed intput,
			-- or `Void' in case of an error.
		require
			last_response_text_not_void: last_response_text /= Void
		do
			try_read_line
			if last_string /= Void then
				if
					not is_status_success_message (last_string) and
					not is_status_exception_message (last_string)
				then
					last_string := Void
				end
			end
		ensure
			status_parsed_or_error: last_string = Void or else (is_status_success_message (last_string) or
									is_status_exception_message (last_string))
		end

	parse_error is
			-- Parse "error:" response.
			-- Have `last_string' have the error message,
			-- or `Void' in case of an error.
		require
			last_response_text_not_void: last_response_text /= Void
		do
			try_read_line
			if last_string /= Void and then (last_string.count > 5 and then last_string.substring (1, 6).is_equal ("error:")) then
				last_string.remove_head (6)
			end
		end

	parse_done is
			-- Parse "done:" response.
			-- Have `last_string' have the textual version of the parsed intput,
			-- or `Void' in case of an error.
		require
			last_response_text_not_void: last_response_text /= Void
		do
			try_read_line
			if last_string /= Void then
				if not last_string.is_equal ("done:") then
					last_string := Void
				end
			end
		end

	parse_exception is
			-- Parse an exception and make it available via `last_exception'.
			-- Set it to Void if there was an error parsing the exception.
		require
			last_response_text_not_void: last_response_text /= Void
		local
			exception_code: INTEGER
			exception_recipient_name: STRING
			exception_class_name: STRING
			exception_tag_name: STRING
			exception_trace: STRING
		do
			last_exception := Void
			try_read_line
			if last_string /= Void and then last_string.is_integer then
				exception_code := last_string.to_integer
				try_read_line
				if last_string /= Void then
					exception_recipient_name := last_string.twin
					try_read_line
					if last_string /= Void then
						exception_class_name := last_string.twin
						try_read_line
						if last_string /= Void then
							exception_tag_name := last_string.twin
							try_parse_multi_line_value
							if last_string /= Void then
								exception_trace := last_string.twin
								create last_exception.make (exception_code,
															exception_recipient_name,
															exception_class_name,
															exception_tag_name,
															exception_trace)
							end
						end
					end
				end
			end
		end

	try_parse_multi_line_value is
			-- Try to parse a multi line value. A multi line value starts
			-- with `multi_line_value_start_tag' and end with
			-- `multi_line_value_start_tag'. The content in between those
			-- tags is made available via `last_string'. If no multi line
			-- value could be read `last_string' is set to `Void'.
		require
			last_response_text_not_void: last_response_text /= Void
		local
			content: STRING
		do
			try_read_line
			if last_string /= Void then
				if last_string.is_equal (multi_line_value_start_tag) then
					from
						try_read_line
						create content.make (1024)
					until
						last_string = Void or else
						((last_string.count >= multi_line_value_end_tag.count and then
						 last_string.substring (last_string.count - multi_line_value_end_tag.count + 1,
															  last_string.count).is_equal (multi_line_value_end_tag)) or
							-- Do not even try to continue reading past a seg fault message, because
							-- in some cases the output can be infinte (loop).
						last_string.is_equal ("interpreter: PANIC: Unexpected harmful signal (Segmentation fault) ..."))

					loop
						content.append_string (last_string)
						content.append_character ('%N')
						try_read_line
					end
					if last_string /= Void and then last_string.count > multi_line_value_end_tag.count then
						content.append_string (last_string.substring (1, last_string.count - multi_line_value_end_tag.count))
					end
				end
			end
			last_string := content
		end

	ignore_lines (a_count: INTEGER) is
			-- Read `a_count' lines from input and
			-- ignore content.
		require
			last_response_text_not_void: last_response_text /= Void
			a_count_valid: a_count >= 1
		local
			i: INTEGER
		do
			from
				try_read_line
				i := 2
			until
				i > a_count or last_string = Void
			loop
				try_read_line
				if last_string /= Void then
					i := i + 1
				end
			end
		end

	try_read_line is
			-- Try to read a line from the input. Make resulting string
			-- available via `last_string' or set it to `Void' if no complete
			-- line could be read. Append  parsed text to `last_response_text'
		require
			last_response_text_not_void: last_response_text /= Void
		do
			if not input_stream.end_of_input then
				input_stream.read_line
				last_string := input_stream.last_string
				last_response_text.append_string (last_string)
				last_response_text.append_character ('%N')
			else
				last_string := Void
			end
		end

feature {NONE} -- Implementation

	last_exception: AUT_EXCEPTION
			-- Last exception parsed

	last_response_text: STRING
			-- Complete unparsed text of last response

	is_status_success_message (a_string: STRING): BOOLEAN is
			-- Is `a_string' a valid status message indicating success?
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.is_equal ("status: success")
		ensure
			definition: Result = a_string.is_equal ("status: success")
		end

	is_status_exception_message (a_string: STRING): BOOLEAN is
			-- Is `a_string' a valid status message indicating that an
			-- exception was thrown?
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.is_equal ("status: exception")
		ensure
			definition: Result = a_string.is_equal ("status: exception")
		end

	default_response_length: INTEGER is 1024

invariant

	input_stream_not_void: input_stream /= Void
	input_stream_open_read: input_stream.is_open_read

end
