indexing
	description	: "Image constants (Image type)"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_IMAGE_CONSTANTS

feature -- Access

	Image_bitmap: INTEGER is 0
			-- Declared in Windows as IMAGE_BITMAP

	Image_icon: INTEGER is 1
			-- Declared in Windows as IMAGE_ICON

	Image_cursor: INTEGER is 2
			-- Declared in Windows as IMAGE_CURSOR

	Image_enhmetafile: INTEGER is 3
			-- Declared in Windows as IMAGE_ENHMETAFILE

end -- class WEL_IMAGE_CONSTANTS