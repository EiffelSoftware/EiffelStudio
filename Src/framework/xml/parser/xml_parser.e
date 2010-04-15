note
	description : "[
			Simple XML parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Instanciate Current
		do
			create {XML_CALLBACKS_NULL} callbacks
			cr_character_ignored := True
			buffer := empty_buffer
			initialize_entity_mapping
		end

	initialize_entity_mapping
			-- Initialize entity mapping with predefined values
			--| cf: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
		local
			map: like entity_mapping
		do
			create map.make (5)
				-- entities in XML
			map.force ('"', "&quot;")  -- 34
			map.force ('&', "&amp;")   -- 38		
			map.force ('%'', "&apos;") -- 39
			map.force ('<', "&lt;")    -- 60
			map.force ('>', "&gt;")    -- 62

			entity_mapping := map
		end

feature -- Basic operation

	parse_from_stream (a_stream: XML_INPUT_STREAM)
			-- Parse stream `a_stream'
		require
			a_stream_attached: a_stream /= Void
		do
			buffer := a_stream
			parse
			buffer := empty_buffer
		end

	parse_from_string (a_string: STRING)
			-- Parse string `a_string'
		require
			a_string_attached: a_string /= Void
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
		require
			a_file_attached: a_file /= Void
			a_file_readable: a_file.is_open_read and then a_file.readable
		local
			s: XML_FILE_INPUT_STREAM
		do
			create s.make (a_file)
			s.compute_smart_chunk_size (0x4000)
			s.start
			parse_from_stream (s)
			s.close
		end

feature -- Access

	callbacks: XML_CALLBACKS
			-- XML callbacks

	entity_mapping: HASH_TABLE [CHARACTER, STRING]
			-- Entities mapping
			-- You can provide your own extended mapping with `set_entity_mapping'
			--| such as &amp; &gt; &lt; &quot; ...

feature -- Settings

	cr_character_ignored: BOOLEAN
			-- Ignore CR  '%R' characters
			-- By default: True

feature -- Settings change

	set_cr_character_ignored (b: BOOLEAN)
			-- Set `cr_character_ignored' to `b'
		do
			cr_character_ignored := b
		end

feature -- Status

	error_occurred: BOOLEAN
			-- Error occurred?

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

	set_callbacks (a_callbacks: like callbacks)
			-- Set `callbacks' to `a_callbacks'
		do
			callbacks := a_callbacks
		ensure
			callbacks_set: callbacks = a_callbacks
		end

	set_entity_mapping (a_map: like entity_mapping)
			-- Set `entity_mapping' to `a_map'
		do
			if a_map = Void then
				initialize_entity_mapping
			else
				entity_mapping := a_map
			end
		ensure
			entity_mapping_set: a_map /= Void implies entity_mapping = a_map
		end

	reset
			-- Reset parser states
		do
			error_occurred := False
		end

feature {NONE} -- Implementation

	buffer: XML_INPUT_STREAM
			-- Internal buffer

	buffer_index: INTEGER
			-- Internal buffer index
		do
			Result := buffer.index
		end

feature {NONE} -- Implementation: parse

	parse
			-- Parse `buffer'
		local
			c: CHARACTER
			l_content: STRING
		do
			reset

			callbacks.on_start
			from
				create l_content.make_empty
			until
				buffer.end_of_input or error_occurred
			loop
				c := next_character
				inspect
					c
				when '<' then
					if not l_content.is_empty then
						callbacks.on_content (l_content.string)
						l_content.wipe_out
					end
					c := next_character
					inspect c
					when '?' then
						parse_declaration
					when '/' then
						parse_end_tag
					when '!' then
						parse_comment
					else
						rewind_character
						parse_start_tag
					end
				when '&' then
					l_content.append_string (next_entity)
				else
--| Should we ignore non printable character?					
--					if c.is_printable then
					l_content.append_character (c)
--					end
				end
			end
			callbacks.on_finish
		end

	parse_start_tag
			-- Parse for start tag.
		local
			t: STRING
			c: CHARACTER
			att: like next_attribute_data
			done: BOOLEAN
		do
			t := next_tag
			callbacks.on_start_tag (Void, Void, t)
			c := current_character
			if c.is_space then
				c := next_non_space_character
			end
			inspect
				c
			when '>' then
				callbacks.on_start_tag_finish
			when '/' then
				c := next_character
--				c := next_non_space_character -- less strict?
				if c = '>' then
					callbacks.on_start_tag_finish
					callbacks.on_end_tag (Void, Void, t)
				else
					report_error ("unexpected character after closing / in start tag")
				end
			else
				rewind_character
				from
					done := False
				until
					done or error_occurred
				loop
					att := next_attribute_data
					if att /= Void then
						callbacks.on_attribute (Void, att.prefix_part, att.local_part, att.value)
						rewind_character
					else
						c := current_character
						inspect c
						when '>' then
							callbacks.on_start_tag_finish
						when '/' then
							c := next_character
--							c := next_non_space_character -- less strict?							
							if c = '>' then
								done := True
								callbacks.on_start_tag_finish
								callbacks.on_end_tag (Void, Void, t)
							else
								report_error ("unexpected character after closing / in start tag")
							end
						else
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
			c: CHARACTER
		do
			t := next_tag
			c := current_character
			if c.is_space then
				c := next_non_space_character
			end
			if c = '>' then
				callbacks.on_end_tag (Void, Void, t)
			else
				report_error ("unexpected character in end tag")
			end
		end

	parse_declaration
			-- Parse for xml declaration
		local
			c: CHARACTER
			t: like next_tag
			l_version, l_encoding: detachable STRING
			l_standalone: BOOLEAN
			l_name: STRING
			done: BOOLEAN
			att: like next_attribute_data
		do
			l_standalone := True
			t := next_tag
			if not t.is_case_insensitive_equal ("xml") then
				report_error ("unsupported declaration <?" + t + " ...")
			end
			if not error_occurred then
				c := current_character
				if c.is_space then
					c := next_non_space_character
				end
				inspect
					c
				when '?' then
					c := next_non_space_character
					if c = '>' then
						if l_version /= Void then
							callbacks.on_xml_declaration (l_version, l_encoding, l_standalone)
						else
							report_error ("missing version in xml declaration")
						end
					else
						report_error ("unexpected character after closing ? in xml declaration")
					end
				else
					rewind_character
					from
						done := False
					until
						done or error_occurred
					loop
						att := next_attribute_data
						if att /= Void then
							l_name := att.local_part
							l_name.to_lower
							if l_name ~ "version" then
								l_version := att.value
							elseif l_name ~ "encoding" then
								l_encoding := att.value
							elseif l_name ~ "standalone" then
								l_standalone := True
							else
								report_error ("unknown xml declaration attribute [" + l_name + "]")
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
									report_error ("unexpected character after closing ? in xml declaration")
								end
							else
							end
							done := True
						end
					end
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
					s := new_string_comment_value

					from
						c := next_character
					until
						done or error_occurred
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
						elseif c = '&' then
							s.append_string (next_entity)
							c := next_character
						else
							s.append_character (c)
							c := next_character
						end
					end
					if error_occurred then
						report_error ("could not find end of comment")
					else
						callbacks.on_comment (s.string)
					end
					s.wipe_out
				end
			end
		ensure
			new_string_comment_value_is_empty: new_string_comment_value.is_empty
		end

	report_error (a_message: STRING)
			-- Report error with message `a_message'
		require
			a_message_attached: a_message /= Void
		local
			s: STRING
		do
			error_occurred := True

			create s.make_from_string (a_message)
			s.append_character (' ')
			s.append_character ('(')
			s.append_string ("position=")
			s.append_integer (buffer.index)

			s.append_character (' ')
			s.append_string ("line=")
			s.append_integer (line)

			s.append_character (' ')
			s.append_string ("column=")
			s.append_integer (column)
			s.append_character (')')

			callbacks.on_error (s)
		end

feature {XML_CALLBACKS} -- Error

	report_error_from_callback (a_msg: STRING)
			-- Report error from callbacks
		do
			report_error (a_msg)
		end

feature {NONE} -- Query

	current_character: CHARACTER
			-- Character at current buffer's position
		do
			Result := buffer.last_character
		end

	rewind_character
			-- Rewind by 1 character
		do
			buffer.rewind
		end

	next_character: CHARACTER
			-- Return next character
			-- move index
		local
			buf: like buffer
		do
			buf := buffer
			if not buf.end_of_input then
				buf.read_character
				Result := buf.last_character
				if cr_character_ignored and Result = '%R' then
					from
					until
						Result /= '%R'
					loop
						buf.read_character
						Result := buf.last_character
					end
				end
			else
				report_error ("no more character")
			end
		end

	next_non_space_character: CHARACTER
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

	next_tag: STRING
			-- Return next tag value
			-- move index
		local
			c: CHARACTER
			s: STRING
		do
			s := new_string_tag

			from
				c := next_non_space_character
			until
				not valid_tag_character (c)
			loop
				s.append_character (c)
				c := next_character
			end
			Result := s.string
			s.wipe_out
		ensure
			new_string_tag_is_empty: new_string_tag.is_empty
		end

	next_entity: STRING
			-- Return next entity value
			-- move index
		local
			c: CHARACTER
			is_char: BOOLEAN
			is_hexa: BOOLEAN
			s: STRING
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
						-- not yet implemented
						s.prepend_character ('x')
						s.prepend_character ('#')
						s.prepend_character ('&')
						s.append_character (';')
						Result := s
					elseif s.is_integer then
						create Result.make (1)
						Result.append_code (s.to_natural_32)
					else
						s.prepend_character ('&')
						s.append_character (';')
						Result := s
					end
				else
					s.to_lower
					s.prepend_character ('&')
					s.append_character (';')
					create Result.make (1)
					Result.append_character (entity_mapping.item (s))
				end
			else
				s.prepend_character ('&')
				Result := s
			end
		end

	next_attribute_name: TUPLE [prefix_part: detachable STRING; local_part: STRING]
			-- Return next attribute prefix and local part.
			-- move index
		local
			c: CHARACTER
			n: STRING
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

	next_attribute_value: STRING
			-- Return next attribute's value
			-- move index
		local
			c: CHARACTER
			l_in_double_quote: BOOLEAN
			done: BOOLEAN
			s: STRING
		do
			s := new_string_attribute_value

			c := next_character
			if c = '"' then
				l_in_double_quote := True
				c := next_character
			elseif c.is_space then
				report_error ("unexpected space after = in attribute declaration")
			end

			if not error_occurred then
				from
					done := False
				until
					done or error_occurred
				loop
					if not l_in_double_quote and c.is_space then
						done := True
					else
						inspect c
						when '&' then
							-- next amperand value... not yet supported
							s.append_string (next_entity)
						when '"' then
							if l_in_double_quote then
								done := True
							else
								report_error ("unexpected %" in attribute value")
							end
						else
							s.append_character (c)
						end
						c := next_character
					end
				end
			end
			if not error_occurred then
				Result := s.string
			else
				create Result.make_empty
			end
			s.wipe_out
		ensure
			new_string_attribute_value_is_empty: new_string_attribute_value.is_empty
		end

	next_attribute_data: detachable TUPLE [prefix_part: detachable STRING; local_part: STRING; value: STRING]
			-- Return next attribute's data (prefix,local and value)
			-- move index
		local
			c: CHARACTER
			n: STRING
			p, v: detachable STRING
			l_was_space: BOOLEAN
			att_name: like next_attribute_name
		do
			att_name := next_attribute_name
			n := att_name.local_part
			p := att_name.prefix_part
			if n.is_empty then
			else
				c := current_character
				if c.is_space then
					l_was_space := True
					c := next_non_space_character -- FIXME: strict?
				end
				if c = '=' then
					-- now looking for value
				elseif l_was_space then
					-- no value FIXME: strict?
					Result := [p, n, ""]
				else -- not l_was_space
					report_error ("unexpected character in attribute name")
				end
				if not error_occurred and Result = Void then
					check
						c_is_equal_sign: c = '='
					end
					v := next_attribute_value
					if v = Void then
						create v.make_empty
					end
					Result := [p, n, v]
				end
			end
		ensure
			current_character.is_space or current_character = '>' or current_character = '/' or current_character = '?'
		end

feature {NONE} -- Query

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
			when '-', '_', ':' then
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

	empty_buffer: XML_STRING_INPUT_STREAM
			-- Empty buffer
			-- (void-safety: keep `buffer' always attached)
		once
			create Result.make_empty
		end

	new_string_tag: STRING
			-- New string used to get tag name
		do
			Result := tmp_string_tag
		end

	new_string_attribute_name: STRING
			-- New string used to get attribute name
		do
			Result := tmp_string_attribute_name
		end

	new_string_attribute_value: STRING
			-- New string used to get attribute value
		do
			Result := tmp_string_attribute_value
		end

	new_string_comment_value: STRING
			-- New string used to get comment value
		do
			Result := tmp_string_comment_value
		end

feature {NONE} -- Factory: cache

	tmp_string_tag: STRING
			-- Cached string for `new_string_tag'
			-- to limit GC work
		once
			create Result.make (25)
		end

	tmp_string_attribute_name: STRING
			-- Cached string for `new_string_attribute_name'
			-- to limit GC work
		once
			create Result.make (20)
		end

	tmp_string_attribute_value: STRING
			-- Cached string for `new_string_attribute_value'
			-- to limit GC work
		once
			create Result.make (50)
		end

	tmp_string_comment_value: STRING
			-- Cached string for `new_string_comment_value'
			-- to limit GC work
		once
			create Result.make (100)
		end


note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
