indexing

	description: 
		"Basic string text.";
	date: "$Date$";
	revision: "$Revision $"

class INDEXING_TEXT

inherit

	BASIC_TEXT
		redefine
			append_to
		end

creation

	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append string `text'.
		do
			text.process_indexing_text (Current)
		end

end -- class STRING_TEXT

