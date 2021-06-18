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
			l_line: like {PLAIN_TEXT_FILE}.last_string
			s32: STRING_32
			l_section_name: STRING
			l_section_list: like sections.item
			symb: STRING_32
			i, j: INTEGER
			code: NATURAL_32
		do
			p := eiffel_layout.eifinit_path.extended ("unicode_symbols.cfg")
			if attached eiffel_layout.user_priority_file_name (p, True) as pp then
				p := pp
			end
			items.wipe_out
			sections.wipe_out
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.end_of_file or f.exhausted
				loop
					f.read_line
					l_line := f.last_string
					l_line.adjust
					from
						i := 1
					until
						i > l_line.count or else not l_line [i].is_space
					loop
						i := i + 1
					end
					if
						i <= l_line.count and then
						l_line [i] /= '#' and then
						attached l_line.split (';') as properties and then
						properties.count >=2 and then
						attached properties [1] as codes and then
						attached properties [2] as name
					then
							-- The file comes in standard UCD format:
							-- <code points>; <description>; <section name>
							-- Code points come as a sequence white-space separated hexadecimal numbers without any prefixes.
						create symb.make_empty
						from
							i := 1
						until
							i > codes.count or else not attached symb
						loop
							code := 0
							from
								j := i
							until
								j > codes.count or else codes [j].is_space
							loop
								if codes [j].is_hexa_digit then
									code := code ⧀ 4 + codes [j].to_hexa_digit
								else
									symb := Void
									j := codes.count
								end
								j := j + 1
							end
							if j > i and then attached symb then
									-- A potential code point is found, append it to the completion sequence.
								if j - i <= 8 then
									symb.extend (code.to_character_32)
								else
									symb := Void
								end
								i := j
							else
									-- Skip a white-space character.
								i := i + 1
							end
						end
						l_section_name := Void
						if properties.count >= 3 then
							l_section_name := properties [3]
							l_section_name.adjust
						end
						if not attached l_section_name or else l_section_name.is_empty then
							l_section_name := once "Unsorted"
						end
						if attached symb and then not symb.is_empty then
							l_section_list := sections [l_section_name]
							if not attached l_section_list then
								create {ARRAYED_LIST [like sections.item.item]} l_section_list.make (10)
								sections.put (l_section_list, l_section_name)
							end
							name.adjust
							s32 := if name.is_empty then symb else {UTF_CONVERTER}.utf_8_string_8_to_string_32 (name) end
							items [s32] := symb
							l_section_list.extend ([symb, s32])
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

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
