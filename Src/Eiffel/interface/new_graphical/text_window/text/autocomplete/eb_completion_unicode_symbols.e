note
	description: "[
			Table of unicode symbols indexed by title, for code completion purpose.
			See 	https://en.wikipedia.org/wiki/Mathematical_Operators
					https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode
					https://www.unicode.org/charts/PDF/U2200.pdf
		]"

	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Unicode symbols for math", "protocol=URI", "src=https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode", "tag=symbol"
	EIS: "name=Math Symbol", "protocol=URI", "src=https://www.compart.com/en/unicode/category/Sm", "tag=symbol"

class
	EB_COMPLETION_UNICODE_SYMBOLS

inherit
	EIFFEL_LAYOUT

	TABLE_ITERABLE [STRING_32, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make_caseless (30)
			create sections.make_caseless (10)
			load
		end

feature -- Access

	items: STRING_TABLE [STRING_32]

	sections: STRING_TABLE [LIST [TUPLE [symbol: STRING_32; description: READABLE_STRING_GENERAL]]]

	new_cursor: TABLE_ITERATION_CURSOR [STRING_32, READABLE_STRING_GENERAL]
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
			l_line: STRING
			s32: STRING_32
			l_section_name: STRING
			l_section_list: detachable LIST [TUPLE [symbol: STRING_32; description: READABLE_STRING_GENERAL]]
			symb: STRING_32
			i,j: INTEGER
		do
			p := eiffel_layout.eifinit_path.extended ("unicode_symbols.cfg")
			if attached eiffel_layout.user_priority_file_name (p, True) as pp then
				p := pp
			end
			items.wipe_out
			sections.wipe_out
			l_section_name := "Default"
			l_section_list := sections [l_section_name]
			if l_section_list = Void then
				create {ARRAYED_LIST [TUPLE [symbol: STRING_32; desc: READABLE_STRING_GENERAL]]} l_section_list.make (10)
				sections.put (l_section_list, l_section_name)
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
					if l_line.is_empty then
							-- Ignore line
					elseif l_line.starts_with_general ("--") then
						if l_line.count > 2 and then l_line[3] = '[' then
							j := l_line.index_of (']', 3)
							if j > 3 then
								l_section_name := l_line.substring (4, j - 1)
								l_section_name.adjust
								l_section_list := sections [l_section_name]
								if l_section_list = Void then
									create {ARRAYED_LIST [TUPLE [symbol: STRING_32; desc: READABLE_STRING_GENERAL]]} l_section_list.make (10)
									sections.put (l_section_list, l_section_name)
								end

							else
								-- Ignore line
							end
						else
							-- Ignore line
						end
					else
							-- format: `character code`:`name`
						symb := Void
						s32 := Void
						i := l_line.index_of (':', 1)
						if i > 0 then
							symb := symbol_from_string (l_line.head (i - 1))
							s32 := utf.utf_8_string_8_to_string_32 (l_line.substring (i + 1, l_line.count))
							s32.left_adjust
						else
							symb := symbol_from_string (l_line)
						end
						if symb /= Void and then not symb.is_empty and then symb [1] /= '%U' then
							if s32 = Void then
								s32 := symb
							end
							items [s32] := symb
							l_section_list.force ([symb, s32])
						end
					end
				end
				f.close
			else
					-- Hardcoded
					-- Miscellaneous mathematical symbols
				items ["For all"] := {STRING_32} "%/8704/"
				items ["Complement"] := {STRING_32} "%/8705/"
				items ["Partial differential"] := {STRING_32} "%/8706/"
				items ["There exists"] := {STRING_32} "%/8707/"
				items ["There does not exists"] := {STRING_32} "%/8708/"
				items ["Empty set"] := {STRING_32} "%/8709/"
				items ["Increment"] := {STRING_32} "%/8710/"
				items ["Nabla"] := {STRING_32} "%/8711/"
					-- Set membership
				items ["Element_of"] := {STRING_32} "%/8712/"
				items ["Not an element of"] := {STRING_32} "%/8713/"
				items ["Small element of"] := {STRING_32} "%/8714/"
				items ["Contains as member"] := {STRING_32} "%/8715/"
				items ["Does not contain as member"] := {STRING_32} "%/8716/"
					-- Miscellaneous mathematical symbol
				items ["End of proof"] := {STRING_32} "%/8717/"
					-- N-ary operators
				items ["N-ary product"] := {STRING_32} "%/8718/"
				items ["N-ary coproduct"] := {STRING_32} "%/8719/"
				items ["N-ary summation"] := {STRING_32} "%/8720/"
					-- ...
					-- Operators
				items ["Minus sign"] := {STRING_32} "%/8721/"
				items ["Minus-or-plus sign"] := {STRING_32} "%/8722/"
				items ["Dot plus"] := {STRING_32} "%/8723/"
					-- ..
				items ["Ring operator"] := {STRING_32} "%/8728/"
				items ["Bullet operator"] := {STRING_32} "%/8729/"
				items ["Square root"] := {STRING_32} "%/8730/"
				items ["Cube root"] := {STRING_32} "%/8731/"
				items ["Fourth root"] := {STRING_32} "%/8732/"
				items ["Proportional to"] := {STRING_32} "%/8733/"
					-- Miscellaneous mathematical symbol
				items ["Infinity"] := {STRING_32} "%/8734/"
					-- ..
					-- Logical and set operators
				items ["Logical AND"] := {STRING_32} "%/8743/"
				items ["Logical OR"] := {STRING_32} "%/8744/"
				items ["Intersection"] := {STRING_32} "%/8745/"
				items ["Union"] := {STRING_32} "%/8746/"
				across
					items as ic
				loop
					l_section_list.extend ([ic.item, ic.key])
				end
			end
		end

	symbol_from_string (a_string: READABLE_STRING_8): STRING_32
		local
			i,j: INTEGER
			s: STRING_32
		do
			s := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_string)
			j := s.index_of ('>', 1)
			if j = 0 then
				create Result.make (1)
				append_unescape_string (s, Result)
			else
				create Result.make (s.occurrences ('>') + 1)
				from
					i := 1
				until
					j = 0
				loop
					append_unescape_string (s.substring (i, j - 1), Result)
					i := j + 1
					j := s.index_of ('>', i)
					if j = 0 and i < s.count then
						j := s.count + 1
					end
				end
			end
		end

	append_unescape_string (s: READABLE_STRING_32; a_target: STRING_32)
		local
			i: INTEGER
			s32: STRING_32
			utf: UTF_CONVERTER
		do
			if s.starts_with_general ("0x") or s.starts_with_general ("U+") then
				i := {HEXADECIMAL_STRING_CONVERTER}.hex_to_integer_32 (s.substring (3, s.count))
				a_target.append_character (i.to_character_32)
			elseif s.count >= 3 and s.is_integer then
				i := s.to_integer
				if i >= 128 then
					a_target.append_character (i.to_character_32)
				end
			else
				a_target.append (s)
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
