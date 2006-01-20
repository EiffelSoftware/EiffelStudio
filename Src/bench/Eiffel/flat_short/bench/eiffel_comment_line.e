indexing
	description: "Object that represents a comment line"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMENT_LINE

create
	make

feature{NONE} -- Implementation

	make (a_content: STRING; l, c, p: INTEGER; own_line: BOOLEAN; b_id: INTEGER; b_offset: INTEGER) is
			-- Initialize instance.
		require
			a_content_not_void: a_content /= Void
			a_content_valid: a_content.count >= 2
			l_positive: l > 0
			c_positive: c > 0
			p_positive: p > 0
			b_id_positive: b_id > 0
			b_offset_positive: b_offset > 0
		do
			content := a_content
			content.replace_substring_all (once "%R", once "")
			line := l
			column := c
			position := p
			break_id := b_id
			offset := b_offset
			is_in_own_line := own_line
		ensure
			content_set: content.is_equal (a_content)
			line_set: line = l
			column_set: column = c
			position_set: position = p
			break_id_set: break_id = b_id
			offset_set: offset = b_offset
			is_in_own_line_set: is_in_own_line = own_line
			implmentation_comment_valid: is_implementation implies is_in_own_line
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

	count: INTEGER is
			-- Length of current comment
		do
			Result := content.count
		end

feature

	is_in_own_line: BOOLEAN
			-- Is current comment in its own line?

	is_implementation: BOOLEAN is
			-- Is current an implementation comment (e.g. starts with --|)?
		do
			Result := content.count >=3 and content.item (3) = '|'
		end

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

invariant
	content_not_void: content /= Void
	content_not_empty: not content.is_empty
	content_is_comment: content.substring (1, 2).is_equal ("--") and
						(is_implementation implies content.item (3) = '|')

end
