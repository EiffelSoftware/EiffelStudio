note

	description:
		"Lexical analysis of the resource."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class RESOURCE_LEX

inherit

	BASIC_ROUTINES

feature -- Parsing

	parse_separators
			-- Get rid of the separators and comments.
		require
			resource_file_attached: resource_file /= Void
		local
			l_resource_file: like resource_file
		do
			l_resource_file := resource_file
			check attached l_resource_file end -- implied by precondition `resource_file_attached'
			from
			until
				end_of_line or else
				(last_character /= '%T' and
				last_character /= ' ')
			loop
				read_character
			end
			from
			until
				not end_of_line or l_resource_file.end_of_file
			loop
				read_line
			end
			parse_comments
		end

	parse_comments
			-- Get rid of the comments.
		local
			l_resource_file: like resource_file
		do
			l_resource_file := resource_file
			check attached l_resource_file end -- implied by precondition `resource_file_attached'

			from
			until
				position >= line_count or else
				last_character /= '-' or else
				(attached line as line_l and then
				line_l.item (position + 1) /= '-') -- Implied by position < line_count
			loop
				from
					read_line
				until
					not end_of_line or l_resource_file.end_of_file
				loop
					read_line
				end
			end
		end

	parse_name
			-- Parse a name and put it in `last_token'.
			-- `last_token' is void if a syntax error occurred.
			-- A name as the same form as an Eiffel identifier.
		local
			l_last_token: like last_token
		do
			parse_separators
			if end_of_file then
				last_token := Void
			else
				from
					inspect last_character
					when 'a'..'z', 'A'..'Z' then
						create l_last_token.make (10)
						l_last_token.extend (last_character)
						read_character
					end
					last_token := l_last_token
				until
					not attached l_last_token or end_of_line
				loop
					inspect last_character
					when 'a'..'z', 'A'..'Z', '0'..'9', '_', '.', '-', '+' then
						l_last_token.extend (last_character)
						read_character
					else
						l_last_token := Void
					end
				end
			end
		end

	parse_colon
			-- Parse a colon character.
			-- `last_token' is void if a syntax error occurred.
		do
			parse_separators
			if not end_of_file and then last_character = ':' then
				create last_token.make (0)
				read_character
			else
				last_token := Void
			end
		end

	parse_value
			-- Parse a resource value and put it in `last_token'.
			-- `last_token' is void if a syntax error occurred.
			-- A value is either a word (characters with not blank)
			-- or an Eiffel string.
		local
			stop: BOOLEAN
			l_last_token: like last_token
		do
			parse_separators
			if end_of_file then
				last_token := Void
			elseif last_character = '%"' then
				parse_string
			else
				from
					create l_last_token.make (10)
					last_token := l_last_token
				until
					stop
				loop
					l_last_token.extend (last_character)
					read_character
					if end_of_line then
						stop := true
					elseif last_character = '%T' or last_character = ' ' then
						stop := true
					elseif
						position < line_count and then
						last_character = '-' and
						(attached line as l_line and then l_line.item (position + 1) = '-') -- implied by not `end_of_line' and this feature only called by `parse_file'
					then
						parse_comments
						stop := true
					end
				end
			end
		end

	parse_string
			-- Parse a string and put it in `last_token'.
			-- `last_token' is void if a syntax error occurred.
		require
			not end_of_line and then last_character = '%"'
		local
			l_last_token: like last_token
		do
			from
				read_character
				create l_last_token.make (10)
				last_token := l_last_token
			until
				l_last_token = Void or end_of_line or else
				last_character = '%"'
			loop
				if last_character = '%%' then
					read_character
					if end_of_line then
						read_line
						if
							not end_of_line and then
							last_character = '%%'
						then
							read_character
						else
							last_token := Void
						end
					else
						inspect last_character
						when 'A' then
							l_last_token.extend ('%A')
						when 'B' then
							l_last_token.extend ('%B')
						when 'C' then
							l_last_token.extend ('%C')
						when 'D' then
							l_last_token.extend ('%D')
						when 'F' then
							l_last_token.extend ('%F')
						when 'H' then
							l_last_token.extend ('%H')
						when 'L' then
							l_last_token.extend ('%L')
						when 'N' then
							l_last_token.extend ('%N')
						when 'Q' then
							l_last_token.extend ('%Q')
						when 'R' then
							l_last_token.extend ('%R')
						when 'S' then
							l_last_token.extend ('%S')
						when 'T' then
							l_last_token.extend ('%T')
						when 'U' then
							l_last_token.extend ('%U')
						when 'V' then
							l_last_token.extend ('%V')
						when '%%' then
							l_last_token.extend ('%%')
						when '%'' then
							l_last_token.extend ('%'')
						when '%"' then
							l_last_token.extend ('%"')
						when '(' then
							l_last_token.extend ('%(')
						when ')' then
							l_last_token.extend ('%)')
						when '<' then
							l_last_token.extend ('%<')
						when '>' then
							l_last_token.extend ('%>')
						when '/' then
							parse_char_code
						else
							last_token := Void
						end
						read_character
					end
				else
					l_last_token.extend (last_character)
					read_character
				end
				l_last_token := last_token
			end
			if last_token /= Void and not end_of_line then
					-- Read the last ".
				read_character
			else
				last_token := Void
			end
		end

	parse_char_code
			-- Parse a special character of the form %/../ and insert
			-- it at the end of `last_token'. `last_token' becomes
			-- void if an error occurred.
		require
			last_token_not_void: last_token /= Void
			not end_of_line and then last_character = '/'
		local
			code: STRING
		do
			if attached last_token as l_last_token then
				read_character
				if not end_of_line then
					inspect last_character
					when '0'..'9' then
						create code.make (3)
						code.extend (last_character)
						read_character
						if not end_of_line then
							inspect last_character
							when '0'..'9' then
								code.extend (last_character)
								read_character
								if not end_of_line then
									inspect last_character
									when '0'..'9' then
										code.extend (last_character)
										read_character
										if
											not end_of_line and then
											last_character = '/'
										then
											l_last_token.extend (charconv
																	(code.to_integer))
										else
											last_token := Void
										end
									when '/' then
										l_last_token.extend (charconv
																	(code.to_integer))
									else
										last_token := Void
									end
								else
									last_token := Void
								end
							when '/' then
								l_last_token.extend (charconv (code.to_integer))
							else
								last_token := Void
							end
						else
							last_token := Void
						end
					else
						last_token := Void
					end
				else
					last_token := Void
				end
			else
				check
					from_precondition_last_token_not_void: False
				end
			end
		end

	read_line
			-- Read the next line in `resource_file' and put it in `line'.
			-- Remove the leading blank characters.
		require
			resource_file_attached: resource_file /= Void
		local
			l_resource_file: like resource_file
			l_line: like line
		do
			l_resource_file := resource_file
			check l_resource_file /= Void end -- implied by precondition `resource_file_attached'
			if not l_resource_file.end_of_file then
				l_resource_file.read_line
				l_line := l_resource_file.last_string
				check l_line /= Void end -- implied by postcondition of `read_line'
				line := l_line
				l_line.left_adjust
			else
				create l_line.make (0)
				line := l_line
			end
			line_count := l_line.count

			position := 0
			line_number := line_number + 1
			read_character
		end

	read_character
			-- Read the next character on the `line' and
			-- put it in last_character.
		require
			not_end_of_line: not end_of_line
		do
			position := position + 1
			if not end_of_line then
				if attached line as l_line then
					last_character := l_line.item (position)
				else
					last_character := '%/0/'
					check
						from_precondition_not_end_of_line: False
					end
				end
			end
		end

feature -- Status report

	end_of_line: BOOLEAN
			-- Has the end of the current line been reached?
		do
			Result := position = line_count + 1
		end

	end_of_file: BOOLEAN
			-- Has the end of the `resource_file' been reached?
		require
			resource_file_attached: resource_file /= Void
		do
			Result := end_of_line and (attached resource_file as l_resource_file and then l_resource_file.end_of_file)
		end

feature -- Access

	resource_file: PLAIN_TEXT_FILE
			-- File being parsed.

	last_token: detachable STRING
			-- Last token parsed.

	line: STRING
			-- Line of `resource_file' being parsed.

	line_number: INTEGER
			-- Line number of `line'.

	position: INTEGER
			-- Position of the current position in the current line.

	line_count: INTEGER
			-- Number of character in the current line.

	last_character: CHARACTER
			-- Character at the current position in the `line'.

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
