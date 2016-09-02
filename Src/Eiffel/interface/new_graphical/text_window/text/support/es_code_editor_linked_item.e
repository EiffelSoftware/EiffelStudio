note
	description: "Item representing the information for a token in a linked token chain."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_EDITOR_LINKED_ITEM

inherit
	DEBUG_OUTPUT
		undefine
			is_equal
		end

	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_line: EDITOR_LINE; a_tokens: ITERABLE [EDITOR_TOKEN]; a_start_pos, a_end_pos: INTEGER)
		local
			s: STRING_32
		do
			create s.make_empty
			across
				a_tokens as toks
			loop
				s.append (toks.item.wide_image)
				background_color := toks.item.background_color
			end
			text := s

			line := a_line
			tokens := a_tokens
			start_pos := a_start_pos
			end_pos := a_end_pos
		end

feature -- Access

	text: READABLE_STRING_32 assign set_text
			-- Text in [start_pos:end_pos].

	line: EDITOR_LINE assign set_line
			-- Associated editor line.

	tokens: ITERABLE [EDITOR_TOKEN]
			-- Associated tokens, mainly used to restore color.

	background_color: detachable EV_COLOR
			-- Original background color, used to restore later.

	start_pos: INTEGER assign set_start_pos
			-- Start position of current token region.

	end_pos: INTEGER assign set_end_pos
			-- End position of current token region.

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := start_pos < other.start_pos
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_32)
		do
			text := a_text
		end

	set_line (a_line: EDITOR_LINE)
		do
			line := a_line
		end

	set_start_pos (a_pos: INTEGER)
		do
			start_pos := a_pos
		end

	set_end_pos (a_pos: INTEGER)
		do
			end_pos := a_pos
		end

feature -- Status report

	is_included (a_pos_in_text: INTEGER): BOOLEAN
		do
			Result := start_pos <= a_pos_in_text and a_pos_in_text <= end_pos
		end

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (10)
			Result.append_character ('@')
			if line.is_valid then
				Result.append_integer (line.index)
			else
				Result.append_character ('_')
			end
			Result.append_character (' ')
			Result.append_character ('[')
			Result.append_integer (start_pos)
			Result.append_character ('-')
			Result.append_integer (end_pos)
			Result.append_character (']')
			Result.append_character (' ')
			Result.append ("tok=#")
			across
				tokens as toks
			loop
				Result.append (toks.item.pos_in_text.out)
			end
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
