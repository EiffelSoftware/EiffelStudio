indexing
	description: "Format details related to the output of a format."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_FORMAT

feature -- Properties

	position_in_text: CURSOR
			-- Position of text
			--| Used for rollback

	insertion_point: CURSOR
			-- Last position for left parantheses

	must_abort_on_failure : BOOLEAN
		-- rollback all the EIFFEL_LIST if one token cannot be printed?
		--| eg : true for a manifest array: don't print the array at
		--| all if one item is not exported
		--| false for an assertion: keep printing the following items even
		--| if one must be ommited 

	indent_depth: INTEGER
			-- Number of tabs after new line

feature {FORMAT_CONTEXT, EIFFEL_LIST, STRUCTURED_TEXT}

	new_line_between_tokens: BOOLEAN
			-- Must a new line be inserted 
			-- between EIFFEL_LIST tokens?

feature {FORMAT_CONTEXT, STRUCTURED_TEXT} -- Implementation

	dot_needed: BOOLEAN
			-- Will a dot be needed before next call?

	separator: TEXT_ITEM
			-- Separator between tokens of the processed EIFFEL_LIST

	space_between_tokens: BOOLEAN
			-- Must a space character be inserted 
			-- between EIFFEL_LIST tokens?

feature -- Setting

	set_insertion_point (p: like insertion_point) is
			-- Set `insertion_point' to `p'.
		do
			insertion_point := p
		ensure
			insertion_point = p
		end

	set_position (pos: like position_in_text) is
			-- Set `position_in_text' to `pos'.
		do
			position_in_text := pos
		ensure
			position_in_text = pos
		end

	set_must_abort (b: BOOLEAN) is
			-- Set must_abort_on_failure to b.
		do
			must_abort_on_failure := b
		ensure
			must_abort_on_failure = b
		end

feature {FORMAT_CONTEXT, STRUCTURED_TEXT} -- Local formatting control

	indent is
			-- Increment `indent_depth'. 
		do
			indent_depth := indent_depth + 1
		ensure
			incremented: indent_depth = (old indent_depth) + 1
		end

	exdent is
			-- Decrement `indent_depth'.
		do
			indent_depth := indent_depth - 1
		ensure
			decremented: indent_depth = (old indent_depth) - 1
		end

	set_indent_depth (d: INTEGER) is
			-- Assign `d' to `indent_depth'.
		do
			indent_depth := d
		ensure
			assigned: d = indent_depth
		end

	set_dot_needed (b: BOOLEAN) is
			-- Set `dot_needed' to `b'.
		do
			dot_needed := b
		ensure
			dot_needed  = b
		end

	set_new_line_between_tokens (b: BOOLEAN) is
			-- Set indentation.
		do
			new_line_between_tokens := b
		ensure
			new_line_between_tokens = b
		end

	set_separator (s: like separator) is
			-- Set `separator' to `s'.	
		do
			separator := s
		ensure
			separator = s
		end

	set_space_between_tokens (b: BOOLEAN) is
			-- Set spacing.
		do
			space_between_tokens := b
		ensure
			space_between_tokens = b
		end

end -- class LOCAL_FORMAT
