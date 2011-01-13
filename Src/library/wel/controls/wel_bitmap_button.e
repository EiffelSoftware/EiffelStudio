note
	description: "A button with a pixmap OR a text on it."
	legal: "See notice at end of class."
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

create
	make,
	make_by_id

feature {NONE} -- Initialisation

	make (a_parent: WEL_WINDOW; a_name: READABLE_STRING_GENERAL; a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a button.
		do
			Precursor {WEL_BUTTON} (a_parent, a_name, a_x, a_y, a_width, a_height, an_id)
			current_pixmap := -1
		ensure then
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end

	make_by_id (a_parent: WEL_DIALOG; an_id: INTEGER)
			-- Make a control identified by `an_id' with `a_parent'
			-- as parent.
		do
			Precursor {WEL_BUTTON} (a_parent, an_id)
			current_pixmap := -1
		ensure then
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end

feature -- Access

	bitmap: WEL_BITMAP
			-- Bitmap currently selected in the button.
			-- A global variable is needed because windows
			-- do not copy this object.
		require
			current_pixmap = Image_bitmap
		local
			l_bitmap: like internal_bitmap
		do
			l_bitmap := internal_bitmap
				-- Per precondition
			check l_bitmap_attached: l_bitmap /= Void end
			Result := l_bitmap
		end

	icon: WEL_ICON
			-- Icon currently selected in the button.
			-- A global variable is needed because windows
			-- do not copy this object.
		require
			current_pixmap = Image_icon
		local
			l_icon: like internal_icon
		do
			l_icon := internal_icon
				-- Per precondition
			check l_icon_attached: l_icon /= Void end
			Result := l_icon
		end

	current_pixmap: INTEGER
			-- Value is Image_bitmap if a bitmap is set,
			-- and Image_icon if an icon is set.

feature -- Status setting

	show_text
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

	show_bitmap
			-- Show the bitmap of the button and not the text.
		require
			exists: exists
			valid_bitmap : current_pixmap = Image_bitmap implies bitmap /= Void
		do
			set_style (set_flag (style, Bs_bitmap))
		end

	show_icon
			-- Show the icon of the button and not the text.
		require
			exists: exists
			valid_icon: current_pixmap = Image_icon implies icon /= Void
		do
			set_style (set_flag (style, Bs_icon))
		end

feature -- Element change

	set_bitmap (a_bitmap: WEL_BITMAP)
			-- Make `bmp' the new bitmap of the button.
			-- Replace the old bitmap.
		require
			exists: exists
			valid_bitmap: a_bitmap /= Void
		local
			l_bitmap: like internal_bitmap
		do
			l_bitmap := internal_bitmap
			if l_bitmap /= Void and then l_bitmap.reference_tracked then
				l_bitmap.decrement_reference
			end
			l_bitmap := a_bitmap
			internal_bitmap := l_bitmap
			if l_bitmap.reference_tracked then
				l_bitmap.increment_reference
			end
			current_pixmap := Image_bitmap
			show_bitmap
			{WEL_API}.send_message (item, Bm_setimage, to_wparam (Image_bitmap), a_bitmap.item)
		end

	set_icon (an_icon: WEL_ICON)
			-- Make `ico' the new icon of the button.
			-- Replace the old icon.
		require
			exists: exists
			valid_icon: an_icon /= Void
		local
			l_icon: like internal_icon
		do
			l_icon := internal_icon
			if l_icon /= Void and then l_icon.reference_tracked then
				l_icon.decrement_reference
			end
			l_icon := an_icon
			internal_icon := l_icon
			if l_icon.reference_tracked then
				l_icon.increment_reference
			end
			current_pixmap := Image_icon
			show_icon
			{WEL_API}.send_message (item, Bm_setimage, to_wparam (Image_icon), an_icon.item)
		end

	unset_bitmap, unset_icon
			-- Remove the bitmap or the icon from the button
		require
			exists: exists
			valid_bitmap: bitmap /= Void or icon /= Void
		local
			l_bitmap: like internal_bitmap
			l_icon: like internal_icon
		do
			show_text
			l_bitmap := internal_bitmap
			if l_bitmap /= Void then
				if l_bitmap.reference_tracked then
					l_bitmap.decrement_reference
				end
				internal_bitmap := Void
			end
			if l_icon /= Void then
				if l_icon.reference_tracked then
					l_icon.decrement_reference
				end
				internal_icon := Void
			end
			current_pixmap := -1
		ensure
			pixmap_not_set: current_pixmap /= Image_icon and current_pixmap /= Image_bitmap
		end

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group
						+ Ws_tabstop
		end

	internal_bitmap: detachable WEL_BITMAP
			-- Bitmap currently selected in the button. Void if none

	internal_icon: detachable WEL_ICON;
			-- Bitmap currently selected in the button. Void if none

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_BITMAP_BUTTON

