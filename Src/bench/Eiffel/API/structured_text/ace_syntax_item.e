indexing

	description:
		"Text item to represent an ace syntax error.";
	date: "$Date$";
	revision: "$Revision$"

class ACE_SYNTAX_ITEM

inherit
	ERROR_TEXT
		rename
			make as error_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

	make (a_syntax_error: SYNTAX_ERROR; str: STRING) is
			-- Create Current for `a_syntax_error' in the ace file
			-- with `str' as representation.
		require
			valid_a_syntax_error: a_syntax_error /= Void;
			valid_str: str /= Void
		do
			syntax_error := a_syntax_error;
			error_text := str;
		ensure
			syntax_error_set: equal (syntax_error, a_syntax_error);
			erro_text_set: equal (error_text, str)
		end;

feature -- Properties

	syntax_error: SYNTAX_ERROR;
			-- Syntax error that has been detected.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current to `text'.
		do
			text.process_ace_syntax (Current)
		end;

end -- class ACE_SYNTAX_ITEM
