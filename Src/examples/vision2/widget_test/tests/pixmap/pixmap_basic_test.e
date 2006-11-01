indexing
	description: "Objects that demonstrate EV_PIXMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	pixmaps_required: "2"
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAP_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			pixmap := numbered_pixmap (2)
				-- The minimum size of a pixmap is 0x0 pixels,
				-- so we must assign one, in order for it to be visible.
				-- Note that the current image is displayed in the center.
			pixmap.set_minimum_size (100, 100)
			widget := pixmap
		end
		
feature {NONE} -- Implementation

	pixmap: EV_PIXMAP;
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


end -- class PIXMAP_BASIC_TEST
