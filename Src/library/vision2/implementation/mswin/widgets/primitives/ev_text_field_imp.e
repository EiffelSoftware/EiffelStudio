indexing
	description: 
		"EiffelVision text field. Mswindows implementation."
	status: "See notice at end of class"
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
			on_char,
			interface
		end

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
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
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_up,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			select_all,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_key_down,
			on_en_change,
			default_style,
			enable,
			disable,
			on_char
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with inteface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
		end

feature -- {EV_ANY_I} -- Status report

	text: STRING is
			-- Text of `Current'
		do
			Result := wel_text
			if Result.count = 0 then
				Result := Void
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- We specify the Es_autovscroll style otherwise
			-- the system beeps when we press the return key.
		do
			Result := Ws_child + Ws_visible + Ws_tabstop
					+ Ws_group + Ws_border + Es_left + Es_autohscroll
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed.
			-- 13 is the number of the return key.
		local
			spin_button: EV_SPIN_BUTTON_IMP
		do
			process_tab_key (virtual_key)
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return and is_editable then
				set_caret_position (1)
				interface.return_actions.call ([])
			end
				--| EV_SPIN_BUTTON_IMP is composed of `Current'.
				--| Therefore if `Current' is parented in an EV_SPIN_BUTTON_IMP,
				--| we must propagate the key press event.
			spin_button ?= wel_parent
			if spin_button /= Void then
				spin_button.on_key_down (virtual_key, key_data)
			end
		end	

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message.
			-- Avoid an unconvenient `beep' when the user
			-- tab to another control.
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (character_code, key_data)
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
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
			cwin_enable_window (wel_item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
			cwin_enable_window (wel_item, False)
			set_background_color (default_colors.Color_read_only)
		end

feature {EV_SPIN_BUTTON_IMP} -- Feature that should be directly
	-- implemented by externals

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

end -- class EV_TEXT_FIELD_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable  components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.44  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.27.8.27  2001/05/21 15:25:42  rogers
--| On_key_down now propagates the message to the spin button if `Current'
--| is part of a spin button.
--|
--| Revision 1.27.8.26  2001/02/02 00:50:50  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.27.8.25  2001/01/26 23:20:03  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.27.8.24  2001/01/09 19:11:15  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.27.8.23  2000/12/06 01:16:42  rogers
--| If `Current' is not editable then pressing return will no longer
--| reset the caret_position or call the return actions. The movement of the
--| caret_position would cause post conditions to fail.
--|
--| Revision 1.27.8.22  2000/11/14 18:21:04  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.27.8.21  2000/11/06 19:37:11  king
--| Accounted for default to stock name change
--|
--| Revision 1.27.8.20  2000/11/06 17:55:39  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.27.8.19  2000/10/27 22:17:43  rogers
--| Renamed text as wel_text and implemented text to allow Void texts.
--|
--| Revision 1.27.8.18  2000/10/17 23:34:10  rogers
--| on_char now calls Precursor which fixes the key_press_string_actions.
--|
--| Revision 1.27.8.17  2000/10/11 00:01:49  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.27.8.16  2000/10/07 02:18:35  manus
--| They can resize vertically, otherwise it has a an ugly drawing behavior.
--|
--| Revision 1.27.8.15  2000/10/06 18:39:57  rogers
--| Formatting to 80 columns. Replaced !! with create.
--|
--| Revision 1.27.8.14  2000/09/26 03:57:22  manus
--| No more vertical resizing as it used to be.
--|
--| Revision 1.27.8.13  2000/09/13 22:09:21  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.27.8.12  2000/09/08 19:26:36  manus
--| Added export clause to `EV_SPIN_BUTTON_IMP' since it is using some of the
--| internals of EV_TEXT_FIELD_IMP.
--|
--| Revision 1.27.8.11  2000/09/07 17:09:25  rogers
--| Undefined select_all from WEL_SINGLE_LINE_EDIT.
--|
--| Revision 1.27.8.10  2000/08/11 18:30:12  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.27.8.9  2000/08/08 02:51:57  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Removed hack with `wel_window_parent'.
--| TEXT_FIELD are now vertically resizable.
--|
--| Revision 1.27.8.8  2000/07/24 23:22:35  rogers
--| Now inherits EV_TEXT_FIELD_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.27.8.7  2000/07/13 22:18:18  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.27.8.6  2000/07/12 16:07:50  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.27.8.5  2000/06/13 18:34:53  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.27.8.4  2000/05/04 17:40:30  brendel
--| Added redefinition of initialize_sizeable which sets vertically resizable
--| to False.
--|
--| Revision 1.27.8.3  2000/05/03 22:35:05  brendel
--| Fixed resize_actions.
--|
--| Revision 1.27.8.2  2000/05/03 22:01:35  rogers
--| Redefined initialize, Fixed not_vertically_resizeable assertion.
--|
--| Revision 1.27.8.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
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
--| Removed old command association. Change events are now fired when the text
--| of changes.
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
--| Commented out previous command executions. Need to implement using the new
--| event system.
--|
--| Revision 1.27.10.2  2000/01/04 18:51:37  rogers
--| Fitted in with the development branch. on_key_down, now goes to position one
--| when return is pressed, instead of 0. Redefined interface.
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
