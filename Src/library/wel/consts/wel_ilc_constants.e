indexing
	description	: "Image List Color constants."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ILC_CONSTANTS

feature -- Access

	Ilc_color: INTEGER is 0
			-- Use the default behavior if none of the other
			-- ILC_COLOR* flags is specified. Typically, the
			-- Default is Ilc_color4, but for older 
			-- display drivers, the default is Ilc_colorddb.
			--
			-- Declared in Windows as ILC_COLOR

	Ilc_color4: INTEGER is 4
			-- Use a 4-bit (16-color) device-independent bitmap (DIB)
			-- section as the bitmap for the image list.
			--
			-- Declared in Windows as ILC_COLOR4

	Ilc_color8: INTEGER is 8
			-- Use an 8-bit DIB section. The colors used for the color
			-- table are the same colors as the halftone palette. 
			--
			-- Declared in Windows as ILC_COLOR8

	Ilc_color16: INTEGER is 16
			-- Use a 16-bit (32/64k-color) DIB section. 
			--
			-- Declared in Windows as ILC_COLOR16

	Ilc_color24: INTEGER is 24
			-- Use a 24-bit DIB section.
			--
			-- Declared in Windows as ILC_COLOR24

	Ilc_color32: INTEGER is 32
			-- Use a 32-bit DIB section.
			--
			-- Declared in Windows as ILC_COLOR32

	Ilc_colorddb: INTEGER is 254
			-- Use a device-dependent bitmap.
			--
			-- Declared in Windows as ILC_COLORDDB

	Ilc_mask: INTEGER is 1
			-- Use a mask. The image list contains two
			-- bitmaps, one of which is a monochrome bitmap
			-- used as a mask. If this value is not included,
			-- the image list contains only one bitmap.
			--
			-- Declared in Windows as ILC_MASK

feature -- Access (ILD constants)

	Ild_normal: INTEGER is 0
			-- Draws the image using the background color for the image
			-- list. If the background color is the CLR_NONE value, the
			-- image is drawn transparently using the mask.
			--
			-- Declared in Windows as ILD_NORMAL

end -- class WEL_ILC_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

