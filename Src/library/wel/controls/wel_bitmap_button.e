indexing
	description: "A button with a pixmap OR a text on it."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_BUTTON

inherit
	WEL_BUTTON

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Access

	bitmap: WEL_BITMAP
			-- Bitmap currently selected in the button.
			-- A global variable is needed because windows
			-- do not copy this object.

feature -- Status setting

	show_text is
			-- Show the text of the button and not the pixmap.
		require
			exists: exists
		do
			set_style (clear_flag (style, Bs_bitmap))
		end

	show_bitmap is
			-- Show the bitmap of the button and not the text.
		require
			exists: exists
			valid_bitmap: bitmap /= Void
		do
			set_style (set_flag (style, Bs_bitmap))
		end

feature -- Element change

	set_bitmap (bmp: WEL_BITMAP) is
			-- Make `bmp' the new bitmap of the button.
			-- Replace the old bitmap.
		require
			exists: exists
			valid_bitmap: bmp /= Void
		do
			bitmap := bmp
			show_bitmap
			cwin_send_message (item, Bm_setimage, 0, bmp.to_integer)
		end

	unset_bitmap is
			-- Remove the bitmap from the button
		require
			exists: exists
			valid_bitmap: bitmap /= Void
		do
			show_text
			bitmap := Void
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group
						+ Ws_tabstop
		end

end -- class WEL_BITMAP_BUTTON

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
