--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision push button.%
		% Mswindows implementation."
	status: "See notice at end of class"
--| FIXME
note:
	"On windows, you can only display a text or a pixmap.%N%
	%if you set both the pixmap and the text, only the%N%
	%pixmap will be displayed. On gtk, everything works%N%
	%like it is suppose to be, you have both text and%N%
	%pixmap visible."
	date: "$$"
	revision: "$$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			on_key_down,
			initialize,
			interface
		end
   
	EV_TEXTABLE_IMP
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_interface
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BITMAP_BUTTON
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			text as wel_text,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor,
			on_size,
			show,
			hide
		redefine
			default_style,
			on_bn_clicked,
			set_text
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the button.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 10
		end

	initialize is
			-- Initialize button.
		do
			{EV_PRIMITIVE_IMP} Precursor 
			set_font (font)
		end

feature -- Access

	wel_parent: WEL_WINDOW is
			--|---------------------------------------------------------------
			--| FIXME ARNAUD
			--|---------------------------------------------------------------
			--| Small hack in order to avoid a SEGMENTATION VIOLATION
			--| with Compiler 4.6.008. To remove the hack, simply remove
			--| this feature and replace "parent as wel_window_parent" with
			--| "parent as wel_parent" in the inheritance clause of this class
			--|---------------------------------------------------------------
		do
			Result := wel_window_parent
		end

	text: STRING is
			-- Return text of button, Void if button has no text.
		do
			Result := wel_text
			if Result.count = 0  then
				Result := Void
			end
		end

	extra_width: INTEGER
			-- Extra width on the size.
feature -- Status setting

	set_default_minimum_size is
		-- Reset the button to its default minimum size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			if pixmap_imp /= Void then
				w := extra_width + pixmap_imp.width
				h := 7 * pixmap_imp.height // 4
			elseif text /= "" then
				fw ?= font.implementation
				check
					font_not_void: fw /= Void
				end
				w := extra_width + fw.string_width (safe_text)
				h := 7 * fw.height // 4 
			else
				w := extra_width
				h := 7
			end

			-- Finaly, we set the minimum values.
			internal_set_minimum_size (w, h)
		end

	align_text_left is
			-- Set button `text' to be left aligned.
		do
			set_style (default_style + Bs_left)
			invalidate
		end

	align_text_right is
			-- Set button `text' to be right aligned.
		do
			set_style(default_style + Bs_right)
			invalidate
		end

	align_text_center is
			-- Set button `text' to be centered.
		do
			set_style(default_style + Bs_center)
			invalidate
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the pixmap of the button.
		do
			{EV_PIXMAPABLE_IMP} Precursor (pix)
			set_bitmap (pixmap_imp.bitmap)
			set_default_minimum_size
		end

	remove_pixmap is
			-- Remove the buttons `pixmap'.
		do
			{EV_PIXMAPABLE_IMP} Precursor
			unset_bitmap
			set_default_minimum_size
		end

	set_text (txt: STRING) is
			-- Set the button `text' to `txt'
		do
			{WEL_BITMAP_BUTTON} Precursor (txt)
			set_default_minimum_size
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := ws_visible + ws_child + ws_group + ws_tabstop
		end

	on_bn_clicked is
			-- When the button is pressed
		do
			interface.press_actions.call ([])
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Button re-sized.
		do
			Precursor (size_type, a_width, a_height)
			interface.resize_actions.call ([screen_x, screen_y, a_width, a_height])
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_BUTTON

end -- class EV_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.42  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.41.2.2  2000/03/11 00:19:19  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.41.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.41  2000/03/07 17:41:21  rogers
--| Redefined on_size from WEL_BITMAP_BUTTON so the re-size actions can be called.
--|
--| Revision 1.40  2000/03/03 00:55:56  brendel
--| Changed `text' to `safe_text'.
--|
--| Revision 1.39  2000/02/23 20:23:41  rogers
--| Added wel parenting compiler hack. Removed old command association.
--|
--| Revision 1.38  2000/02/19 05:58:51  oconnor
--| removed old command stuff
--|
--| Revision 1.37  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.36  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.10.12  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.35.10.11  2000/01/27 19:30:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.10.10  2000/01/19 23:54:49  rogers
--| renamed interface inherited from EV_FONTABLE_IMP as ev_fontable_interface, and selected interface from EV_BUTTON_I.
--|
--| Revision 1.35.10.9  2000/01/19 21:46:09  king
--| Tidied up comments, removed untabbed spacing
--|
--| Revision 1.35.10.8  2000/01/18 23:03:32  rogers
--| Redefined text from WEL_BITMAP_BUTTON to wel_text, and re-implemented text.
--|
--| Revision 1.35.10.7  2000/01/14 18:09:46  oconnor
--| added comment
--|
--| Revision 1.35.10.6  2000/01/10 19:21:44  king
--| Changed set_*_alignment to align_text_*.
--|
--| Revision 1.35.10.5  1999/12/30 18:42:13  king
--| Commented out pixmap-size related functions.
--|
--| Revision 1.35.10.4  1999/12/22 18:56:41  rogers
--| pixmap_size_ok has been removed, maximium_pixmap_width and maximum_pixmap_height have been implemented. unset_pixmap has been renamed to remove_pixmap.
--|
--| Revision 1.35.10.3  1999/12/22 17:51:56  rogers
--| Removed the old command call when a button is clicked.
--|
--| Revision 1.35.10.2  1999/12/17 00:43:04  rogers
--| Altered to fit in with the review branch. Some redefinitions required, make now takes an interface.
--|
--| Revision 1.35.10.1  1999/11/24 17:30:31  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.35.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
