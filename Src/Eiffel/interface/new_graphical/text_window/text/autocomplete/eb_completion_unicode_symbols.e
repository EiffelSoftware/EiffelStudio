note
	description: "[
			Table of unicode symbols indexed by title, for code completion purpose.
			See 	https://en.wikipedia.org/wiki/Mathematical_Operators
					https://www.unicode.org/charts/PDF/U2200.pdf
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPLETION_UNICODE_SYMBOLS

inherit
	EIFFEL_LAYOUT

	TABLE_ITERABLE [CHARACTER_32, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make_caseless (30)
			load
		end

feature -- Access

	items: STRING_TABLE [CHARACTER_32]

	new_cursor: TABLE_ITERATION_CURSOR [CHARACTER_32, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

	count: INTEGER
		do
			Result := items.count
		end

feature {NONE} -- Persistency

	load
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			utf: UTF_CONVERTER
			l_line, s32: STRING
			ch: CHARACTER_32
			i: INTEGER
		do
			p := eiffel_layout.eifinit_path.extended ("unicode_symbols.cfg")
			if attached eiffel_layout.user_priority_file_name (p, True) as pp then
				p := pp
			end
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from

				until
					f.end_of_file or f.exhausted
				loop
					f.read_line
					l_line := f.last_string
					l_line.left_adjust
					l_line.right_adjust
					if l_line.is_empty or else l_line.starts_with_general ("--") then
							-- Ignore line
					else
							-- format: `character code`:`name`
						ch := '%U'
						s32 := Void
						i := l_line.index_of (':', 1)
						if i > 0 then
							ch := character_from_string (l_line.head (i - 1))
							s32 := utf.utf_8_string_8_to_string_32 (l_line.substring (i + 1, l_line.count))
							s32.left_adjust
						else
							ch := character_from_string (l_line)
						end
						if ch /= '%U' then
							if s32 /= Void then
								items [s32] := ch
							else
								items [ch.out] := ch
							end
						end
					end
				end
				f.close
			else
					-- Hardcoded
					-- Miscellaneous mathematical symbols
				items ["For all"] := {CHARACTER_32} '%/8704/'
				items ["Complement"] := {CHARACTER_32} '%/8705/'
				items ["Partial differential"] := {CHARACTER_32} '%/8706/'
				items ["There exists"] := {CHARACTER_32} '%/8707/'
				items ["There does not exists"] := {CHARACTER_32} '%/8708/'
				items ["Empty set"] := {CHARACTER_32} '%/8709/'
				items ["Increment"] := {CHARACTER_32} '%/8710/'
				items ["Nabla"] := {CHARACTER_32} '%/8711/'
					-- Set membership
				items ["Element_of"] := {CHARACTER_32} '%/8712/'
				items ["Not an element of"] := {CHARACTER_32} '%/8713/'
				items ["Small element of"] := {CHARACTER_32} '%/8714/'
				items ["Contains as member"] := {CHARACTER_32} '%/8715/'
				items ["Does not contain as member"] := {CHARACTER_32} '%/8716/'
					-- Miscellaneous mathematical symbol
				items ["End of proof"] := {CHARACTER_32} '%/8717/'
					-- N-ary operators
				items ["N-ary product"] := {CHARACTER_32} '%/8718/'
				items ["N-ary coproduct"] := {CHARACTER_32} '%/8719/'
				items ["N-ary summation"] := {CHARACTER_32} '%/8720/'
					-- ...
					-- Operators
				items ["Minus sign"] := {CHARACTER_32} '%/8721/'
				items ["Minus-or-plus sign"] := {CHARACTER_32} '%/8722/'
				items ["Dot plus"] := {CHARACTER_32} '%/8723/'
					-- ..
				items ["Ring operator"] := {CHARACTER_32} '%/8728/'
				items ["Bullet operator"] := {CHARACTER_32} '%/8729/'
				items ["Square root"] := {CHARACTER_32} '%/8730/'
				items ["Cube root"] := {CHARACTER_32} '%/8731/'
				items ["Fourth root"] := {CHARACTER_32} '%/8732/'
				items ["Proportional to"] := {CHARACTER_32} '%/8733/'
					-- Miscellaneous mathematical symbol
				items ["Infinity"] := {CHARACTER_32} '%/8734/'
					-- ..
					-- Logical and set operators
				items ["Logical AND"] := {CHARACTER_32} '%/8743/'
				items ["Logical OR"] := {CHARACTER_32} '%/8744/'
				items ["Intersection"] := {CHARACTER_32} '%/8745/'
				items ["Union"] := {CHARACTER_32} '%/8746/'
			end
		end

	character_from_string (s: READABLE_STRING_8): CHARACTER_32
		local
			i: INTEGER
			s32: STRING_32
			utf: UTF_CONVERTER
			hexconv: HEXADECIMAL_STRING_CONVERTER
		do
			if s.starts_with_general ("0x") then
				i := {HEXADECIMAL_STRING_CONVERTER}.hex_to_integer_32 (s.substring (3, s.count))
				Result := i.to_character_32
			elseif s.count >= 4 and s.is_integer then
				i := s.to_integer
				Result := i.to_character_32
			else
				s32 := utf.utf_8_string_8_to_string_32 (s)
				if s32.count = 1 then
					Result := s32 [1]
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
