indexing

	description: 
		"Item to denote a breakpoint.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKPOINT_ITEM

inherit

	TEXT_ITEM
		rename
			empty_string as image
		end

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current debug new line text to `text'.
        do
			text.process_breakpoint 
        end

end -- class BREAKPOINT_ITEM
