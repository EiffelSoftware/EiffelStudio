note
	description: "[
				Parser of *.iron file {IRON_PACKAGE_INFO_FILE}.
				syntax is
				
				package package_name

				project
					proj_name = "path-to-file.ecf"
					proj_name = "path-to-file-safe.ecf"
			
				note
					title: The human title for the package
					description: "The description"
					tags:comma,separated,keywords
					licence: Eiffel Forum v2
					copyright: Copyright....
					link[doc]: https://eiffel.org/doc/....
					link[github] : https://github.com/...
				end
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_INFO_FILE_PARSER

create
	make

feature {NONE} -- Initialization

	make
		do
			create buffer.make_empty
		end

feature -- Access

	error_occurred: BOOLEAN

	callbacks: detachable IRON_PACKAGE_INFO_FILE_PARSER_CALLBACKS assign set_callbacks

feature -- Change

	set_callbacks (v: like callbacks)
		do
			callbacks := v
		end

feature -- Constants

	package_token: STRING = "package"
	setup_token: STRING = "setup"
	project_token: STRING = "project"
	note_token: STRING = "note"
	end_token: STRING = "end"


feature -- Parse

	parse (fn: PATH)
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_readable then
				f.open_read
				parse_file (f)
				f.close
			end
		end

	parse_file (f: FILE)
		require
			f.is_open_read
		local
			done: BOOLEAN
			s: STRING
		do
			create s.make (2_046)
			from
				done := f.exhausted
			until
				done
			loop
				f.read_stream (2_046)
				s.append_string (f.last_string)
				done := f.exhausted or f.last_string.count < 2_046
			end
			parse_text (s)
		end

	parse_text (s: READABLE_STRING_8)
		local
			utf: UTF_CONVERTER
		do
			buffer.wipe_out
			utf.utf_8_string_8_into_escaped_string_32 (s, buffer)
			parse_buffer
		end

