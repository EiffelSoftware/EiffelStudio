indexing

	description:
		"Text item to represent a class syntax error.";
	date: "$Date$";
	revision: "$Revision$"

class CL_SYNTAX_ITEM

inherit
	ERROR_TEXT
		rename
			make as error_make
		redefine
			append_to
		end

creation
	make

feature -- Initialization

	make (a_syntax_error: SYNTAX_ERROR; c: CLASS_C; str: STRING) is
			-- Create Current for `a_syntax_error' in `c' with
			-- `str' as representation.
		require
			valid_a_syntax_error: a_syntax_error /= Void;
			valid_c: c /= Void;
			valid_str: str /= Void
		do
			syntax_error := a_syntax_error;
			e_class := c;
			error_text := str;
		ensure
			syntax_error_set: equal (syntax_error, a_syntax_error);
			e_class_set: equal (e_class, c);
			erro_text_set: equal (error_text, str)
		end;

feature -- Properties

	e_class: CLASS_C;
			-- Class where `syntax_error' has been detected.

	syntax_error: SYNTAX_ERROR;
			-- Syntax error that has been detected.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current to `text'.
		do
			text.process_cl_syntax (Current)
		end;

end -- class CL_SYNTAX_ITEM
