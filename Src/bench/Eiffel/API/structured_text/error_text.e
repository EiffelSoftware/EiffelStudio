indexing

	description:
		"Text item to show errors.";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_TEXT

inherit
	BASIC_TEXT
		rename
			image as error_text,
			make as old_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

	make (err: ERROR; str: STRING) is
			-- Initialize Current with `error' `err' and
			-- `error_text' `str'.
		require
			valid_err: err /= Void
			valid_str: str /= Void
		do
			error := err;
			error_text := str;
		ensure
			error_set: equal (error, err);
			error_text_set: equal (error_text, str)
		end;

feature -- Properties

	error: ERROR;
			-- Error represented by `error_text'.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append `error_text' to `text'.
		do
			text.process_error_text (Current)
		end;

end -- class ERROR_TEXT
