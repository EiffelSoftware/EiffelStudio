indexing

	description: 
		"Formats text for an eiffel class.";
	date: "$Date$";
	revision: "$Revision $"

class E_TEXT_FORMATTER

feature -- Properties

	error: BOOLEAN;
			-- Did an error occurred during execution of the format?

	is_clickable: BOOLEAN;
			-- Will the format produce text that is clickable?

	text: STRUCTURED_TEXT;
			-- Result of the format

feature -- Setting

	set_clickable is
			-- Set `is_clickable' to True.
		do
			is_clickable := True
		ensure
			is_clickable: is_clickable
		end;

end -- class E_TEXT_FORMATTER
