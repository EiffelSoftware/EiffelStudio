note
	description : "[
			XML v1.0 parser

			check: http://www.w3.org/TR/REC-xml/
		]"
	warning: "[
					<!DOCTYPE ..> is parsed but not used
					<!ENTITY ..> are not supported yet
			]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Extensible Markup Language (XML) 1.0", "protocol=URI", "src=http://www.w3.org/TR/xml/"

class
	XML_STANDARD_PARSER

inherit
	XML_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Instanciate Current
		do
			create {XML_CALLBACKS_NULL} callbacks.make
			set_buffer (empty_buffer)
		end

feature -- Parsing

	parse_from_stream (a_stream: XML_INPUT_STREAM)
			-- Parse stream `a_stream'
		do
			set_buffer (a_stream)
			parse
			set_buffer (empty_buffer)
		end

	parse_from_string_8 (a_string: READABLE_STRING_8)
			-- Parse string `a_string'
		local
			s: XML_STRING_INPUT_STREAM
		do
			create s.make (a_string)
			parse_from_stream (s)
			s.close
		end

	parse_from_string_32 (a_string: READABLE_STRING_32)
			-- Parse string `a_string'
		local
			s: XML_STRING_32_INPUT_STREAM
		do
			create s.make (a_string)
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

	parse_from_path (a_path: PATH)
			-- Parse from file named `a_path'
		local
			f: detachable RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (a_path)
				if f.exists and f.is_readable then
					f.open_read
					parse_from_file (f)
					f.close
				else
					report_error ({STRING_32} "Unable to open file %"" + a_path.name + {STRING_32} "%".")
				end
			else
				report_error ({STRING_32} "Error when trying to open file %"" + a_path.name + {STRING_32} "%".")
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

