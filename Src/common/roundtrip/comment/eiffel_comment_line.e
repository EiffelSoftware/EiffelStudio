indexing
	description: "Object that represents a comment line"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMENT_LINE

inherit
	STRING

create
	make,
	make_empty,
	make_filled,
	make_from_string,
	make_from_c,
	make_from_cil,
	make_with_data

feature{NONE} -- Implementation

	make_with_data (a_content: STRING; l, c, p: INTEGER; own_line: BOOLEAN; is_imp: BOOLEAN; b_id: INTEGER; b_offset: INTEGER) is
			-- Initialize instance.
		require
			l_positive: l > 0
			c_positive: c > 0
			p_positive: p > 0
			b_id_positive: b_id > 0
			b_offset_positive: b_offset > 0
		do
			make_from_string (a_content)
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

	offset: INTEGER
			-- Offset in BREAK AST node

end
