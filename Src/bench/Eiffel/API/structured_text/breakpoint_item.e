indexing

	description: 
		"Item to denote a breakpoint.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKPOINT_ITEM

inherit

	TEXT_ITEM

creation
	make, do_nothing

feature -- Initialization

	make (bp: DISPLAYED_BREAK; bp_text: STRING) is
			-- Initialize Current with breakpoint text `bp_text'.
		require
			valid_bp: bp /= Void;
			valid_bp_text: bp_text /= Void
		do
			breakpoint := bp;
			image := bp_text;
		ensure
			breakpoint_set: equal (breakpoint, bp);
			image_set: equal (image, bp_text);
		end;

feature -- Properties

	breakpoint: DISPLAYED_BREAK;
			-- The breakpoint which is represented by `image'.

	image: STRING;
			-- The textual representation.

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current debug new line text to `text'.
        do
			text.process_breakpoint;
        end

end -- class BREAKPOINT_ITEM
