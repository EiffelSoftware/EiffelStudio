indexing

	description: 
		"Text that has an image.";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_TEXT

inherit

	TEXT_ITEM
		redefine
			image
		end

creation

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

	is_special: BOOLEAN;
			-- Is Current special?

	is_comment: BOOLEAN;
			-- Is Current a comment?

	is_keyword: BOOLEAN;
			-- Is Current a keyword?

feature -- Setting

	set_is_keyword is
			-- Set is_keyword to True.
		do
			is_keyword := True
		ensure
			is_keyword: is_keyword
		end;

	set_is_comment is
			-- Set is_comment to True.
		do
			is_comment := True
		ensure
			is_comment: is_comment
		end;

	set_is_special is
			-- Set is_special to True.
		do
			is_special := true;
		ensure
			is_special: is_special
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_basic_text (Current)
		end

end -- class BASIC_TEXT
