indexing
	description: "Objects that demonstrate EV_PIXMAP."
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
		
feature {NONE} -- Implementation

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

	pixmap: EV_PIXMAP

end -- class PIXMAP_BASIC_TEST
