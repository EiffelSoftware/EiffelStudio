indexing
	description: "Objects that test EV_TEXT."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create text
			text.set_minimum_size (300, 300)
		
			widget := text
		end
		
feature {NONE} -- Implementation

	text: EV_TEXT

end -- class TREE_BASIC_TEST
