indexing
	description: "A button with a pixmap OR a text on it."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_BUTTON

inherit
	WEL_BUTTON
		redefine
			make, 
			make_by_id
		end

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

	WEL_IMAGE_CONSTANTS

creation
	make,
	make_by_id

feature {NONE} -- Initialisation

	make (a_parent: WEL_WINDOW; a_name: STRING; a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a button.
		do
			{WEL_BUTTON} Precursor (a_parent, a_name, a_x, a_y, a_width, a_height, an_id)
			current_pixmap := -1
		ensure then
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end
		
	make_by_id (a_parent: WEL_DIALOG; an_id: INTEGER) is
			-- Make a control identified by `an_id' with `a_parent'
			-- as parent.
		do
			{WEL_BUTTON} Precursor (a_parent, an_id)
			current_pixmap := -1
		ensure then
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end
		
feature -- Access

	bitmap: WEL_BITMAP is
			-- Bitmap currently selected in the button.
			-- A global variable is needed because windows
			-- do not copy this object.
		require
			current_pixmap = Image_bitmap
		do
			Result := internal_bitmap
		end

	icon: WEL_ICON is
			-- Icon currently selected in the button.
			-- A global variable is needed because windows
			-- do not copy this object.
		require
			current_pixmap = Image_icon
		do
			Result := internal_icon
		end

	current_pixmap: INTEGER
			-- Value is Image_bitmap if a bitmap is set,
			-- and Image_icon if an icon is set.

feature -- Status setting

	show_text is
			-- Show the text of the button and not the pixmap or icon.
		require
			exists: exists
		do
			if internal_bitmap /= Void then
				set_style (clear_flag (style, Bs_bitmap))
				invalidate
			elseif internal_icon /= Void then
				set_style (clear_flag (style, Bs_icon))
				invalidate
			end
		end

	show_bitmap is
			-- Show the bitmap of the button and not the text.
		require
			exists: exists
			valid_bitmap : current_pixmap = Image_bitmap implies bitmap /= Void
		do
			set_style (set_flag (style, Bs_bitmap))
		end

	show_icon is
			-- Show the icon of the button and not the text.
		require
			exists: exists
			valid_icon: current_pixmap = Image_icon implies icon /= Void
		do
			set_style (set_flag (style, Bs_icon))
		end

feature -- Element change

	set_bitmap (a_bitmap: WEL_BITMAP) is
			-- Make `bmp' the new bitmap of the button.
			-- Replace the old bitmap.
		require
			exists: exists
			valid_bitmap: a_bitmap /= Void
		do
			if internal_bitmap /= Void and then internal_bitmap.reference_tracked then
				internal_bitmap.decrement_reference
			end
			internal_bitmap := a_bitmap
			if internal_bitmap.reference_tracked then
				internal_bitmap.increment_reference
			end
			show_bitmap
			cwin_send_message (item, Bm_setimage, Image_bitmap, a_bitmap.to_integer)
		end

	set_icon (an_icon: WEL_ICON) is
			-- Make `ico' the new icon of the button.
			-- Replace the old icon.
		require
			exists: exists
			valid_icon: an_icon /= Void
		do
			if internal_icon /= Void and then internal_icon.reference_tracked then
				internal_icon.decrement_reference
			end
			internal_icon := an_icon
			if internal_icon.reference_tracked then
				internal_icon.increment_reference
			end
			show_icon
			cwin_send_message (item, Bm_setimage, Image_icon, an_icon.to_integer)
		end

	unset_bitmap, unset_icon is
			-- Remove the bitmap or the icon from the button
		require
			exists: exists
			valid_bitmap: bitmap /= Void or icon /= Void
		do
			show_text
			if internal_bitmap /= Void then 
				if internal_bitmap.reference_tracked then
					internal_bitmap.decrement_reference
				end
				internal_bitmap := Void
			end
			if internal_icon /= Void then
				if internal_icon.reference_tracked then
					internal_icon.decrement_reference
				end
				internal_icon := Void
			end
			current_pixmap := -1
		ensure
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group
						+ Ws_tabstop
		end

	internal_bitmap: WEL_BITMAP
			-- Bitmap currently selected in the button. Void if none
	
	internal_icon: WEL_ICON
			-- Bitmap currently selected in the button. Void if none

end -- class WEL_BITMAP_BUTTON

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