feature -- Element change

	set_callbacks (a_callbacks: like callbacks)
			-- Set `callbacks' to `a_callbacks'.
		do
			callbacks := a_callbacks
		ensure then
			callbacks_set: callbacks = a_callbacks
		end

	set_encoding (a_encoding: READABLE_STRING_GENERAL)
			-- Set encoding to `a_encoding'.
			--| Can be redefine ...
		local
			char_buffer: detachable XML_CHARACTER_8_INPUT_STREAM
		do
			if attached {XML_CHARACTER_8_INPUT_STREAM} buffer as b then
				char_buffer := b
			elseif attached {XML_CHARACTER_8_INPUT_STREAM_FILTER} buffer as f then
				char_buffer := f.source
			end
			if char_buffer = Void then
				report_warning ({STRING_32} "Internal error: unable to use encoding %"" + a_encoding.to_string_32 + {STRING_32} "%".")
			elseif attached new_encoded_buffer (a_encoding, char_buffer) as l_enc_buffer then
				-- Safe to update it, since for each new parsing, we reset the original buffer
				buffer := l_enc_buffer
			else
				-- Default is UTF-8, see http://www.w3.org/TR/2008/REC-xml-20081126/#sec-guessing
				report_warning ({STRING_32} "Unsupported encoding %"" + a_encoding.to_string_32 + {STRING_32} "%".")
				create {XML_CHARACTER_8_INPUT_STREAM_UTF8_FILTER} buffer.make (char_buffer)
			end
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

	truncation_reported: BOOLEAN
			-- Is parsed xml content truncated?

	has_warning: BOOLEAN
			-- Did parsing reported warning?
		do
			Result := warning_message /= Void
		end

	warning_message: detachable STRING_32
			-- Warning message

	error_message: detachable STRING_32
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
			error_message := Void
			warning_message := Void
			truncation_reported := False
		ensure
			error_message_void: error_message = Void
			error_position_void: error_position = Void
			error_occurred_unset: not error_occurred
		end

feature {NONE} -- Access

	buffer: XML_INPUT_STREAM
			-- Internal buffer

	set_buffer (buf: like buffer)
			-- Set `buffer' to `buf'
		do
			buffer := buf
			end_of_input := buf.end_of_input
		end

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
			l_content: STRING_32
			l_in_prolog: BOOLEAN
			l_bom_detection: BOOLEAN
			l_callbacks: like callbacks
		do
			reset
			l_callbacks := callbacks

			l_callbacks.on_start
			from
				l_bom_detection := True
				l_in_prolog := True
				create l_content.make_empty
			until
				end_of_input or parsing_stopped -- i.e stop requested or error occurred
			loop
				read_character
				if end_of_input then
						-- Done parsing the input.
				else
					inspect
						last_character
					when '%U' then
						check no_null_char: False end
						report_unexpected_content ("Null character!")
					when '<' then
						if l_in_prolog then
							if l_bom_detection then
								if attached bom (l_content) as l_bom then
									set_encoding_from_bom (l_bom)
									l_content.remove_head (l_bom.count)
								end
								l_bom_detection := False
							end
							if not is_blank (l_content) then
								report_unexpected_content_in_prolog (l_content)
							end
							l_content.wipe_out
						else
								-- If not <?xml declaration was found, the XML is not well formed.
								-- Should be reported by a validating callbacks component.
							if not l_content.is_empty then
								l_callbacks.on_content (l_content.string)
								l_content.wipe_out
							end
						end
						read_character
						if end_of_input then
								-- input ends with '<' , truncated content, but not an error itself
							report_truncated_content ("Input ends with '<' character")
						else
							inspect last_character
							when '?' then
								parse_processing_instruction
							when '/' then
								parse_end_tag
							when '!' then
								read_character
								if end_of_input then
									report_truncated_content ("Input ends with '<!'")
								else
									inspect last_character
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
										report_syntax_error (Void)
									end
								end
							else
								rewind_character
								l_in_prolog := False
								parse_start_tag
							end
						end
					when '&' then
						l_content.append_string (next_entity)
					when '>' then
						report_syntax_error (Void)
					else
						l_content.append_character (last_character)
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
			att: like next_attribute_data
			done: BOOLEAN
			l_callbacks: like callbacks
		do
			if end_of_input then
					-- end parsing
				report_truncated_content (Void)
			else
				t := next_tag
				if t.local_part.is_empty then
					report_error ({STRING_32} "invalid start tag value.")
				else
					l_callbacks := callbacks
					l_callbacks.on_start_tag (Void, t.prefix_part, t.local_part)
					if last_character.is_space then
						read_until_non_space_character
					end
					if end_of_input then
						report_truncated_content ("in start tag declaration")
					else
						inspect
							last_character
						when '>' then
							l_callbacks.on_start_tag_finish
						when '/' then
							if end_of_input then
								report_truncated_content ({STRING_32} "incomplete start tag")
							else
								read_character
	--							read_until_non_space_character -- more flexible?
								if last_character = '>' then
									l_callbacks.on_start_tag_finish
									l_callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
								else
									report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' after closing / in start tag.")
								end
							end
						else
							rewind_character
							from
								done := False
							until
								end_of_input or done or parsing_stopped
							loop
								att := next_attribute_data
								if att /= Void then
									l_callbacks.on_attribute (Void, att.prefix_part, att.local_part, att.value)
									if end_of_input then
										report_truncated_content ("in start tag declaration")
									else
										rewind_character
									end
								elseif end_of_input then
									report_truncated_content ("in start tag declaration")
								else
									inspect last_character
									when '>' then
										l_callbacks.on_start_tag_finish
									when '/' then
										read_character
										if end_of_input then
											report_truncated_content ({STRING_32} "incomplete start tag ending")
										else
	--										read_until_non_space_character -- more flexible?
											if last_character = '>' then
												done := True
												l_callbacks.on_start_tag_finish
												l_callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
											else
												report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' after closing / in start tag")
											end
										end
									else
										report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' in start tag")
									end
									done := True
								end
							end
						end
					end
				end
			end
		end

	parse_end_tag
			-- Parse for end tag
		local
			t: like next_tag
		do
			if end_of_input then
					-- end parsing
				report_truncated_content (Void)
			else
				t := next_tag
				if t.local_part.is_empty then
					report_error ({STRING_32} "invalid end tag value.")
				else
					if last_character.is_space then
						read_until_non_space_character
					end
					if last_character = '>' then
						callbacks.on_end_tag (Void, t.prefix_part, t.local_part)
					else
						report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' in end tag")
					end
				end
			end
		end

	parse_declaration
			-- Parse for xml declaration
		local
			l_version, l_encoding: detachable READABLE_STRING_32
			l_standalone: BOOLEAN
			l_name: READABLE_STRING_32
			done: BOOLEAN
			att: like next_attribute_data
		do
			l_standalone := True
			if not parsing_stopped then
				read_character
				if last_character.is_space then
					read_until_non_space_character
				end
				inspect
					last_character
				when '?' then
