indexing

	description: 
		"Item that represents a new line.";
	date: "$Date$";
	revision: "$Revision $"

class NEW_LINE_ITEM

inherit

	TEXT_ITEM

create

	make

feature -- Initialization

	make is
			-- Make a new line.
		do
			image := "%N"
		end;

feature -- Properties

	image: STRING;
			-- Image representing Current

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current basic text to `text'.
        do
			text.process_new_line (Current)
        end

end -- class NEW_LINE_ITEM
