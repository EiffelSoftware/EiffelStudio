indexing
	description: 
		"Item to padd out start of line. Used on lines that %
		%do not have breakpoints.";
	date: "$Date$";
	revision: "$Revision $"

class PADDED_ITEM

inherit

	TEXT_ITEM
		redefine
			image
		end

feature -- Properties

	image: STRING is "    "

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
		-- Append Current debug new line text to `text'.
		do
			text.process_padded 
		end

end -- class PADDED_ITEM
