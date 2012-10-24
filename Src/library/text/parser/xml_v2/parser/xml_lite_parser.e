note
	description : "[
			Simple XML parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
			
			check: http://www.w3.org/TR/REC-xml/
		]"
	warning: "[
					<!DOCTYPE ..> is parsed but not used
					<!ENTITY ..> are not supported yet
			]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_LITE_PARSER

inherit
	XML_PARSER

create
	make,
	make_ascii,
	make_unicode

feature {NONE} -- Initialization

	make
			-- Instanciate Current
		obsolete
			"Use make_ascii or make_unicode [2012-oct]"
		do
			make_ascii
		end

	make_ascii
			-- Instanciate Current
		do
			make_unicode
			enable_string_8_compatibility
		end

	make_unicode
			-- Instanciate Current with unicode support
			-- i.e: passing instance of STRING_32 in callbacks	
		do
			create {XML_CALLBACKS_NULL} callbacks.make
			buffer := empty_buffer
		end

feature -- Parsing

	parse_from_stream (a_stream: XML_INPUT_STREAM)
			-- Parse stream `a_stream'
		do
			buffer := a_stream
			parse
			buffer := empty_buffer
		end

	parse_from_string (a_string: STRING)
			-- Parse string `a_string'
		local
			s: XML_STRING_INPUT_STREAM
		do
			create s.make (a_string)
			s.start
			parse_from_stream (s)
			s.close
		end

	parse_from_file (a_file: FILE)
			-- Parse from file `a_file'
		local
			s: XML_FILE_INPUT_STREAM
		do
			create s.make (a_file)
			s.compute_smart_chunk_size (a_file.count, 0x4000)
			s.start
			parse_from_stream (s)
			s.close
		end

	parse_from_filename (a_filename: READABLE_STRING_GENERAL)
			-- Parse from file named `a_filename'
		local
			f: detachable FILE
			retried: BOOLEAN
			u: FILE_UTILITIES
		do
			if not retried then
				f := u.make_text_file (a_filename)
				if f.exists and f.is_readable then
					f.open_read
					parse_from_file (f)
					f.close
				else
					report_error ({STRING_32} "Unable to open file %"" + a_filename.to_string_32 + {STRING_32} "%".")
				end
			else
				report_error ({STRING_32} "Error when trying to open file %"" + a_filename.to_string_32 + {STRING_32} "%".")
				if f /= Void and then not f.is_closed then
					f.close
				end
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature -- Access

	callbacks: XML_CALLBACKS
			-- Callbacks event interface to which events are forwarded

feature -- Settings

	string_8_compatibility_enabled: BOOLEAN
			-- Is string_8_callbacks enabled?
			-- i.e: instance of STRING_8 are passed to callbacks instead of STRING_32

	enable_string_8_compatibility
			-- Enable `string_8_callbacks'
		local
			cb: XML_STRING_8_FORWARD_CALLBACKS
		do
			create cb.make (callbacks)
			callbacks := cb
			string_8_compatibility_enabled := True
		end

	disable_string_8_compatibility
			-- Disable `string_8_callbacks'
		do
			if attached {XML_STRING_8_FORWARD_CALLBACKS} callbacks as cb8 then
				callbacks := cb8.callbacks
			else
				check string_8_compatibility_enabled: False end
			end
			string_8_compatibility_enabled := False
		end

feature -- Element change

	set_callbacks (a_callbacks: like callbacks)
			-- Set `callbacks' to `a_callbacks'.
		do
			if string_8_compatibility_enabled then
				if attached {XML_STRING_8_FORWARD_CALLBACKS} callbacks as cb8 then
					cb8.set_callbacks (a_callbacks)
				else
					check string_8_compatibility_enabled: False end
				end
			else
				callbacks := a_callbacks
			end
		ensure then
			callbacks_set: (string_8_compatibility_enabled implies (attached {XML_STRING_8_FORWARD_CALLBACKS} callbacks as cb8 and then cb8.callbacks = a_callbacks)) or
					callbacks = a_callbacks
		end

