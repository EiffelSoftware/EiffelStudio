note
	description: "[
		{XU_STRING_MANIPULATION}.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_STRING_MANIPULATION

feature -- Utility features

	escape_string (a_string: STRING): STRING
			-- Escapes `a_string' so it can be printed
		require
			a_string_attached: attached a_string
		do
			Result := ""
			escape_substring (Result, a_string, 1, a_string.count)
		end

	escape_substring (buffer: STRING; s: STRING; start_index, end_index: INTEGER)
			-- Append escaped version of `s.substring (start_index, end_index)' to `buffer'.
		require
			buffer_not_void: buffer /= Void
			s_not_void: s /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= s.count
			valid_indexes: start_index <= end_index + 1
		local
			i: INTEGER
			c: CHARACTER
			l_area: SPECIAL [CHARACTER]
		do
			from
				i := start_index - 1
				l_area := s.area
			until
				i = end_index
			loop
				c := l_area.item (i)
				inspect c
				when '"', '%%' then
					buffer.append_character ('%%')
					buffer.append_character (c)
				when '%N' then
					buffer.append_character ('%%')
					buffer.append_character ('N')
				else
					if c < ' ' or c > '%/127/' then
							-- Assume ASCII set, sorry--RAM.
						buffer.append_character ('%%')
						buffer.append_character ('/')
						--put_octal (buffer, c.code)
						buffer.append_string (c.code.out)
						buffer.append_character ('/')
					else
						buffer.append_character (c)
					end
				end
				i := i + 1
			variant
				end_index - i + 2
			end
		end

	put_octal (buffer: STRING; i: INTEGER)
			-- Print octal representation of `i' into `buffer'
			--| always generate 3 digits
		local
			val: INTEGER
			l_min_char: INTEGER
		do
			l_min_char := ('0').code
			if i < 64 then
				buffer.append_character ('0')
				if i < 8 then
					buffer.append_character ('0')
					buffer.append_character ((l_min_char + i).to_character_8)
				else
					buffer.append_character ((l_min_char + i // 8).to_character_8)
					buffer.append_character ((l_min_char + i \\ 8).to_character_8)
				end
			else
					-- First we compute the 3rd digit.
				buffer.append_character ((l_min_char + i // 64).to_character_8)
				val := i \\ 64
					-- Then the last digit as if it was a number less than 64.
				buffer.append_character ((l_min_char + val // 8).to_character_8)
				buffer.append_character ((l_min_char + val \\ 8).to_character_8)
			end
		ensure
			count_updated: buffer.count = old buffer.count + 3
		end


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
