indexing
	description: "Image constants (Image type)"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IMAGE_CONSTANTS

feature -- Access

	Image_bitmap: INTEGER is
			-- Bitmap image
		external
			"C [macro %"windows.h%"]"
		alias
			"IMAGE_BITMAP"
		end

	Image_icon : INTEGER is
			-- Icon image
		external
			"C [macro %"windows.h%"]"
		alias
			"IMAGE_ICON "
		end

	Image_cursor: INTEGER is
			-- Cursor image 
		external
			"C [macro %"windows.h%"]"
		alias
			"IMAGE_CURSOR"
		end

	Image_enhmetafile: INTEGER is
			-- Enhanced metafile image 
		external
			"C [macro %"windows.h%"]"
		alias
			"IMAGE_ENHMETAFILE"
		end

end -- class WEL_IMAGE_CONSTANTS
