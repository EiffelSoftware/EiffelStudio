indexing
	description: "Objects that demonstrate EV_TOGGLE_BUTTON"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create toggle_button.make_with_text ("Toggle button with pixmap and text")
			toggle_button.set_pixmap (numbered_pixmap (2))
	
			widget := toggle_button
		end
		
feature {NONE} -- Implementation

	toggle_button: EV_TOGGLE_BUTTON;
		-- Widget that test is to be performed on.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TOGGLE_BUTTON_PIXMAP_TEST