feature -- Parsing status

	parsing_stopped: BOOLEAN
			-- Parsing stopped?
			--| by `stop_request' or `error_occurred'

	error_occurred: BOOLEAN
			-- Error occurred?
		do
			Result := error_position /= Void
		end

feature -- Status		

	error_message_32: detachable STRING_32
			-- Error message

	error_position: detachable XML_POSITION
			-- Position when error occurred

	position: XML_POSITION
			-- Logical position
		do
			if attached checkpoint_position as p then
				Result := p
			else
				Result := buffer_position
			end
		end

	buffer_position: XML_POSITION
			-- XML position in buffer
		do
			create Result.make (buffer.name, byte_index, column, line)
		end

	byte_index: INTEGER
			-- Byte index
		do
			Result := buffer.index
		end

	line: INTEGER
			-- Last line number
		do
			Result := buffer.line
		end

	column: INTEGER
			-- Last column number
		do
			Result := buffer.column
		end

feature -- Element change

	reset
			-- Reset parser states
		do
			last_character := '%U'
			rewinded_character := '%U'
			parsing_stopped := False
			error_position := Void
			error_message_32 := Void
		ensure
			error_message_void: error_message_32 = Void
			error_position_void: error_position = Void
			error_occurred_unset: not error_occurred
		end

feature {NONE} -- Access

	buffer: XML_INPUT_STREAM
			-- Internal buffer

feature {NONE} -- Implementation

	checkpoint_position: detachable XML_POSITION
		do
		end

	set_checkpoint_position
		do
			-- do nothing, can be used to improve error positioning
		end

	unset_checkpoint_position
		do
			-- do nothing, can be used to improve error positioning
		end

