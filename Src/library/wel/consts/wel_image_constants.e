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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

