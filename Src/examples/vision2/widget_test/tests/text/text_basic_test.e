indexing
	description: "Objects that test EV_TEXT."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create text
			text.set_minimum_size (300, 300)
		
			widget := text
		end
		
feature {NONE} -- Implementation

	text: EV_TEXT
		-- Widget that test is to be performed on.

end -- class TEXT_BASIC_TEST
