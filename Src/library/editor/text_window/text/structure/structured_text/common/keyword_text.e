indexing

	description: 
		"Keyword text.";
	date: "$Date$";
	revision: "$Revision $"

class KEYWORD_TEXT

inherit

	BASIC_TEXT
		redefine
			append_to
		end

create

	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append keyword text to `text'.
		do
			text.process_keyword_text (Current)
		end

end -- class KEYWORD_TEXT
