indexing

	description: 
		"Text representing %"Result%" or %"Current%".";
	date: "$Date$";
	revision: "$Revision $"

class RESERVED_WORD_TEXT

inherit

	BASIC_TEXT
		redefine
			append_to
		end

creation

	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_reserved_word_text (Current)
		end

end -- class BASIC_TEXT
