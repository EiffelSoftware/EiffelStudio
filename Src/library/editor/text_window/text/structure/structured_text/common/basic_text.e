indexing

	description: 
		"Text that has an image.";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_TEXT

inherit

	TEXT_ITEM

create

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize Current basic text with image `text'.
		require
			valid_text: text /= Void
		do
			image := text;
		end;

feature -- Properties

	image: STRING;
			-- Text representation of Current

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_basic_text (Current)
		end

end -- class BASIC_TEXT
