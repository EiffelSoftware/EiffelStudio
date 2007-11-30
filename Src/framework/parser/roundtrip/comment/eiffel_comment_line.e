indexing
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

create
	make_from_string,
	make_with_data

feature{NONE} -- Implementation

	make_from_string (a_content: STRING) is
		require
			a_content_not_void: a_content /= Void
		do
			create content.make_from_string (a_content)
		end

	make_with_data (a_content: STRING; l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER) is
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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is comment made of the same character sequence as `other'?
		do
			Result := content.is_equal (other.content)
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is comment lexicographically lower than `other'?
		do
			Result := content < other.content
		end

feature -- Setting

	set_arguments (l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER) is
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

	content: STRING
			-- Comment string

	line: INTEGER
			-- Line in file of current comment

	column: INTEGER
			-- Start column in file of current comment

	position: INTEGER
			-- Start position in file of current comment

feature

	is_in_own_line: BOOLEAN
			-- Is current comment in its own line?

	is_implementation: BOOLEAN
			-- Is current an implementation comment (e.g. starts with --|)?

	is_exclusion: BOOLEAN is
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
end