--					read_until_non_space_character -- more flexible?
					read_character
					if end_of_input then
						report_truncated_content ({STRING_32} "incomplete xml declaration")
					elseif last_character = '>' then
						if l_version /= Void then
							on_xml_declaration (l_version, l_encoding, l_standalone)
						else
							report_error ({STRING_32} "missing version in xml declaration")
						end
					else
						report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' after closing ? in xml declaration")
					end
				else
					rewind_character
					from
						done := False
					until
						done or parsing_stopped or end_of_input
					loop
						att := next_attribute_data
						if att /= Void then
							l_name := att.local_part
							if l_name.is_case_insensitive_equal (str_version) then
								l_version := att.value
							elseif l_name.is_case_insensitive_equal (str_encoding) then
								l_encoding := att.value
							elseif l_name.is_case_insensitive_equal (str_standalone) then
								l_standalone := True
							else
								report_error ({STRING_32} "unknown xml declaration attribute [" + l_name.to_string_32 + {STRING_32} "]")
							end
							rewind_character
						else
							if last_character = '?' then
								read_until_non_space_character
								if end_of_input then
									report_truncated_content ({STRING_32} "incomplete end of xml declaration")
								elseif last_character = '>' then
									done := True
									if l_version /= Void then
										on_xml_declaration (l_version, l_encoding, l_standalone)
									else
										report_error ({STRING_32} "missing version in xml declaration")
									end
								else
									report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' after closing ? in xml declaration")
								end
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
			c: like last_character
			n, s: STRING_32
			done: BOOLEAN
		do
			read_character
			if end_of_input then
				report_truncated_content ({STRING_32} "incomplete processing instruction")
			else
				c := last_character
				from
					create n.make (6)
				until
					end_of_input or c.is_space or c = '?' or c = '>'
				loop
					n.append_character (c)
					read_character
					c := last_character
				end
				if end_of_input then
					report_truncated_content ({STRING_32} "incomplete processing instruction")
				elseif n.is_empty then
					if not end_of_input then
						rewind_character
					end
					report_error ({STRING_32} "Invalid processing instruction syntax <?" + create {STRING_32}.make_filled (last_character, 1))
				elseif n.is_case_insensitive_equal (str_xml) then
					parse_declaration
				else
					create s.make_empty
					from
						read_character
					until
						end_of_input or done or parsing_stopped
					loop
						c := last_character
						if c = '?' then
							read_character
							c := last_character
							if c = '>' then
								done := True
							elseif c = '?' then
								s.append_character ('?')
							else
								s.append_character ('?')
								s.append_character (c)
								read_character
								if end_of_input then
									report_truncated_content ({STRING_32} "incomplete processing instruction")
								end
							end
						else
							s.append_character (c)
							read_character
						end
					end
					if end_of_input or parsing_stopped then
						report_error ({STRING_32} "could not find end of Processing Instruction")
					else
						callbacks.on_processing_instruction (n, s)
					end
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
			read_character
			if end_of_input then
				report_truncated_content ({STRING_32} "incomplete CDATA syntax")
			else
				if last_character /= '[' then
					report_error ({STRING_32} "invalid syntax <!" + create {STRING_32}.make_filled (last_character, 1))
				elseif end_of_input then
					report_truncated_content ({STRING_32} "incomplete CDATA syntax")
				else
					read_character
					c := last_character
					from
						create s.make (6)
					until
						end_of_input or c = '['
					loop
						s.append_character (c.as_upper)
						read_character
						c := last_character
					end
					if s.same_string_general (str_cdata) then
						s.wipe_out
						from
							read_character
						until
							end_of_input or done or parsing_stopped
						loop
								-- In this loop body, no check on end_of_input
								-- at worst it reports a "No more characters" error.					
							if last_character = ']' then
								read_character
								if last_character = ']' then
									read_character
									c := last_character
									if c = '>' then
										done := True
									elseif c = ']' then
											-- Could be ]]]
										s.append_character (']')
										if not end_of_input then
											rewind_character
										end
									else
										s.append_character (']')
										s.append_character (']')
										s.append_character (c)
										read_character
									end
								else
									s.append_character (']')
									s.append_character (last_character)
									read_character
								end
							else
								s.append_character (last_character)
								read_character
							end
						end
						if end_of_input or parsing_stopped then
							report_error ({STRING_32} "could not find end of CDATA content")
						else
							callbacks.on_content (s)
						end
					else
						report_error ({STRING_32} "invalid syntax <![" + s)
					end
				end
			end
		end

	parse_comment
			-- Parse for comment
		local
			c: like last_character
			s: like new_string_comment_value
			done: BOOLEAN
		do
				-- At this point, we should not be end_of_input
				-- and even if it happens, the `c' value will be '%U'
				-- and the parsing will exit on next "c /= '-'" condition
			read_character
			if last_character /= '-' then
					--| This includes end_of_input which set '%U' to last_character
				report_error ({STRING_32} "invalid comment syntax")
			else
					-- Same comment, if end_of_input is True, the next instruction will stop the parsing
				read_character
				if last_character /= '-' then
						--| This includes end_of_input which set '%U' to last_character
					report_error ({STRING_32} "invalid comment syntax")
				else
						-- Start comment
					create s.make_empty
					from
						read_character
					until
						end_of_input or done or parsing_stopped
					loop
						if last_character = '-' then
							read_character
							c := last_character
							if c = '-' then
								read_character
								c := last_character
								if c = '>' then
									done := True
								elseif c = '-' then
									s.append_character ('-')
									if not end_of_input then
										rewind_character
									end
								else
									s.append_character ('-')
									s.append_character ('-')
									s.append_character (c)
									if not end_of_input then
										read_character
									end
								end
							else
								s.append_character ('-')
								s.append_character (c)
								read_character
							end
						else
							s.append_character (last_character)
							read_character
						end
					end
					if parsing_stopped then
						report_error ({STRING_32} "could not find end of comment")
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
			c: like last_character
			s: STRING_32
			l_depth: INTEGER
			in_double_quote: BOOLEAN
			done: BOOLEAN
		do
				-- At this point, we should not be end_of_input
				-- and even if it happens, the `c' value will be '%U'
				-- and the parsing will exit on next "c /= 'D'" condition
			read_character
			if last_character /= 'D' then
					--| This includes end_of_input which set '%U' to last_character
				report_error ({STRING_32} "invalid syntax <!" + create {STRING_32}.make_filled (last_character, 1))
			else
				c := last_character
				from
					create s.make (6)
				until
					end_of_input or c.is_space or c = '>'
				loop
					s.append_character (c.as_upper)
					read_character
					c := last_character
				end
				if s.same_string_general (str_doctype) then
					create s.make_empty
					from
						read_character
					until
						end_of_input or done or parsing_stopped
					loop
						c := last_character
						if in_double_quote then
							if c = '"' then
								in_double_quote := False
							end
							s.append_character (c)
							read_character
						else
							inspect c
							when '"' then
								in_double_quote := True
								s.append_character (c)
								read_character
							when '<' then
								l_depth := l_depth + 1
								s.append_character (c)
								read_character
							when '>' then
								if l_depth = 0 then
									-- Final '>'
									done := True
								else
									-- Closing inner "< ... >"
									l_depth := l_depth - 1
									s.append_character (c)
									read_character
								end
							else
								s.append_character (c)
								read_character
							end
						end
					end
					if parsing_stopped then
						report_error ({STRING_32} "could not find end of DOCTYPE content")
					else
						register_doctype (s)
					end
				else
					report_error ({STRING_32} "invalid syntax <!" + s)
				end
			end
		end

	on_xml_declaration (a_version: READABLE_STRING_32; a_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			-- XML declaration.
		require
			a_version_not_void: a_version /= Void
			a_version_not_empty: a_version.count > 0
		local
			ver: detachable READABLE_STRING_32
			enc: detachable READABLE_STRING_32
		do
			if a_version.is_valid_as_string_8 then
				-- See http://www.w3.org/TR/REC-xml/#NT-VersionInfo
				ver := a_version
				if ver.count >= 3 then
					if
						ver.item (1).is_digit and
						ver.item (2) = '.' and
						ver.substring (3, ver.count).is_integer
					then
						-- Valid version
						if ver.item (1) /= '1' then
							report_error ({STRING_32} "Unsupported xml version info: %"" + a_version + {STRING_32} "%".")
						end
					else
						ver := Void
					end
				else
					ver := Void
				end
			end
			if ver = Void then
				report_error ({STRING_32} "Invalid xml version info: %"" + a_version + {STRING_32} "%".")
			else
				if a_encoding /= Void then
					if a_encoding.is_valid_as_string_8 then
						enc := a_encoding
						if enc.is_empty then
							enc := Void
						end
					else
						report_error ({STRING_32} "Invalid xml encoding: %"" + a_encoding + {STRING_32} "%".")
					end
				end
			end
			if enc = Void then
				-- Default is UTF-8, see http://www.w3.org/TR/2008/REC-xml-20081126/#sec-guessing
				set_encoding (default_encoding)
			else
				set_encoding (enc)
			end
			callbacks.on_xml_declaration (a_version, a_encoding, a_standalone)
		end

feature {NONE} -- Error reporting

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

			create error_message.make_from_string (s)

			if error_position = Void then
					-- record only first error's position
				error_position := p
			end
			parsing_stopped := True

				--| The following won't be part of `error_message'
			s.append_character (' ')
			s.append_character ('(')
			s.append_string ({STRING_32} "position=")
			s.append_string (p.to_string_32)
			callbacks.on_error (s)
		ensure
			error_occurred: error_occurred
		end

	report_warning (a_message: READABLE_STRING_32)
			-- Report warning with message `a_message'
		require
			a_message_attached: a_message /= Void
		local
			s: STRING_32
		do
			create s.make (a_message.count)
			s.append_string_general (a_message)

			warning_message := s
		end

	report_truncated_content (a_message: detachable READABLE_STRING_GENERAL)
			-- Report the content is truncated.
			-- i.e reach end of input inside an XML structure parsing.
		do
			if truncation_reported then
					--| truncated content warning already reported
					--| keep first warning message.
			else
				truncation_reported := True

				if a_message /= Void then
					report_warning ({STRING_32} "End of input: " + a_message.to_string_32)
				else
					report_warning ({STRING_32} "End of input.")
				end
			end
		end

	report_syntax_error (a_message: detachable READABLE_STRING_GENERAL)
			-- Report a syntax error with optional additional message `a_message'.
		do
			if a_message /= Void then
				report_warning ({STRING_32} "Syntax error: " + a_message.to_string_32)
			else
				report_error ({STRING_32} "Syntax error.")
			end
		end

	report_unsupported_bom_value (a_bom: READABLE_STRING_GENERAL)
			-- Report unsupported BOM value for `a_bom'
		do
			report_error ({STRING_32} "Unsupported BOM value %"" + a_bom.to_string_32 + {STRING_32} "%".")
		end

	report_missing_attribute_value (p: detachable READABLE_STRING_32; n: READABLE_STRING_32)
			-- Report missing value for attribute `p:n'
		do
			report_error ({STRING_32} "Attributes without any value are forbidden")
		end

	report_unexpected_content (a_content: STRING)
			-- Report unexpected content `a_content'
		do
			report_error ({STRING_32} "Unexpected content (not well-formed XML)")
		end

	report_unexpected_content_in_prolog (a_content: READABLE_STRING_32)
			-- Report unexpected content `a_content' in prolog
		do
			report_error ({STRING_32} "Unexpected content in prolog (not well-formed XML)")
		end

feature {NONE} -- Encoding

	set_encoding_from_bom (a_bom: READABLE_STRING_GENERAL)
		local
			u: UTF_CONVERTER
		do
			if a_bom.same_string (u.utf_8_bom_to_string_8) then
				set_encoding ("UTF-8")
			else
				report_unsupported_bom_value (a_bom)
			end
		end

	default_encoding: STRING_32 = "UTF-8"

feature {NONE} -- Implementation: Byte Order Mark

	bom (s: READABLE_STRING_32): detachable STRING_8
			-- Byte Order Mark at the start of `s'.
		local
			i,n: INTEGER
			s32: READABLE_STRING_32
		do
			n := s.count
			if n = 0 then
			else
				from
					i := 1
				until
					i > n or not is_bom_character (s[i])
				loop
					i := i + 1
				end
				if i > 1 then
					s32 := s.substring (1, i - 1)
					if s32.is_valid_as_string_8 then
						Result := s32.to_string_8
					end
				end
			end
		end

	is_bom_character (c: CHARACTER_32): BOOLEAN
		do
				-- UTF-8 	EF BB BF
				-- UTF-16 Big Endian 	FE FF
				-- UTF-16 Little Endian 	FF FE
				-- UTF-32 Big Endian 	00 00 FE FF
				-- UTF-32 Little Endian 	FF FE 00 00
			inspect c
			when '%/0xEF/', '%/0xBB/', '%/0xBF/' then -- UTF-8
				Result := True
			when '%/0xFE/', '%/0xFF/'then -- UTF-16 , UTF-32
				Result := True
			when '%/0x00/' then -- UTF-32
				Result := True
			else
			end
		end

feature {NONE} -- Implementation: Encoding factory

	new_encoded_buffer (a_encoding: READABLE_STRING_GENERAL; a_char_buffer: XML_CHARACTER_8_INPUT_STREAM): detachable like buffer
			-- Create a new `a_encoding' encoded buffer for `a_char_buffer'.
			-- Could be redefined
		require
			a_encoding_not_empty: a_encoding /= Void and then (not a_encoding.is_empty and a_encoding.is_valid_as_string_8)
			a_char_buffer_attached: a_char_buffer /= Void
		do
			if a_encoding.is_case_insensitive_equal ("UTF-8") then
				create {XML_CHARACTER_8_INPUT_STREAM_UTF8_FILTER} Result.make (a_char_buffer)
			elseif a_encoding.is_case_insensitive_equal ("ISO-8859-1") then
				Result := a_char_buffer
			end
		end

feature {NONE} -- Doctype

	register_doctype (s: READABLE_STRING_32)
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

	end_of_input: BOOLEAN
			-- Reached end of input?

	last_character: CHARACTER_32
			-- Last read character

	rewinded_character: like last_character
			-- Last character put in stack

	rewind_character
			-- Rewind by 1 character
		require
			not_end_of_input: not end_of_input
			rewinded_character_null: rewinded_character = '%U'
		do
			rewinded_character := last_character
		ensure
			rewinded_character_valid: not end_of_input implies rewinded_character /= '%U'
		end

	read_character
			-- Read next character and set `last_character' with it.
			-- move index
		require
			not_end_of_input: not end_of_input
		local
			c: like last_character
		do
			c := rewinded_character
			if c = '%U' then
				if buffer.end_of_input then
					report_error ({STRING_32} "No more characters")
				else
					c := internal_next_character (buffer)
						--| set end_of_input
				end
			else
					--| now `last_character' is set to previous `rewinded_character'
				rewinded_character := '%U'
				end_of_input := buffer.end_of_input
			end
			last_character := c
		end

	internal_next_character (buf: like buffer): like last_character
			-- Internal implementation of `read_character'
			--| Update `end_of_input'
			--| and move buffer index.
			--| always called by `read_character'
		require
			buf_attached: buf /= Void
			buf_not_end_of_input: not buf.end_of_input
		local
			c: NATURAL_32
			cr_code: NATURAL_32
		do
			buf.read_character_code
			if buf.end_of_input then
				end_of_input := True
				c := 0 -- '%U'
			else
				cr_code := carriage_return_character_code
				c := buf.last_character_code
				if c = cr_code then
					from
					until
						buf.end_of_input or c /= cr_code
					loop
						buf.read_character_code
						c := buf.last_character_code
					end
					if buf.end_of_input then
						end_of_input := buf.end_of_input
						c := 0 -- '%U'
					end
				end
				Result := c.to_character_32
			end
		ensure
			end_of_input implies (buf.end_of_input and Result = '%U')
		end

	read_until_non_space_character
			-- Read characters until next character which is not a space
			-- move index, update last_character
		local
			c: like last_character
		do
			if end_of_input then
				report_error ("Out of Input data.")
				check last_character = '%U' end
			else
				from
					read_character
					c := last_character
				until
					end_of_input or not c.is_space
				loop
					read_character
					c := last_character
				end
				last_character := c
			end
		ensure
			not_a_space: not end_of_input implies not last_character.is_space
		end

	next_tag: TUPLE [prefix_part: detachable STRING_32; local_part: STRING_32]
			-- Return next tag value
			-- move index
		require
			not_end_of_input: not end_of_input
		local
			c: like last_character
			p: detachable like new_string_tag
			s: like new_string_tag
		do
			s := new_string_tag
			read_until_non_space_character
			c := last_character
			if end_of_input then
				report_truncated_content ("Can not find tag name")
			elseif is_valid_tag_start_character (c) then
				from
				until
					end_of_input or not is_valid_tag_character (c)
				loop
					if c = ':' and p = Void then
						p := s.string
						s.wipe_out
					else
						s.append_character (c)
					end
					read_character
					c := last_character
				end
			end
			Result := [p, s.string]
			s.wipe_out
		ensure
			new_string_tag_is_empty: new_string_tag.is_empty
		end

	next_entity: STRING_32
			-- Return next entity value
			-- move index
		require
			last_character = '&'
			not_end_of_input: not end_of_input
		local
			c: like last_character
			is_char: BOOLEAN
			is_hexa: BOOLEAN
			s: STRING_32
		do
			create s.make_empty
			read_character
			if last_character = '#' then
				is_char := True
				read_character
				if last_character = 'x' then
					is_hexa := True
					read_character
				end
			end
			if end_of_input then
				check last_character_is_null: last_character = '%U' end
				report_error ({STRING_32} "Invalid entity syntax")
				create Result.make (s.count + 3)
				Result.append_character ('&')
				if is_char then
					Result.append_character ('#')
					if is_hexa then
						Result.append_character ('x')
					end
				end
				Result.append_string (s)
			else
				c := last_character
				if is_char then
					if is_hexa then
						from
						until
							end_of_input or not c.is_hexa_digit or c = ';'
						loop
							s.append_character (c)
							read_character
							c := last_character
						end
					else
						from
						until
							end_of_input or not c.is_digit or c = ';'
						loop
							s.append_character (c)
							read_character
							c := last_character
						end
					end
				else
					from
					until
						end_of_input or not is_valid_entity_character (c) or c = ';'
					loop
						s.append_character (c)
						read_character
						c := last_character
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
							Result.append_string (s)
							Result.append_character (';')
						end
					else
						Result := resolved_entity (s)
					end
				elseif end_of_input then
					create Result.make (s.count + 3)
					Result.append_character ('&')
					if is_char then
						Result.append_character ('#')
						if is_hexa then
							Result.append_character ('x')
						end
					end
					Result.append_string (s)
					report_error ({STRING_32} "Invalid entity syntax " + s)
				else
					rewind_character
					create Result.make (s.count + 3)
					Result.append_character ('&')
					if is_char then
						Result.append_character ('#')
						if is_hexa then
							Result.append_character ('x')
						end
					end
					Result.append_string (s)
					report_error ({STRING_32} "Invalid entity syntax " + s)
				end
			end
		end

	next_attribute_name: TUPLE [prefix_part: detachable READABLE_STRING_32; local_part: READABLE_STRING_32]
			-- Return next attribute prefix and local part.
			-- move index
		require
			not_end_of_input: not end_of_input
		local
			c: like last_character
			n: like new_string_attribute_name
			p: INTEGER
		do
			n := new_string_attribute_name
			read_until_non_space_character
			if end_of_input then
				report_truncated_content ("no tag closure")
			else
				c := last_character
				if is_valid_name_start_character (c) then
					n.append_character (c)
					from
						read_character
						c := last_character
					until
						end_of_input or not is_valid_name_character (c)
					loop
						n.append_character (c)
						read_character
						c := last_character
					end
				end
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

	next_attribute_value: detachable READABLE_STRING_32
			-- Return next attribute's value
			-- move index
		require
			not_end_of_input: not end_of_input
		local
			c: like last_character
			l_in_double_quote: BOOLEAN
			l_in_single_quote: BOOLEAN
			done: BOOLEAN
			s: like new_string_attribute_value
		do
			s := new_string_attribute_value

				--FIXME  var='foo " bar'  is valid !
			read_character
			if end_of_input then
				report_truncated_content ("No attribute value")
			else
				c := last_character
				if c = '"' then
					l_in_double_quote := True
					read_character
					c := last_character
				elseif c = '%'' then
					l_in_single_quote := True
					read_character
					c := last_character
				elseif c.is_space or c = '/' or c = '>' then
					report_error ({STRING_32} "unexpected space after = in attribute declaration")
				else
					--| We could be more strict, but let's allow attrib=value .. in addition to attrib="value"
				end
			end

			if end_of_input then
				report_truncated_content ("No attribute value")
			elseif not parsing_stopped then
				from
					done := False
				until
					end_of_input or done or parsing_stopped
				loop
					if
						not l_in_double_quote and not l_in_single_quote and
						(c.is_space or c = {CHARACTER_32} '/' or c = {CHARACTER_32} '>')
					then
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
								report_error ({STRING_32} "unexpected %" in attribute value")
							end
						when '%'' then
							if l_in_single_quote then
								done := True
							elseif l_in_double_quote then
								s.append_character (c)
							else
								report_error ({STRING_32} "unexpected %' in attribute value")
							end
						else
							s.append_character (c)
						end
						if not end_of_input then
							read_character
						end
						c := last_character
					end
				end
				if end_of_input or parsing_stopped then
					if done then
						Result := s.string
					else
							-- No Result, value is truncated
						report_truncated_content ("attribute value is truncated")
					end
				else
					Result := s.string
				end
			end

			s.wipe_out
		ensure
			new_string_attribute_value_is_empty: new_string_attribute_value.is_empty
		end

	next_attribute_data: detachable TUPLE [prefix_part: detachable READABLE_STRING_32; local_part: READABLE_STRING_32; value: READABLE_STRING_32]
			-- Return next attribute's data (prefix,local and value)
			-- move index
		require
			not_end_of_input: not end_of_input
		local
			c: like last_character
			n: READABLE_STRING_32
			p, v: detachable READABLE_STRING_32
			l_was_space: BOOLEAN
			att_name: like next_attribute_name
		do
			att_name := next_attribute_name
			n := att_name.local_part
			p := att_name.prefix_part

			if n.is_empty then
				if end_of_input then
					report_truncated_content ("in start tag declaration")
				else
					c := last_character
					if c = '>' or c = '/' or c = '?' then
							-- no more attribute
							-- reached valid end of tag
					else
						report_error ("Error with attribute declaration.")
					end
				end
			else
				set_checkpoint_position --| record potential error position
				c := last_character
				if c.is_space then
					l_was_space := True
					read_until_non_space_character  --| FIXME: strict?
					c := last_character
				end
				if end_of_input then
					report_truncated_content ("only attribute name")
				else
					if c = '=' then
						-- now looking for value
						unset_checkpoint_position
					elseif l_was_space or c = '>' or c = '/' then
						-- no value FIXME: strict?
						-- we do not allow attribute without value
						report_missing_attribute_value (p, n)
						Result := [p, n, {STRING_32} ""]
					else -- not l_was_space
						report_error ({STRING_32} "unexpected character '" + character_output (c) + {STRING_32} "' in attribute name")
					end
					if Result = Void and not parsing_stopped then
						check
							c_is_equal_sign: c = '='
						end
						set_checkpoint_position
						read_character
						c := last_character
						if c.is_space then
							read_until_non_space_character
							c := last_character
						end
						if end_of_input then
							report_truncated_content ("expecting attribute value after = sign")
						else
							rewind_character
							v := next_attribute_value
							if v = Void then
								if end_of_input or parsing_stopped then
										-- ok
								else
									report_syntax_error ("expecting valid attribute value")
								end
							else
								unset_checkpoint_position
								Result := [p, n, v]
								if end_of_input then
									report_truncated_content ("in start tag declaration")
								else
									c := last_character
									if c.is_space or c = '>' or c = '/' or c = '?' then
										-- expected character
									else
										-- STRICT: foo="val"bar="foobar"  is not valid, we expect a white space
										report_error ({STRING_32} "unexpected character '" + character_output (last_character) + {STRING_32} "' after attribute declaration (expecting white space or '>' or '/' or '?' )")
									end
								end
							end
						end
					end
				end
			end
		ensure
			not (error_occurred or end_of_input) implies ( last_character.is_space or last_character = '>' or last_character = '/' or last_character = '?' )
		end

feature {NONE} -- Implementation

	character_output (c: like last_character): STRING_32
			-- String representation of `c'
			-- Mainly for error reporting purpose.
		do
			inspect c
			when '%U' then
				Result := {STRING_32} "%%U"
			when '%T' then
				Result := {STRING_32} "%%T"
			when '%N' then
				Result := {STRING_32} "%%N"
			else
				if is_printable (c) then
					create Result.make_empty
					Result.append_character (c)
				else
					Result := {STRING_32} "&#"
					Result.append_natural_32 (c.natural_32_code)
					Result.append_character (';')
				end
			end
		end

	resolved_entity (s: READABLE_STRING_32): STRING_32
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

	hexa_string_to_natural_32 (a_string: READABLE_STRING_GENERAL): NATURAL_32
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

	is_valid_tag_start_character (c: like last_character): BOOLEAN
		do
			Result := is_valid_name_start_character (c)
		end

	is_valid_tag_character (c: like last_character): BOOLEAN
		do
			Result := is_valid_name_character (c)
		end

	is_valid_entity_character	(c: like last_character): BOOLEAN
			-- Is `c' a valid character in html entity value?
			--| such as &amp;	
		do
			Result := is_valid_name_character (c)
		end

	is_valid_name_start_character (c: like last_character): BOOLEAN
			-- Is `c' a valid character for name or tag value?
			-- NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF]
			--					     | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F]
			--						 | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD]
			--						 | [#x10000-#xEFFFF]
		local
			n: NATURAL_32
		do
			if
				('a' <= c and c <= 'z')
			 	or ('A' <= c and c <= 'Z')
			 	or c = ':'
			 	or c = '_'
			then
				Result := True
			else
				n := c.natural_32_code
				if
					   (0xC0    <= n and n <= 0xD6)
					or (0xD8    <= n and n <= 0xF6)
					or (0xF8    <= n and n <= 0x2FF)
					or (0x370   <= n and n <= 0x37D)
					or (0x37F   <= n and n <= 0x1FFF)
					or (0x200C  <= n and n <= 0x200D)
					or (0x2070  <= n and n <= 0x218F)
					or (0x2C00  <= n and n <= 0x2FEF)
					or (0x3001  <= n and n <= 0xD7FF)
					or (0xF900  <= n and n <= 0xFDCF)
					or (0xFDF0  <= n and n <= 0xFFFD)
					or (0x10000 <= n and n <= 0xEFFFF)
				then
					Result := True
				end
			end
		end

	is_valid_name_character (c: like last_character): BOOLEAN
			-- Is `c' a valid character for name or tag value?
			-- NameChar ::= NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
		local
			n: NATURAL_32
		do
			Result := is_valid_name_start_character (c)
			if not Result then
				if
					c = '-'
					or c = '.'
					or ('0' <= c and c <= '9')
				then
					Result := True
				else
					n := c.natural_32_code
					if
						n = 0xB7
						or (0x0300 <= n and n <= 0x036F)
						or (0x203F <= n and n <= 0x2040)
					then
						Result := True
					end
				end
			end
		end


feature {NONE} -- Character nature

	is_printable (c: like last_character): BOOLEAN
		do
			-- FIXME: remove when migrated to use CHARACTER_32
			if attached {CHARACTER_8} c as c8 then
				Result := c8.is_printable
			else
				if attached {CHARACTER_32} c as c32 and then c32.is_character_8 then
					Result := c32.to_character_8.is_printable
				end
			end
		end

	is_blank (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is string `s' composed only by space/blank characters?
			-- i.e: ' ', '%T', '%N', '%R'
			-- According to XML specification, space is one of
			-- x20 | #x9 | #xD | #xA
			-- i.e. space, tab, CR, LF.			
		local
			i, n: INTEGER
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

feature {NONE} -- Factory		

	empty_buffer: XML_STRING_INPUT_STREAM
			-- Empty buffer
			-- (void-safety: keep `buffer' always attached)
		once
			create Result.make_empty
			Result.set_name ("Empty-string-buffer")
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

	str_version: STRING_32 = "version"
	str_encoding: STRING_32 = "encoding"
	str_standalone: STRING_32 = "standalone"
	str_cdata: STRING_32 = "CDATA"
	str_doctype: STRING_32 = "DOCTYPE"
	str_pi: STRING_32 = "pi"
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

	carriage_return_character_code: NATURAL_32
			-- Value of Carriage Return '%R' character.
		once
			Result := ('%R').natural_32_code
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
