--| FIXME Not for release
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
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			text as wel_text
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
				w := extra_width + fw.string_width (text)
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

feature -- Event - command association

	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		do
			add_command (Cmd_click, cmd, arg)
		end

feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		do
			remove_command (Cmd_click)
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
