indexing
	description: "Format detail for format output.";
	date: "$Date$";
	revision: "$Revision $"

class LOCAL_FORMAT

feature {FORMAT_CONTEXT, EIFFEL_LIST, STRUCTURED_TEXT}

	new_line_between_tokens: BOOLEAN;
			-- Must a new line be inserted 
			-- between EIFFEL_LIST tokens?

feature {FORMAT_CONTEXT, STRUCTURED_TEXT} -- Implementation

	dot_needed: BOOLEAN;
			-- Will a dot be needed before next call?

	indent_depth: INTEGER;
			-- Number of tabs after new line

	separator: TEXT_ITEM;
			-- Separator between tokens of the processed EIFFEL_LIST

	space_between_tokens: BOOLEAN;
			-- Must a space character be inserted 
			-- between EIFFEL_LIST tokens?

feature {FORMAT_CONTEXT, STRUCTURED_TEXT} -- Local formatting control

	indent is
			-- Increment `indent_depth'. 
		do
			indent_depth := indent_depth + 1;
		ensure
			incremented: indent_depth = (old indent_depth) + 1
		end;

	exdent is
			-- Decrement `indent_depth'.
		do
			indent_depth := indent_depth - 1;
		ensure
			decremented: indent_depth = (old indent_depth) - 1
		end;

	set_dot_needed (b: BOOLEAN) is
			-- Set `dot_needed' to `b'.
		do
			dot_needed := b;
		ensure
			dot_needed  = b
		end;

	set_new_line_between_tokens (b: BOOLEAN) is
			-- Set indentation.
		do
			new_line_between_tokens := b;
		ensure
			new_line_between_tokens = b
		end;

	set_separator (s: like separator) is
			-- Set `separator' to `s'.	
		do
			separator := s;
		ensure
			separator = s
		end;

	set_space_between_tokens (b: BOOLEAN) is
			-- Set spacing.
		do
			space_between_tokens := b
		ensure
			space_between_tokens = b
		end;

end -- class LOCAL_FORMAT
