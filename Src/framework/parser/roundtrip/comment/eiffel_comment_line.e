note
	description: "Object that represents a comment line"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMENT_LINE

inherit
	COMPARABLE
		redefine
			is_equal
		end

	SHARED_ENCODING_CONVERTER
		redefine
			is_equal
		end

create
	make_from_string_32,
	make_with_data_32,
	make_from_other

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make_from_string,
	make_with_data

feature{NONE} -- Implementation

	make_from_string (a_content: STRING)
			-- Make from UTF-8 string.
		require
			a_content_not_void: a_content /= Void
		do
			create content.make_from_string (a_content)
		end

	make_with_data (a_content: STRING; l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER)
			-- Initialize instance.
		require
			a_content_not_void: a_content /= Void
			l_positive: l > 0
			c_positive: c > 0
			p_positive: p > 0
			b_id_positive: b_id > 0
			b_offset_positive: b_offset > 0
		do
			create content.make_from_string (a_content)
			line := l
			column := c
			position := p
			break_id := b_id
			offset := b_offset
			is_in_own_line := own_line
			is_implementation := is_imp
		ensure
			line_set: line = l
			column_set: column = c
			position_set: position = p
			break_id_set: break_id = b_id
			offset_set: offset = b_offset
			is_in_own_line_set: is_in_own_line = own_line
			is_implementation_set: is_implementation = is_imp
		end

	make_from_string_32 (a_content: STRING_32)
		require
			a_content_not_void: a_content /= Void
		do
			make_from_string (encoding_converter.utf32_to_utf8 (a_content))
		end

	make_with_data_32 (a_content: STRING_32; l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER)
			-- Initialize instance.
		require
			a_content_not_void: a_content /= Void
			l_positive: l > 0
			c_positive: c > 0
			p_positive: p > 0
			b_id_positive: b_id > 0
			b_offset_positive: b_offset > 0
		do
			make_with_data (encoding_converter.utf32_to_utf8 (a_content), l, c, p, own_line, is_imp, b_id, b_offset)
		ensure
			line_set: line = l
			column_set: column = c
			position_set: position = p
			break_id_set: break_id = b_id
			offset_set: offset = b_offset
			is_in_own_line_set: is_in_own_line = own_line
			is_implementation_set: is_implementation = is_imp
		end

	make_from_other (a_other: like Current; a_only_content: BOOLEAN)
			-- Make from other comment.
			-- Set `a_only_content' to ignore the rest values.
		require
			a_other_not_void: a_other /= Void
		do
			if a_only_content then
				make_from_string (a_other.content)
			else
				make_with_data (a_other.content,
								a_other.line,
								a_other.column,
								a_other.position,
								a_other.is_in_own_line,
								a_other.is_implementation,
								a_other.break_id,
								a_other.offset)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is comment made of the same character sequence as `other'?
		do
			Result := content.is_equal (other.content)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is comment lexicographically lower than `other'?
		do
			Result := content < other.content
		end

feature -- Setting

	set_arguments (l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER)
			-- Setup arguments of an Eiffel comment line.
		require
			l_positive: l > 0
			c_positive: c > 0
			p_positive: p > 0
			b_id_positive: b_id > 0
			b_offset_positive: b_offset > 0
		do
			line := l
			column := c
			position := p
			break_id := b_id
			offset := b_offset
			is_in_own_line := own_line
			is_implementation := is_imp
		ensure
			line_set: line = l
			column_set: column = c
			position_set: position = p
			break_id_set: break_id = b_id
			offset_set: offset = b_offset
			is_in_own_line_set: is_in_own_line = own_line
			is_implementation_set: is_implementation = is_imp
		end

feature -- Comment content

	content_32: STRING_32
			-- Content in UTF-32
		do
			Result := encoding_converter.utf8_to_utf32 (content)
		end

	line: INTEGER
			-- Line in file of current comment

	column: INTEGER
			-- Start column in file of current comment

	position: INTEGER
			-- Start position in file of current comment

feature {INTERNAL_COMPILER_STRING_EXPORTER, EIFFEL_COMMENT_LINE} -- Comment content

	content: STRING
			-- Comment string

feature

	is_in_own_line: BOOLEAN
			-- Is current comment in its own line?

	is_implementation: BOOLEAN
			-- Is current an implementation comment (e.g. starts with --|)?

	is_exclusion: BOOLEAN
			-- Is current an exclusion comment (e.g. starts from first column of a line)?
		do
			Result := column = 1 and not is_implementation
		end

feature

	break_id: INTEGER
			-- Id of BREAK AST node from which current comes

	offset: INTEGER;
			-- Offset in BREAK AST node

invariant
	content_not_void: content /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
