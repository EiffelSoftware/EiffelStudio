indexing
	description: "Objects that demonstrate EV_BUTTON."
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_PIXMAP_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create button.make_with_text ("Displaying a pixmap and text")
			button.set_pixmap (numbered_pixmap (2))
			widget := button
		end
		
feature {NONE} -- Implementation

	button: EV_BUTTON
		-- Widget that test is to be performed on.

end -- class BUTTON_PIXMAP_TEST