feature {NONE} -- Parsing

	parse_buffer
		local
			c: like next_character
			s: STRING_32
		do
			from
				error_occurred := False
				buffer_index := 0
				end_of_input := buffer.is_empty
			until
				end_of_input or error_occurred
			loop
				c := next_non_whitespace_character
				inspect
					c
				when '-' then
					c := previous_character
					parse_comment
				when 'p' then
					c := previous_character
					s := next_alphabetic
					if s.is_case_insensitive_equal (package_token) then
						parse_package_declaration
					elseif s.is_case_insensitive_equal (project_token) then
						parse_projects_declaration
					else
						report_error ("Unexpected character [p].")
					end
				when 's' then
					c := previous_character
					s := next_alphabetic
					if s.is_case_insensitive_equal_general (setup_token) then
						parse_setup_declaration
					else
						report_error ("Unexpected character [s].")
					end
				when 'n' then
					c := previous_character
					s := next_alphabetic
					if s.is_case_insensitive_equal_general (note_token) then
						parse_notes_declaration
					else
						report_error ("Unexpected character [n].")
					end
				when 'e' then
					c := previous_character
					s := next_alphabetic
					if not s.is_case_insensitive_equal (end_token) then
						report_error ("Unexpected character [e].")
					end
				when '%U' then
					if not end_of_input then
						report_error ("Unexpected null character.")
					end
				else
					report_error ({STRING_32} "Unexpected character [" + character_to_string (c) + "].")
				end
			end
		end

	parse_comment
		local
			c: like next_character
			s: STRING_32
		do
			c := next_character
			if c = '-' then
				if not end_of_input then
					c := next_character
					if c = '-' then
						s := next_text_until_eol
						if attached callbacks as cb then
							cb.on_comment (s)
						end
					else
						report_error ({STRING_32} "Unexpected character [" + character_to_string (c) + "].")
					end
				end
			else
				report_error ({STRING_32} "Unexpected character [" + character_to_string (c) + "].")
			end
		end

	parse_package_declaration
		local
			s: READABLE_STRING_32
			c: like next_character
		do
			c := next_non_whitespace_character
			if c /= '%U' and not end_of_input then
				c := previous_character
				s := next_package_name
				if s.is_empty then
					report_error ("Invalid package name")
				else
					if attached callbacks as cb then
						cb.on_package (s)
					end
				end
			end
		end

	parse_setup_declaration
		local
			s: READABLE_STRING_32
			l_parse_notes: BOOLEAN
			l_parse_projects: BOOLEAN
			done: BOOLEAN
			c: like next_character
		do
			c := next_non_whitespace_character
			if c /= '%U' and not end_of_input then
				c := previous_character
				from
					s := next_alpha_numeric_or_dash
					c := previous_character
				until
					end_of_input or done or error_occurred
				loop
					if s.is_empty then
						c := next_character
						if c = '-' then
							c := previous_character
							parse_comment
							if not error_occurred and not end_of_input then
								c := next_non_whitespace_character
								c := previous_character
								s := next_alpha_numeric_or_dash
								c := previous_character
							end
						else
							report_error ("Invalid setup name")
							done := True
						end
					elseif s.is_case_insensitive_equal (project_token) then
							-- End setup ... process projects
						l_parse_projects := True
						done := True
					elseif s.is_case_insensitive_equal (note_token) then
							-- End project ... process note
						l_parse_notes := True
						done := True
					elseif s.is_case_insensitive_equal (end_token) then
							-- Reached end of file declaration
						done := True
					else
						parse_setup_item_declaration (s)
						c := previous_character
						c := next_non_whitespace_character
						from until c /= '-' loop
							c := previous_character
							parse_comment
							c := next_non_whitespace_character
						end
						c := previous_character
						s := next_alpha_numeric_or_dash
						c := previous_character
					end
				end
				if l_parse_notes then
					parse_notes_declaration
				elseif l_parse_projects then
					parse_projects_declaration
				end
			end
		end

	parse_setup_item_declaration (a_setup_name: READABLE_STRING_32)
		local
			s: detachable STRING_32
			l_op: detachable STRING_32
			l_multiline_op_done: BOOLEAN
			c: like next_character
		do
			c := next_non_whitespace_character
			if c = '=' then
				c := next_non_whitespace_character_until_eol
				if c = '%U' then
					report_error ("Syntax error in setup declaration")
				elseif c = '"' then
					c := next_character
					if c = '[' then
							-- detected  "[
						s := next_text_until_eol
						if s.is_whitespace then
								-- now look for ]"
							create l_op.make_empty
							from
							until
								end_of_input or l_multiline_op_done
							loop
								s := next_text_until_eol
								s.right_adjust
								if s.ends_with ("]%"") then
									if s.count = 2 or else s.is_substring_whitespace (1, s.count - 2) then
										 -- reached end of manifest string ...
										 l_multiline_op_done := True
									else
											-- still in manifest text
										l_op.append (s)
										l_op.append_character ('%N')
									end
								else
									l_op.append (s)
									l_op.append_character ('%N')
								end
							end
							if l_multiline_op_done then
								normalize_multiline (l_op)
							end
						else
							 	-- maybe syntax error?
								-- normal quoted text starting with '['
							s.prepend_character (c)
							s.right_adjust
							if s.ends_with ("%"") then
								s.remove_tail (1)
							else
								s.prepend_character ('"') -- maybe syntax error?
							end
							l_op := s
						end
					else
							-- starts with '"' ... however [foo: "bar" and so on] is valid note.
						create s.make_empty
						s.append_character ('"')
						s.append_character (c)
						s.append (next_text_until_eol)
						s.left_adjust
						s.right_adjust
						if s.count >= 2 and s[1] = '"' and s[s.count] = '"' then
							s.remove_head (1)
							s.remove_tail (1)
						end
						l_op := s
						c := next_non_whitespace_character
					end
				elseif c = '%N' then
					create s.make_empty
					l_op := s
				else
					c := previous_character
					s := next_text_until_eol
					s.left_adjust
					s.right_adjust
					l_op := s
				end

				if attached callbacks as cb then
					if l_op = Void then
						l_op := "" -- Error?
					end
					cb.on_setup (a_setup_name, l_op)
				end
			else
				report_error ({STRING_32} "Unexpected character ["+  character_to_string (c) +"].")
			end
		end

	parse_projects_declaration
		local
			s: READABLE_STRING_32
			l_parse_notes: BOOLEAN
			l_parse_setup: BOOLEAN
			done: BOOLEAN
			c: like next_character
		do
			c := next_non_whitespace_character
			if c /= '%U' and not end_of_input then
				from
					c := previous_character
					s := next_alpha_numeric_or_dash
					c := previous_character
				until
					end_of_input or done or error_occurred
				loop
					if s.is_empty then
						c := next_character
						if c = '-' then
							c := previous_character
							parse_comment
							if not error_occurred and not end_of_input then
								c := next_non_whitespace_character
								c := previous_character
								s := next_alpha_numeric_or_dash
								c := previous_character
							end
						else
							report_error ("Invalid project name")
							done := True
						end
					elseif s.is_case_insensitive_equal (setup_token) then
							-- End project ... process setup
						l_parse_setup := True
						done := True
					elseif s.is_case_insensitive_equal (note_token) then
							-- End project ... process note
						l_parse_notes := True
						done := True
					elseif s.is_case_insensitive_equal (end_token) then
							-- Reached end of file declaration
						done := True
					else
						parse_project_item_declaration (s)
						c := previous_character
						c := next_non_whitespace_character
						from until c /= '-' loop
							c := previous_character
							parse_comment
							c := next_non_whitespace_character
						end

						c := previous_character
						s := next_alpha_numeric_or_dash
						c := previous_character
					end
				end
				if l_parse_notes then
					parse_notes_declaration
				elseif l_parse_setup then
					parse_setup_declaration
				end
			end
		end

	parse_project_item_declaration (a_proj_name: READABLE_STRING_32)
		local
			s: STRING_32
			c: like next_character
		do
			c := next_non_whitespace_character
			if c = '=' then
				c := next_non_whitespace_character
				if c = '%U' then
					report_error ("Syntax error in project declaration")
				elseif c = '"' then
					create s.make_empty
					from
						c := next_character
					until
						end_of_input or c = '"'
					loop
						s.append_character (c)
						c := next_character
					end
					if c = '"' then
						if attached callbacks as cb then
							cb.on_project (a_proj_name, s)
						end
						c := next_non_whitespace_character
					end
				else
					s := next_text_until_eol
					s.left_adjust
					s.right_adjust
					if attached callbacks as cb then
						cb.on_project (a_proj_name, s)
					end
				end
			else
				report_error ({STRING_32} "Unexpected character ["+  character_to_string (c) +"].")
			end
		end

	parse_notes_declaration
		local
			s: READABLE_STRING_32
			c: like next_character
			done: BOOLEAN
		do
			c := next_non_whitespace_character
			if c /= '%U' and not end_of_input then
				c := previous_character
				from
					s := next_alpha_numeric_with_bracket
					c := previous_character
				until
					end_of_input or done or error_occurred
				loop
					if s.is_empty then
						c := next_character
						if c = '-' then
							c := previous_character
							parse_comment
							if not error_occurred and not end_of_input then
								c := next_non_whitespace_character
								c := previous_character
								s := next_alpha_numeric_with_bracket
								c := previous_character
							end
						else
							report_error ("Invalid note name")
							done := True
						end
					elseif s.is_case_insensitive_equal (package_token) then
							-- Reached end of notes declaration
						done := True
					elseif s.is_case_insensitive_equal (setup_token) then
							-- Reached end of notes declaration
						done := True
					elseif s.is_case_insensitive_equal (end_token) then
							-- Reached end of file declaration
						done := True
					else
						parse_note_item_declaration (s)
						c := previous_character
						c := next_non_whitespace_character
						from until c /= '-' loop
							c := previous_character
							parse_comment
							c := next_non_whitespace_character
						end

						c := previous_character
						s := next_alpha_numeric_with_bracket
						c := previous_character
					end
				end
				if done then
					if s.is_case_insensitive_equal (package_token) then
						parse_package_declaration
					elseif s.is_case_insensitive_equal (setup_token) then
						parse_setup_declaration
					end
				end
			end
		end

	parse_note_item_declaration (a_note_name: READABLE_STRING_32)
		local
			s: detachable STRING_32
			l_note: detachable STRING_32
			l_multiline_note_done: BOOLEAN
			c: like next_character
		do
			c := next_non_whitespace_character
			if c = ':' then
				c := next_non_whitespace_character_until_eol
				if c = '%U' then
					report_error ("Syntax error in note declaration")
				elseif c = '"' then
					c := next_character
					if c = '[' then
							-- detected  "[
						s := next_text_until_eol
						if s.is_whitespace then
								-- now look for ]"
							create l_note.make_empty
							from
							until
								end_of_input or l_multiline_note_done
							loop
								s := next_text_until_eol
								s.right_adjust
								if s.ends_with ("]%"") then
									if s.count = 2 or else s.is_substring_whitespace (1, s.count - 2) then
										 -- reached end of manifest string ...
										 l_multiline_note_done := True
									else
											-- still in manifest text
										l_note.append (s)
										l_note.append_character ('%N')
									end
								else
									l_note.append (s)
									l_note.append_character ('%N')
								end
							end
							if l_multiline_note_done then
								normalize_multiline (l_note)
							end
						else
							 	-- maybe syntax error?
								-- normal quoted text starting with '['
							s.prepend_character (c)
							s.right_adjust
							if s.ends_with ("%"") then
								s.remove_tail (1)
							else
								s.prepend_character ('"') -- maybe syntax error?
							end
							l_note := s
						end
					else
							-- starts with '"' ... however [foo: "bar" and so on] is valid note.
						create s.make_empty
						s.append_character ('"')
						s.append_character (c)
						s.append (next_text_until_eol)
						s.left_adjust
						s.right_adjust
						if
							(s.count >= 2 and s[1] = '"' and s[s.count] = '"') and then
							s.index_of ('"', 2) = s.count -- No '"' inside, ex: ` "license" "MIT" ` .
						then
							s.remove_head (1)
							s.remove_tail (1)
						end
						l_note := s
						c := next_non_whitespace_character
					end
				elseif c = '%N' then
					create s.make_empty
					l_note := s
				else
					c := previous_character
					s := next_text_until_eol
					s.left_adjust
					s.right_adjust
					l_note := s
				end

				if attached callbacks as cb then
					if l_note = Void then
						l_note := "" -- Error?
					end
					cb.on_note (a_note_name, l_note)
				end
			else
				report_error ({STRING_32} "Unexpected character ["+  character_to_string (c) +"].")
			end
		end

feature {NONE} -- Implementation

	report_error (m: READABLE_STRING_32)
		do
			error_occurred := True
			if attached callbacks as cb then
				cb.on_error (m)
			end
		end

	previous_character: CHARACTER_32
		do
			if buffer_index >= 1 then
				buffer_index := buffer_index - 1
				if buffer_index > 0 then
					Result := buffer[buffer_index]
				else
					Result := '%U'
				end
				update_end_of_input
			else
				Result := '%U'
				report_error ("out of input")
			end
		end

	next_character: CHARACTER_32
		do
			if end_of_input then
				report_error ("out of input")
				Result := '%U'
			else
				buffer_index := buffer_index + 1
				Result := buffer [buffer_index]
				update_end_of_input
			end
		ensure
			not end_of_input implies Result /= '%U'
		end

	update_end_of_input
		do
			end_of_input := buffer_index > buffer.count
		end

	next_non_whitespace_character: CHARACTER_32
		do
			if end_of_input then
				report_error ("out of input")
				Result := '%U'
			else
				from
					Result := next_character
				until
					end_of_input or not Result.is_space
				loop
					Result := next_character
				end
			end
		end

	next_non_whitespace_character_until_eol: CHARACTER_32
		do
			if end_of_input then
				report_error ("out of input")
				Result := '%U'
			else
				from
					Result := next_character
				until
					end_of_input or not Result.is_space or Result = '%N'
				loop
					Result := next_character
				end
			end
		end

	next_text_until_eol: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or c = '%N'
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_alphabetic: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha)
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_alpha_betic: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha or c = '_')
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_package_name: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha_numeric or c = '_' or c = '-' or c = '+')
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_alpha_numeric: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha_numeric or c = '_')
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_alpha_numeric_or_dash: STRING_32
		require
			not end_of_input
		local
			c: like next_character
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha_numeric or c = '_' or c = '-')
			loop
				Result.append_character (c)
				c := next_character
			end
		end

	next_alpha_numeric_with_bracket: STRING_32
		require
			not end_of_input
		local
			c: like next_character
			l_in_bracket: INTEGER
		do
			create Result.make_empty
			from
				c := next_character
			until
				end_of_input or not (c.is_alpha_numeric or c = '_' or c = '[' or c = ']')
			loop
				Result.append_character (c)
				c := next_character
				if l_in_bracket > 0 then
					if c /= ']' then
						l_in_bracket := l_in_bracket - 1
					end
				else
					if c = '[' then
						l_in_bracket := l_in_bracket + 1
					end
				end
			end
			if l_in_bracket > 0 then
				report_error ({STRING_32} "Invalid note name with bracket %""+ Result +"%"")
			end
		end

	character_to_string (c: CHARACTER_32): STRING_32
		do
			create Result.make (1)
			Result.append_character (c)
		end

	normalize_multiline	(s: STRING_32)
			-- Remove common heading spaces sequence from every line.
			--| first the code identifies the common heading spaces sequence as `l_prefix'
			--| then it removes this prefix from the beginning of all lines.
			--| For instance, if every line starts with "%T%T", this sequence will be removed.
		local
			i,j,k,m,n: INTEGER
			l_prefix: detachable STRING_32
		do
			from
				i := 1
				j := i
				n := s.count
			until
				i > n
			loop
				k := s.index_of ('%N', i)
				if k = 0 then
					k := n
				end
				if k = i then
						-- Ignore empty line.
				elseif l_prefix = Void then
						-- No prefix identified for now, so let's compute it with the header spaces.
					from
						j := i
					until
						not s[j].is_space
					loop
						j := j + 1
					end
					l_prefix := s.substring (i, j - 1)
				else
						-- Check if the current line starts with `l_prefix'
					from
						j := i
						m := 1
					until
						m > l_prefix.count or l_prefix[m] /= s[j] or j > k
					loop
						m := m + 1
						j := j + 1
					end
					if m <= l_prefix.count and l_prefix[m] /= s[j] then
							-- the current line does not start with the full `l_prefix'
							-- so keep only the common part as the new `l_prefix'.
						l_prefix.keep_head (m - 1)
					end
				end
				i := k + 1
			end
			if l_prefix /= Void and then l_prefix.count > 0 then
					-- A common spaces sequence prefix was found
					-- so remove this prefix from each line.
					-- With a special case for first line.
				if s.starts_with (l_prefix) then
					s.remove_head (l_prefix.count)
				end
				s.replace_substring_all ({STRING_32} "%N" + l_prefix, {STRING_32} "%N")
			end
		end

	buffer: STRING_32

	buffer_index: INTEGER

	end_of_input: BOOLEAN

invariant
	buffer_index <= buffer.count + 1
note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
