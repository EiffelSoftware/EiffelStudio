indexing

	description: 
		"Comment text when not in `quotes'.";
	date: "$Date$";
	revision: "$Revision $"

class COMMENT_TEXT

inherit

	BASIC_TEXT
		redefine
			append_to
		end

create

	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append comment text to `text'.
		do
			text.process_comment_text (Current)
		end

end -- class COMMENT_TEXT
