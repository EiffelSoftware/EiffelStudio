indexing
	description	: "Image constants (Image type)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Image_enhmetafile: INTEGER is 3;
			-- Declared in Windows as IMAGE_ENHMETAFILE

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




end -- class WEL_IMAGE_CONSTANTS