feature {NONE} -- Implementation: parse

	parse
			-- Parse `buffer'
		local
			c: CHARACTER
			l_content: STRING_32
			l_in_prolog: BOOLEAN
			buf: like buffer
			l_callbacks: like callbacks
			l_ignore_non_printable_char: BOOLEAN
		do
			reset
			buf := buffer
			l_callbacks := callbacks
			l_ignore_non_printable_char := True

			l_callbacks.on_start
			from
				l_in_prolog := True
				create l_content.make_empty
			until
				parsing_stopped or buf.end_of_input
			loop
				c := next_character
				inspect
					c
				when '<' then
					if l_in_prolog then
						l_ignore_non_printable_char := False
						if not is_blank (l_content) then
							report_unexpected_content_in_prolog (l_content)
						end
						l_content.wipe_out
					else
						if not l_content.is_empty then
							l_callbacks.on_content (l_content.string)
							l_content.wipe_out
						end
					end
					c := next_character
					inspect c
					when '?' then
						parse_processing_instruction
					when '/' then
						parse_end_tag
					when '!' then
						c := next_character
						inspect c
						when '-' then
							rewind_character
							parse_comment
						when '[' then
							rewind_character
							parse_cdata
						when 'D' then
							rewind_character
							parse_doctype
						else
							report_error ("syntax error")
						end
					else
						rewind_character
						l_in_prolog := False
						parse_start_tag
					end
				when '&' then
					l_content.append_string (next_entity)
				else
						-- Ignore non printable character on top of XML document.
					if
						l_in_prolog and then
						l_ignore_non_printable_char and not c.is_printable
					then
						-- Ignore non printable char in prolog
					else
						l_content.append_character (c)
					end
				end
			end
			if not parsing_stopped then
				-- Remaining content when parsing is completed
				if not l_content.is_empty and then not is_blank (l_content) then
						-- It is likely to be an error, but for specific usage, let's be flexible
					l_callbacks.on_content (l_content.string)
					l_content.wipe_out
				end
				l_callbacks.on_finish
			end
		end

	parse_start_tag
			-- Parse for start tag.
		local
			t: like next_tag
			c: like last_character
			att: like next_attribute_data
			done: BOOLEAN
			l_callbacks: like callbacks
		do
			t := next_tag
			l_callbacks := callbacks
			l_callbacks.on_start_tag (Void, t.prefix_part, t.local_part)
			c := current_character
			if c.is_space then
				c := next_non_space_character
			end
			inspect
				c
			when '>' then
				l_callbacks.on_start_tag_finish
			when '/' then
				c := next_character
--				c := next_non_space_character -- more flexible?
				if c = '>' then
					l_callbacks.on_start_tag_finish
					l_callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
				else
					report_error ("unexpected character '" + character_output (c) + "' after closing / in start tag")
				end
			else
				rewind_character
				from
					done := False
				until
					done or parsing_stopped
				loop
					att := next_attribute_data
					if att /= Void then
						l_callbacks.on_attribute (Void, att.prefix_part, att.local_part, att.value)
						rewind_character
					else
						c := current_character
						inspect c
						when '>' then
							l_callbacks.on_start_tag_finish
						when '/' then
							c := next_character
--							c := next_non_space_character -- more flexible?							
							if c = '>' then
								done := True
								l_callbacks.on_start_tag_finish
								l_callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
							else
								report_error ("unexpected character '" + character_output (c) + "' after closing / in start tag")
							end
						else
							report_error ("unexpected character '" + character_output (c) + "' in start tag")
						end
						done := True
					end
				end
			end
		end

	parse_end_tag
			-- Parse for end tag
		local
			t: like next_tag
			c: like last_character
		do
			t := next_tag
			c := current_character
			if c.is_space then
				c := next_non_space_character
			end
			if c = '>' then
				callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
			else
				report_error ("unexpected character '" + character_output (c) + "' in end tag")
			end
		end

	parse_declaration
			-- Parse for xml declaration
		local
			c: like last_character
			l_version, l_encoding: detachable READABLE_STRING_GENERAL
			l_standalone: BOOLEAN
			l_name: READABLE_STRING_GENERAL
			done: BOOLEAN
			att: like next_attribute_data
		do
			l_standalone := True
			if not parsing_stopped then
				c := current_character
				if c.is_space then
					c := next_non_space_character
				end
				inspect
					c
				when '?' then
--					c := next_non_space_character -- more flexible?
					c := next_character
					if c = '>' then
						if l_version /= Void then
							callbacks.on_xml_declaration (l_version, l_encoding, l_standalone)
						else
							report_error ("missing version in xml declaration")
						end
					else
						report_error ("unexpected character '" + character_output (c) + "' after closing ? in xml declaration")
					end
				else
					rewind_character
					from
						done := False
					until
						done or parsing_stopped
					loop
						att := next_attribute_data
						if att /= Void then
							l_name := att.local_part
							if l_name.is_valid_as_string_8 and then attached l_name.to_string_8 as l_name_8 then
								if case_insensitive_same_string_8 (l_name_8, str_version) then
									l_version := att.value
								elseif case_insensitive_same_string_8 (l_name_8, str_encoding) then
									l_encoding := att.value
								elseif case_insensitive_same_string_8 (l_name_8, str_standalone) then
									l_standalone := True
								else
									report_error ("unknown xml declaration attribute [" + l_name_8 + "]")
								end
							else
								report_error ({STRING_32} "unknown xml declaration attribute [" + l_name.to_string_32 + {STRING_32} "]")
							end
							rewind_character
						else
							c := current_character
							inspect c
							when '?' then
								c := next_non_space_character
								if c = '>' then
									done := True
									if l_version /= Void then
										callbacks.on_xml_declaration (l_version, l_encoding, l_standalone)
									else
										report_error ("missing version in xml declaration")
									end
								else
									report_error ("unexpected character '" + character_output (c) + "' after closing ? in xml declaration")
								end
							else
							end
							done := True
						end
					end
				end
			end
		end

	parse_processing_instruction
			-- Parse for  <?pi .... ?>
		local
			c: CHARACTER
			n, s: STRING_32
			done: BOOLEAN
		do
			c := next_character
			from
				create n.make (6)
			until
				c.is_space or c = '?'
			loop
				n.append_character (c)
				c := next_character
			end
			if n.is_empty then
				rewind_character
				report_error ("Invalid processing instruction syntax <?" + c.out)
			elseif n.is_case_insensitive_equal (str_xml) then
				parse_declaration
			else
				create s.make_empty
				from
					c := next_character
				until
					done or parsing_stopped
				loop
					if c = '?' then
						c := next_character
						if c = '>' then
							done := True
						elseif c = '?' then
							s.append_character ('?')
						else
							s.append_character ('?')
							s.append_character (c)
							c := next_character
						end
					else
						s.append_character (c)
						c := next_character
					end
				end
				if parsing_stopped then
					report_error ("could not find end of Processing Instruction")
				else
					callbacks.on_processing_instruction (n, s)
				end
			end
		end

	parse_cdata
			-- Parse for [CDATA[ ..... ]]>
		local
			c: like last_character
			s: STRING_32
			done: BOOLEAN
		do
			c := next_character
			if c /= '[' then
				report_error ("invalid syntax <!" + c.out)
			else
				c := next_character
				from
					create s.make (6)
				until
					c = '['
				loop
					s.append_character (c.as_upper)
					c := next_character
				end
				if s.same_string_general (str_cdata) then
					s.wipe_out
					from
						c := next_character
					until
						done or parsing_stopped
					loop
						if c = ']' then
							c := next_character
							if c = ']' then
								c := next_character
								if c = '>' then
									done := True
								elseif c = '-' then
									s.append_character (']')
									rewind_character
								else
									s.append_character (']')
									s.append_character (']')
									s.append_character (c)
									c := next_character
								end
							else
								s.append_character (']')
								s.append_character (c)
								c := next_character
							end
						else
							s.append_character (c)
							c := next_character
						end
					end
					if parsing_stopped then
						report_error ("could not find end of CDATA content")
					else
						callbacks.on_content (s)
					end
				else
					report_error ({STRING_32} "invalid syntax <![" + s)
				end
			end
		end

	parse_comment
			-- Parse for comment
		local
			c: CHARACTER
			s: like new_string_comment_value
			done: BOOLEAN
		do
			c := next_character
			if c /= '-' then
				report_error ("invalid comment syntax")
			else
				c := next_character
				if c /= '-' then
					report_error ("invalid comment syntax")
				else
						-- Start comment
					create s.make_empty

					from
						c := next_character
					until
						done or parsing_stopped
					loop
						if c = '-' then
							c := next_character
							if c = '-' then
								c := next_character
								if c = '>' then
									done := True
								elseif c = '-' then
									s.append_character ('-')
									rewind_character
								else
									s.append_character ('-')
									s.append_character ('-')
									s.append_character (c)
									c := next_character
								end
							else
								s.append_character ('-')
								s.append_character (c)
								c := next_character
							end
						else
							s.append_character (c)
							c := next_character
						end
					end
					if parsing_stopped then
						report_error ("could not find end of comment")
					else
						callbacks.on_comment (s)
					end
				end
			end
		end

	parse_doctype
			-- Parse for [CDATA[ ..... ]]>
			--| 	<!DOCTYPE note SYSTEM "Note.dtd">
			--|		<!DOCTYPE note [
			--|		  <!ELEMENT note (to,from,heading,body)>
			--|		  <!ELEMENT to      (#PCDATA)>
			--|		  <!ELEMENT from    (#PCDATA)>
			--|		  <!ELEMENT heading (#PCDATA)>
			--|		  <!ELEMENT body    (#PCDATA)>
			--|		]>
		local
			c: CHARACTER
			s: STRING_32
			l_depth: INTEGER
			in_double_quote: BOOLEAN
			done: BOOLEAN
		do
			c := next_character
			if c /= 'D' then
				report_error ("invalid syntax <!" + c.out)
			else
				from
					create s.make (6)
				until
					c.is_space or c = '>'
				loop
					s.append_character (c.as_upper)
					c := next_character
				end
				if s.same_string_general (str_doctype) then
					create s.make_empty
					from
						c := next_character
					until
						done or parsing_stopped
					loop
						if in_double_quote then
							if c = '"' then
								in_double_quote := False
							end
							s.append_character (c)
							c := next_character
						else
							inspect c
							when '"' then
								in_double_quote := True
								s.append_character (c)
								c := next_character
							when '<' then
								l_depth := l_depth + 1
								s.append_character (c)
								c := next_character
							when '>' then
								if l_depth = 0 then
									-- Final '>'
									done := True
								else
									-- Closing inner "< ... >"
									l_depth := l_depth - 1
									s.append_character (c)
									c := next_character
								end
							else
								s.append_character (c)
								c := next_character
							end
						end
					end
					if parsing_stopped then
						report_error ("could not find end of DOCTYPE content")
					else
						register_doctype (s)
					end
				else
					report_error ({STRING_32} "invalid syntax <!" + s)
				end
			end
		end

	report_error (a_message: READABLE_STRING_GENERAL)
			-- Report error with message `a_message'
		require
			a_message_attached: a_message /= Void
		local
			s: STRING_32
			p: like position
		do
			p := position
			unset_checkpoint_position

			create s.make (a_message.count)
			s.append_string_general (a_message)

			error_message_32 := s.twin

			s.append_character (' ')
			s.append_character ('(')
			s.append_string ({STRING_32} "position=")
			s.append_string (p.to_string_32)

			debug ("xml_parser")
				io.put_string (s.as_string_8) -- FIXME: unicode
				io.put_new_line
			end

			if error_position = Void then
					-- record only first error's position
				error_position := p
			end
			parsing_stopped := True

			callbacks.on_error (s)
		ensure
			error_occurred: error_occurred
		end

	report_unexpected_content (a_content: STRING)
			-- Report unexpected content `a_content'
		do
			report_error ("Unexpected content (not well-formed XML)")
		end

	report_unexpected_content_in_prolog (a_content: READABLE_STRING_GENERAL)
			-- Report unexpected content `a_content' in prolog
		do
			report_error ("Unexpected content in prolog (not well-formed XML)")
		end

