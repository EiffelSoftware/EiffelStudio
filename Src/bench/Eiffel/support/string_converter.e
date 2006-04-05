indexing
	description: "Object that translates an Eiffel string into a valid C string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class STRING_CONVERTER

feature -- Commands

	escape_string (buffer: STRING; s: STRING) is
			-- Append `buffer' with the escaped version of `s'
		require
			valid_arguments: s /= Void and then buffer /= Void
		do
			escape_substring (buffer, s, 1, s.count)
		end

	escape_substring (buffer: STRING; s: STRING; start_index, end_index: INTEGER) is
			-- Append escaped version of `s.substring (start_index, end_index)' to `buffer'.
		require
			buffer_not_void: buffer /= Void
			s_not_void: s /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= s.count
			valid_indexes: start_index <= end_index + 1
		local
			i: INTEGER
		do
			from
				i := start_index
			variant
				end_index - i + 2
			until
				i > end_index
			loop
				escape_char (buffer, s.item (i))
				i := i + 1
			end
		end

	escape_char (buffer: STRING; c: CHARACTER) is
			-- Write char `c' with C escape sequences
		require
			valid_buffer: buffer /= Void
		do
			inspect c
			 	when '"' then
					buffer.append_character ('\')
					buffer.append_character ('"')
			 	when '\' then
					buffer.append_character ('\')
					buffer.append_character ('\')
				when '%'' then
					buffer.append_character ('\')
					buffer.append_character ('%'')
				when '?' then
					buffer.append_character ('\')
					buffer.append_character ('?')
				else
					if c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
						buffer.append_character ('\')
						putoctal (buffer,c.code)
					else
						buffer.append_character (c)
					end
			end
		end

feature {NONE} -- Implementations

	putoctal (buffer: STRING; i: INTEGER) is
			-- Print octal representation of `i' into `buffer'
			--| always generate 3 digits
		local
			val, remain: INTEGER
			s, t: STRING
		do
			if i = 0 then
				buffer.append ("000")
			elseif i < 8 then
				buffer.append ("00")
				buffer.append_integer (i)
			else
				if i < 64 then
					buffer.append_character ('0')
				end
				
				create s.make (3)
				from
					val := i
				variant
					val + 1
				until
					val = 0
				loop
					remain := val \\ 8
					val := val // 8
					t := remain.out
					s.prepend (t)
				end
				buffer.append (s)
			end
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class STRING_CONVERTER
