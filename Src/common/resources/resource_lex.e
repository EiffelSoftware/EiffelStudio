indexing

	description:
		"Lexical analysis of the resource."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_LEX

inherit

	BASIC_ROUTINES

feature -- Parsing

	parse_separators is
			-- Get rid of the separators and comments.
		do
			from
			until
				end_of_line or else
				(last_character /= '%T' and
				last_character /= ' ')
			loop
				read_character
			end;
			from
			until
				not end_of_line or resource_file.end_of_file
			loop
				read_line
			end;
			parse_comments
		end;
				
	parse_comments is
			-- Get rid of the comments.
		do
			from
			until
				position >= line_count or else
				last_character /= '-' or else
				line.item (position + 1) /= '-'
			loop
				from
					read_line
				until
					not end_of_line or resource_file.end_of_file
				loop
					read_line
				end
			end
		end;

	parse_name is
			-- Parse a name and put it in `last_token'.
			-- `last_token' is void if a syntax error ocurred.
			-- A name as the same form as an Eiffel identifier.
		local
			stop: BOOLEAN
		do
			parse_separators;
			if end_of_file then
				last_token := Void
			else
				from
					inspect last_character
					when 'a'..'z', 'A'..'Z' then
						create last_token.make (10);
						last_token.extend (last_character);
						read_character
					else
						stop := true;
						last_token := Void
					end
				until
					stop or end_of_line
				loop
					inspect last_character
					when 'a'..'z', 'A'..'Z', '0'..'9', '_', '.', '-', '+' then
						last_token.extend (last_character);
						read_character
					else
						stop := true
					end
				end
			end
		end;

	parse_colon is
			-- Parse a colon character.
			-- `last_token' is void if a syntax error ocurred.
		do
			parse_separators;
			if not end_of_file and then last_character = ':' then
				create last_token.make (0);
				read_character
			else
				last_token := Void
			end
		end;

	parse_value is
			-- Parse a resource value and put it in `last_token'.
			-- `last_token' is void if a syntax error ocurred.
			-- A value is either a word (characters with not blank)
			-- or an Eiffel string.
		local
			stop: BOOLEAN
		do
			parse_separators;
			if end_of_file then
				last_token := Void
			elseif last_character = '%"' then
				parse_string
			else
				from
					create last_token.make (10)
				until
					stop
				loop
					last_token.extend (last_character);
					read_character;
					if end_of_line then
						stop := true
					elseif last_character = '%T' or last_character = ' ' then
						stop := true
					elseif 
						position < line_count and then 
						last_character = '-' and
						line.item (position + 1) = '-'
					then
						parse_comments;
						stop := true
					end
				end
			end
		end;

	parse_string is
			-- Parse a string and put it in `last_token'.
			-- `last_token' is void if a syntax error ocurred.
		require
			not end_of_line and then last_character = '%"'
		do
			from
				read_character;
				create last_token.make (10)
			until
				last_token = Void or end_of_line or else
				last_character = '%"'
			loop
				if last_character = '%%' then
					read_character;
					if end_of_line then
						read_line;
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
							last_token.extend ('%A')
						when 'B' then
							last_token.extend ('%B')
						when 'C' then
							last_token.extend ('%C')
						when 'D' then
							last_token.extend ('%D')
						when 'F' then
							last_token.extend ('%F')
						when 'H' then
							last_token.extend ('%H')
						when 'L' then
							last_token.extend ('%L')
						when 'N' then
							last_token.extend ('%N')
						when 'Q' then
							last_token.extend ('%Q')
						when 'R' then
							last_token.extend ('%R')
						when 'S' then
							last_token.extend ('%S')
						when 'T' then
							last_token.extend ('%T')
						when 'U' then
							last_token.extend ('%U')
						when 'V' then
							last_token.extend ('%V')
						when '%%' then
							last_token.extend ('%%')
						when '%'' then
							last_token.extend ('%'')
						when '%"' then
							last_token.extend ('%"')
						when '(' then
							last_token.extend ('%(')
						when ')' then
							last_token.extend ('%)')
						when '<' then
							last_token.extend ('%<')
						when '>' then
							last_token.extend ('%>')
						when '/' then
							parse_char_code
						else
							last_token := Void
						end;
						read_character
					end	
				else
					last_token.extend (last_character);
					read_character
				end
			end;
			if last_token /= Void and not end_of_line then
					-- Read the last ".
				read_character
			else
				last_token := Void
			end
		end;

	parse_char_code is
			-- Parse a special character of the form %/../ and insert
			-- it at the end of `last_token'. `last_token' becomes
			-- void if an error occurred.
		require
			not end_of_line and then last_character = '/'
		local
			code: STRING
		do
			read_character;
			if not end_of_line then
				inspect last_character
				when '0'..'9' then
					create code.make (3);
					code.extend (last_character)
					read_character;
					if not end_of_line then
						inspect last_character
						when '0'..'9' then
							code.extend (last_character);
							read_character;
							if not end_of_line then
								inspect last_character
								when '0'..'9' then
									code.extend (last_character)
									read_character;
									if 
										not end_of_line and then
										last_character = '/'
									then
										last_token.extend (charconv 
															(code.to_integer))
									else
										last_token := Void
									end
								when '/' then
									last_token.extend (charconv
															(code.to_integer))
								else
									last_token := Void
								end
							else
								last_token := Void
							end
						when '/' then
							last_token.extend (charconv (code.to_integer))
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
		end;

	read_line is
			-- Read the next line in `resource_file' and put it in `line'.
			-- Remove the leading blank characters.
		do
			if not resource_file.end_of_file then
				resource_file.read_line;
				line := resource_file.last_string;
				line.left_adjust
			else
				create line.make (0)
			end;
			line_count := line.count;
			position := 0;
			line_number := line_number + 1;
			read_character
		end;
		
	read_character is
			-- Read the next character on the `line' and 
			-- put it in last_character.
		require
			not_end_of_line: not end_of_line
		do
			position := position + 1;
			if not end_of_line then
				last_character := line.item (position)
			end
		end;

feature -- Status report

	end_of_line: BOOLEAN is
			-- Has the end of the current line been reached?
		do
			Result := position = line_count + 1
		end;

	end_of_file: BOOLEAN is
			-- Has the end of the `resource_file' been reached?
		do
			Result := end_of_line and resource_file.end_of_file
		end;

feature -- Access

	resource_file: PLAIN_TEXT_FILE;
			-- File being parsed

	last_token: STRING;
			-- Last token parsed

	line: STRING;
			-- Line of `resource_file' being parsed

	line_number: INTEGER;
			-- Line number of `line'

	position: INTEGER;
			-- Position of the current position in the current line

	line_count: INTEGER;
			-- Number of character in the current line

	last_character: CHARACTER;
			-- Character at the current position in the `line'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class RESOURCE_LEX