feature {NONE} -- Doctype

	register_doctype (s: READABLE_STRING_GENERAL)
			-- DOCTYPE declaration
		do
			--| Do nothing in this simple XML parser
		end

feature {XML_CALLBACKS} -- Error

	report_error_from_callback (a_msg: READABLE_STRING_GENERAL)
			-- Report error from callbacks
		do
			report_error (a_msg)
		end

feature {NONE} -- Query

	last_character: CHARACTER
			-- Last read character

	rewinded_character: like last_character
			-- Last character put in stack

	current_character: like last_character
			-- Current character
		do
			Result := rewinded_character
			if Result = '%U' then
				Result := last_character
			end
		end

	rewind_character
			-- Rewind by 1 character
		require
			rewinded_character_null: rewinded_character = '%U'
		do
			rewinded_character := last_character
		ensure
			rewinded_character_valid: rewinded_character /= '%R'
		end

	next_character: like last_character
			-- Return next character
			-- move index
		local
			buf: like buffer
		do
			Result := rewinded_character
			if Result = '%U' then
				buf := buffer
				if not buf.end_of_input then
					Result := internal_read_character (buf)
				else
					report_error ("no more characters")
				end
			else
				rewinded_character := '%U'
			end
			last_character := Result
		end

	internal_read_character (buf: like buffer): like last_character
			-- Internal implementation of `next_character'
			--| always called by `next_character'
		require
			buf_attached: buf /= Void
			buf_not_end_of_input: not buf.end_of_input
		do
			buf.read_character
			Result := buf.last_character
			if Result = '%R' then
				from
				until
					Result /= '%R' or buf.end_of_input
				loop
					buf.read_character
					Result := buf.last_character
				end
			end
		end

	next_non_space_character: like last_character
			-- Return next character which is not a space
			-- move index
		do
			from
				Result := next_character
			until
				not Result.is_space
			loop
				Result := next_character
			end
		ensure
			not_a_space: not Result.is_space
		end

	next_tag: TUPLE [prefix_part: detachable STRING_32; local_part: STRING_32]
			-- Return next tag value
			-- move index
		local
			c: like last_character
			p: detachable like new_string_tag
			s: like new_string_tag
		do
			s := new_string_tag

			from
				c := next_non_space_character
			until
				not valid_tag_character (c)
			loop
				if c = ':' and p = Void then
					p := s.string
					s.wipe_out
				else
					s.append_character (c)
				end
				c := next_character
			end
			Result := [p, s.string]
			s.wipe_out
		ensure
			new_string_tag_is_empty: new_string_tag.is_empty
		end

	next_entity: STRING_32
			-- Return next entity value
			-- move index
		local
			c: CHARACTER
			is_char: BOOLEAN
			is_hexa: BOOLEAN
			s: STRING_8
		do
			create s.make_empty
			c := next_character
			if c = '#' then
				is_char := True
				c := next_character
				if c = 'x' then
					is_hexa := True
					c := next_character
				end
			end
			if is_char then
				if is_hexa then
					from
					until
						not c.is_hexa_digit or c = ';'
					loop
						s.append_character (c)
						c := next_character
					end
				else
					from
					until
						not c.is_digit or c = ';'
					loop
						s.append_character (c)
						c := next_character
					end
				end
			else
				from
				until
					not valid_entity_character (c) or c = ';'
				loop
					s.append_character (c)
					c := next_character
				end
			end
			if c = ';' then
				if is_char then
					if is_hexa then
						create Result.make (1)
						Result.append_code (hexa_string_to_natural_32 (s))
					elseif s.is_integer then
						create Result.make (1)
						Result.append_code (s.to_natural_32)
					else
						create Result.make (s.count + 2)
						Result.append_character ('&')
						Result.append_string_general (s)
						Result.append_character (';')
					end
				else
					Result := resolved_entity (s)
				end
			else
				rewind_character
				create Result.make (s.count + 2)
				Result.append_character ('&')
				Result.append_string_general (s)
				report_error ("Invalid entity syntax " + s)
			end
		end

	next_attribute_name: TUPLE [prefix_part: detachable READABLE_STRING_GENERAL; local_part: READABLE_STRING_GENERAL]
			-- Return next attribute prefix and local part.
			-- move index
		local
			c: like last_character
			n: like new_string_attribute_name
			p: INTEGER
		do
			n := new_string_attribute_name

			from
				c := next_non_space_character
			until
				not valid_name_character (c)
			loop
				n.append_character (c)
				c := next_character
			end
			p := n.index_of (':', 1)
			if p > 1 then
				Result := [n.substring (1, p - 1), n.substring (p + 1, n.count)]
			else
				Result := [Void, n.string]
			end
			n.wipe_out
		ensure
			new_string_attribute_name_is_empty: new_string_attribute_name.is_empty
		end

	next_attribute_value: READABLE_STRING_GENERAL
			-- Return next attribute's value
			-- move index
		local
			c: CHARACTER
			l_in_double_quote: BOOLEAN
			l_in_single_quote: BOOLEAN
			done: BOOLEAN
			s: like new_string_attribute_value
		do
			s := new_string_attribute_value
