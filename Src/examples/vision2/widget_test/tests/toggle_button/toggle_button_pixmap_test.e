indexing
	description: "Objects that demonstrate EV_TOGGLE_BUTTON"
	pixmaps_required: "2"
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_PIXMAP_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create toggle_button.make_with_text ("Toggle button with pixmap and text")
			toggle_button.set_pixmap (numbered_pixmap (2))
	
			widget := toggle_button
		end
		
feature {NONE} -- Implementation

	toggle_button: EV_TOGGLE_BUTTON

end -- class TOGGLE_BUTTON_PIXMAP_TEST
