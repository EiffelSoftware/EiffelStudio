class LOCAL_FORMAT

feature {FORMAT_CONTEXT} -- Implementation

	dot_needed: BOOLEAN;
			-- Will a dot be needed before next call?

	illegal_operator: BOOLEAN;
			-- Is an operator illegal here?
			-- True after `$' or `like'.
			-- If true, operator must be written (prefix/infix "operator")

	indent_between_tokens: BOOLEAN;
			-- Must new line and indent be inserted 
			-- between EIFFEL_LIST tokens?

	indent_depth : INTEGER;
			-- Number of tabs after new line

	insertion_point: CURSOR;
			-- Last position for left parantheses
	
	new_line_before_separator: BOOLEAN;
			-- Must new line and indent be inserted
			-- before a separator?

	position_in_text: CURSOR;
			-- End of text at creation

	separator: TEXT_ITEM;
			-- Separator between tokens of the processed EIFFEL_LIST

	space_between_tokens: BOOLEAN;
			-- Must a space character be inserted 
			-- between EIFFEL_LIST tokens?

feature {FORMAT_CONTEXT} -- Local formatting control

	indent_one_more is
			-- Increase `indent_depth'. 
		do
			indent_depth := indent_depth + 1;
		end;

	indent_one_less is
			-- Decrease `indent_depth'.
		do
			indent_depth := indent_depth - 1;
		end;

	set_dot_needed (b: BOOLEAN) is
			-- Set `dot_needed' to `b'.
		do
			dot_needed := b;
		end;

	set_illegal_operator is
			-- Set illegal operator to true.
		do
			illegal_operator := true;
		end;
	
	set_insertion_point (p: like insertion_point) is
			-- Set `insertion_point' to `p'.
		do
			insertion_point := p;
		end;

	set_must_indent (b: BOOLEAN) is
			-- Set indentation.
		do
			indent_between_tokens := b;
		end;

	set_position(pos: like position_in_text) is
			-- Set `position_in_text' to `pos'.
		do
			position_in_text := pos;
		end;

	set_separator (s: like separator) is
			-- Set `separator' to `s'.	
		do
			separator := s;
		end;

	set_space_between_tokens (b: BOOLEAN) is
			-- Set spacing.
		do
			space_between_tokens := b
		end;

end -- class LOCAL_FORMAT