--FIXME  var='foo " bar'  is valid !
			c := next_character
			if c = '"' then
				l_in_double_quote := True
				c := next_character
			elseif c = '%'' then
				l_in_single_quote := True
				c := next_character
			elseif c.is_space then
				report_error ("unexpected space after = in attribute declaration")
			else
				--| We could be more strict, but let's allow attrib=value .. in addition to attrib="value"
			end

			if not parsing_stopped then
				from
					done := False
				until
					done or parsing_stopped
				loop
					if not l_in_double_quote and not l_in_single_quote and c.is_space then
						done := True
					else
						inspect c
						when '&' then
							s.append_string (next_entity)
						when '"' then
							if l_in_double_quote then
								done := True
							elseif l_in_single_quote then
								s.append_character (c)
							else
								report_error ("unexpected %" in attribute value")
							end
						when '%'' then
							if l_in_single_quote then
								done := True
							elseif l_in_double_quote then
								s.append_character (c)
							else
								report_error ("unexpected %' in attribute value")
							end
						else
							s.append_character (c)
						end
						c := next_character
					end
				end
			end
			if parsing_stopped then
				create {STRING_32} Result.make_empty
			else
				Result := s.string
			end
			s.wipe_out
		ensure
			new_string_attribute_value_is_empty: new_string_attribute_value.is_empty
		end

	next_attribute_data: detachable TUPLE [prefix_part: detachable READABLE_STRING_GENERAL; local_part: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]
			-- Return next attribute's data (prefix,local and value)
			-- move index
		local
			c: like last_character
			n: READABLE_STRING_GENERAL
			p, v: detachable READABLE_STRING_GENERAL
			l_was_space: BOOLEAN
			att_name: like next_attribute_name
		do
			att_name := next_attribute_name
			n := att_name.local_part
			p := att_name.prefix_part
			if not n.is_empty then
				c := current_character
				set_checkpoint_position --| record potential error position
				if c.is_space then
					l_was_space := True
					c := next_non_space_character -- FIXME: strict?
				end
				if c = '=' then
					-- now looking for value
					unset_checkpoint_position
				elseif l_was_space then
					-- no value FIXME: strict?
					-- we do not allow attribute without value
					report_error ("Attributes without any value are forbidden")
					Result := [p, n, ""]
				else -- not l_was_space
					report_error ("unexpected character '" + character_output (c) + "' in attribute name")
				end
				if Result = Void and not parsing_stopped then
					check
						c_is_equal_sign: c = '='
					end
					set_checkpoint_position
					c := next_character
					if c.is_space then
						c := next_non_space_character
					end
					rewind_character
					v := next_attribute_value
					if v = Void then
						report_error ({STRING_32} "attribute '" + n.to_string_32 + {STRING_32} "' without value")
						create {STRING_32} v.make_empty
					else
						unset_checkpoint_position
					end
					Result := [p, n, v]
					c := current_character
					if c.is_space or c = '>' or c = '/' or c = '?' then
						-- expected character
					else
						-- STRICT: foo="val"bar="foobar"  is not valid, we expect a white space
						report_error ("unexpected character '" + current_character.out + "' after attribute declaration (expecting white space or '>' or '/' or '?' )")
					end
				end
			end
		ensure
			current_character.is_space or current_character = '>' or current_character = '/' or current_character = '?'
		end

feature {NONE} -- Implementation

	character_output (c: CHARACTER): STRING
			-- String representation of `c'
		do
			inspect c
			when '%U' then
				Result := "%%U"
			when '%T' then
				Result := "%%T"
			when '%N' then
				Result := "%%N"
			else
				if c.is_printable then
					Result := c.out
				else
					Result := "char#" + c.code.out
				end
			end
		end

	resolved_entity (s: STRING_8): STRING_32
			-- Resolve `s' as an entity
			--| Hardcoding the xml entities &quot; &amp; &apos; &lt; and &gt;
		require
			s_attached: s /= Void
		local
			s32: detachable STRING_32
		do
			inspect s.item (1).as_lower
			when 'a' then
				if
					s.count = 3 and then
					s.item (2).as_lower = 'm' and then
					s.item (3).as_lower = 'p'
				then -- &amp;
					s32 := {STRING_32} "&"
				elseif -- &apos;
					s.count = 4 and then
					s.item (2).as_lower = 'p' and then
					s.item (3).as_lower = 'o' and then
					s.item (4).as_lower = 's'
				then
					s32 := {STRING_32} "%'"
				end
			when 'q' then
				if
					s.count = 4 and then
					s.item (2).as_lower = 'u' and then
					s.item (3).as_lower = 'o' and then
					s.item (4).as_lower = 't'
				then -- &quot;
					s32 := {STRING_32} "%""
				end
			when 'l' then
				if
					s.count = 2 and then
					s.item (2).as_lower = 't'
				then -- &lt;
					s32 := {STRING_32} "<"
				end
			when 'g' then
				if
					s.count = 2 and then
					s.item (2).as_lower = 't'
				then -- &gt;
					s32 := {STRING_32} ">"
				end
			else
			end
			if s32 = Void then
				create s32.make (s.count + 2)
				s32.append_character ('&')
				s32.append_string_general (s)
				s32.append_character (';')
			end
			Result := s32
		end

	hexa_string_to_natural_32 (a_string: STRING): NATURAL_32
			-- Convert `a_string' to a NATURAL_32.
			-- If `a_string' is empty, then 0 as a signaling value that nothing was specified.
		do
			if a_string.is_empty then
				Result := 0
			else
				ctoi_convertor.reset ({NUMERIC_INFORMATION}.type_natural_32)
				ctoi_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
				Result := ctoi_convertor.parsed_natural_32
			end
		end

	ctoi_convertor: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			-- Convertor used to convert hexadecimal string to integer or natural
		once
			create Result.make
			Result.set_leading_separators ("x ")
			Result.set_trailing_separators (" ")
			Result.set_leading_separators_acceptable (True)
			Result.set_trailing_separators_acceptable (True)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

	valid_name_character, valid_tag_character (c: CHARACTER): BOOLEAN
			-- Is `c' a valid character for name or tag value?
		do
			inspect
				c
			when 'a'..'z' then
				Result := True
			when 'A'..'Z' then
				Result := True
			when '0'..'9' then
				Result := True
			when '-', '_', '.', ':' then
				Result := True
			else
			end
		end

	valid_entity_character	(c: CHARACTER): BOOLEAN
			-- Is `c' a valid character in html entity value?
			--| such as &amp;	
		do
			inspect
				c
			when 'a'..'z' then
				Result := True
			when 'A'..'Z' then
				Result := True
			when '0'..'9' then
				Result := True
			else
			end
		end

feature {NONE} -- Factory

	is_blank (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is string `s' composed only by space/blank characters?
			-- i.e: ' ', '%T', '%N', '%R'
			-- According to XML specification, space is one of
			-- x20 | #x9 | #xD | #xA
			-- i.e. space, tab, CR, LF.			
		local
			i, n: INTEGER
			c: CHARACTER_32
		do
			from
				Result := True
				i := 1
				n := s.count
			until
				i > n or not Result
			loop
				inspect s.code (i)
				when 0x20, -- space
					 0x9,  -- tab
					 0xD,  -- CR
					 0xA   -- LF
				then
					-- is_space
				else
					Result := False
				end
				i := i + 1
			end
		end

	case_insensitive_same_string_8 (a,b: READABLE_STRING_8): BOOLEAN
			-- `a' and `b' are the same string regardless of casing?
		local
			i,n: INTEGER
		do
			n := a.count
			if n = b.count then
				from
					i := 1
					Result := True
				until
					not Result or i > n
				loop
					Result := a[i].as_lower = b[i].as_lower
					i := i + 1
				end
			end
		end

	empty_buffer: XML_STRING_INPUT_STREAM
			-- Empty buffer
			-- (void-safety: keep `buffer' always attached)
		once
			create Result.make_empty
		end

	new_string_tag: STRING_32
			-- New string used to get tag name
		do
			Result := tmp_string_tag
		end

	new_string_attribute_name: STRING_32
			-- New string used to get attribute name
		do
			Result := tmp_string_attribute_name
		end

	new_string_attribute_value: STRING_32
			-- New string used to get attribute value
		do
			Result := tmp_string_attribute_value
		end

	new_string_comment_value: STRING_32
			-- New string used to get comment value
		do
			Result := tmp_string_comment_value
		end

feature {NONE} -- Constants

	str_version: STRING = "version"
	str_encoding: STRING = "encoding"
	str_standalone: STRING = "standalone"
	str_cdata: STRING_32 = "CDATA"
	str_doctype: STRING_32 = "DOCTYPE"
	str_pi: STRING = "pi"
	str_xml: STRING_32 = "xml"

feature {NONE} -- Factory: cache

	tmp_string_tag: STRING_32
			-- Cached string for `new_string_tag'
			-- to limit GC work
		once
			create Result.make (25)
		end

	tmp_string_attribute_name: STRING_32
			-- Cached string for `new_string_attribute_name'
			-- to limit GC work
		once
			create Result.make (20)
		end

	tmp_string_attribute_value: STRING_32
			-- Cached string for `new_string_attribute_value'
			-- to limit GC work
		once
			create Result.make (50)
		end

	tmp_string_comment_value: STRING_32
			-- Cached string for `new_string_comment_value'
			-- to limit GC work
		once
			create Result.make (100)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
