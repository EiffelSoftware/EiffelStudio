--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision text field. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			on_key_down,
			interface
		end

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			width as wel_width,
			height as wel_height,
			set_caret_position as internal_set_caret_position,
			caret_position as internal_caret_position,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			x as x_position,
			y as y_position,
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
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size
		redefine
			on_key_down,
			on_en_change,
			default_style,
			enable,
			disable,
			on_char
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty text field.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)

			--| FIXME We need text fields not te resize vertically.
			--| Horizontally still depends on `disable_item_expand'.
			--| Redefine function somehow.
			internal_changes := set_bit (internal_changes, 32, False)
		end

feature {NONE} -- WEL Implementation

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

	default_style: INTEGER is
			-- We specified the Es_autovscroll style otherwise
			-- the system keep on beeping when we press the
			-- return key.
		do
			Result := Ws_child + Ws_visible + Ws_tabstop
					+ Ws_group + Ws_border + Es_left + Es_autohscroll
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed)
			-- 13 is the number of the return key.
		do
			{EV_TEXT_COMPONENT_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
			if virtual_key = Vk_return then
				set_caret_position (1)
				interface.return_actions.call ([])
			end
		end	

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `beep' when the user
			-- tab to another control.
		do
			if not has_focus then
				disable_default_processing
			end
		end

	on_en_change is
			-- The user has taken an action
			-- that may have altered the text.
		do
			interface.change_actions.call ([])
		end

	enable is
			-- Enable mouse and keyboard input.
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (wel_item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (wel_item, False)
			set_background_color (default_colors.Color_read_only)
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {NONE} -- Implementation

	interface: EV_TEXT_FIELD

invariant
	not_vertically_resizable: not vertical_resizable

end -- class EV_TEXT_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
--| Revision 1.40  2000/05/03 20:13:27  brendel
--| Fixed resize_actions.
--|
--| Revision 1.39  2000/05/02 16:13:59  brendel
--| First implementation to disable ugly vertical resizing.
--|
--| Revision 1.38  2000/04/27 23:18:02  pichery
--| Changed the default font for EV_TEXT_COMPONENT
--| and its descendants.
--|
--| Revision 1.37  2000/04/21 01:24:19  pichery
--| Changed the default font for
--| EV_TEXT_FIELD.
--| It's no more the crappy system font.
--|
--| Revision 1.36  2000/04/18 17:13:00  rogers
--| Added wel_window_parent fix.
--|
--| Revision 1.35  2000/03/17 00:01:52  rogers
--| move is now correctly re-named to wel_move.
--|
--| Revision 1.32  2000/02/23 01:49:08  rogers
--| Removed old command association. Change events are now fired when the text of changes.
--|
--| Revision 1.31  2000/02/23 01:32:17  rogers
--| Added the call to the new events when return is pressed.
--|
--| Revision 1.30  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.29  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.28  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.27.10.5  2000/02/01 03:40:54  brendel
--| Removed undefine of set_default_minimum_size.
--|
--| Revision 1.27.10.4  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.27.10.3  2000/01/27 00:37:51  rogers
--| Commented out previous command executions. Need to implement using the new event system.
--|
--| Revision 1.27.10.2  2000/01/04 18:51:37  rogers
--| Fitted in with the development branch. on_key_down, now goes to position one when return is pressed, instead of 0. Redefined interface.
--|
--| Revision 1.27.10.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.27.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
