indexing
	description: "Eiffel Vision radio button. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end
		
	EV_BUTTON_IMP
		undefine
			default_style,
			on_key_down,
			on_bn_clicked,
			process_message
		redefine
			interface,
			initialize,
			update_current_push_button,
			redraw_current_push_button
		select
			wel_make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

	WEL_RADIO_BUTTON
		rename
			make as wel_radio_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			item as wel_item,
			enabled as is_sensitive,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			checked as is_selected,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			has_capture as wel_has_capture
		undefine
			make_by_id,
			remove_command,
			set_width,
			set_height,
			on_bn_clicked,
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
			on_key_down,
			on_char,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_size,
			process_notification,
			wel_set_text,
			on_show,
			on_hide,
			show,
			hide,
			x_position,
			y_position,
			wel_foreground_color,
			wel_background_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_key_down,
			default_style
		end
		
create
	make

feature {NONE} -- Initalization

	initialize is
			-- Initialize `Current'.
		do
			Precursor
			set_checked
		end			

feature -- Status setting
	
	enable_select is
			-- Set `Current' as selected.
			--| On WEL, this happens automatically in a WEL_CONTROL, but we
			--| want it to work over multiple controls (see: EV_CONTAINER).
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					radio_group.item.set_unchecked
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			set_checked
			select_actions.call ([])
		end

feature {NONE} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			Precursor {WEL_RADIO_BUTTON} (virtual_key, key_data)
			process_tab_and_arrows_keys (virtual_key)
		end

	on_bn_clicked is
			-- Called when `Current' is pressed.
		do
			enable_select
		end

	default_style: INTEGER is
			-- Default style used to create the control.
		once
			Result := Ws_visible + Ws_child + Ws_tabstop + Bs_radiobutton
		end

feature {NONE} -- Implementation, focus event

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the current push button and
			-- remove any bold border to the other buttons.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.37  2001/06/29 21:54:41  pichery
--| - Changed the behavior of the `default_push_button', we now use
--|   `current_push_button': the currently focused push button.
--| - The redrawing of the button with bold border is now done in vision2
--|   rather than by Windows itself.
--|
--| Revision 1.36  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.8.13  2001/05/14 23:47:53  rogers
--| Fixed bug in on_bn_clicked. The select_actions were being called twice
--| as the call to Precursor called them as well as the call to
--| `enable_select'. We now no longer call the precursor, and this fixes this.
--|
--| Revision 1.17.8.12  2001/01/26 23:21:41  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.17.8.11  2001/01/09 19:13:40  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.17.8.10  2000/11/14 18:25:58  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.17.8.9  2000/11/06 17:57:08  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.17.8.8  2000/10/11 00:01:49  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.17.8.7  2000/10/06 18:46:26  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.17.8.6  2000/09/13 22:09:21  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.17.8.5  2000/08/08 02:50:03  manus
--| Updated inheritance with new WEL messages handling and with the fact that
--| buttons are now colorizable.
--|
--| Revision 1.17.8.4  2000/08/01 17:00:56  rogers
--| Enable_select now calls the select actions.
--|
--| Revision 1.17.8.3  2000/07/12 16:09:21  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.17.8.2  2000/05/09 20:48:28  king
--| Implemented to fit in with new selectable abstract classes
--|
--| Revision 1.17.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.32  2000/05/02 22:07:31  rogers
--| Redefined on_default_style to fix the bug due to conflicts with
--| check buttons. Comments. Formatting.
--|
--| Revision 1.31  2000/05/01 17:04:44  manus
--| Use of `wel_parent' directly without the hack of renaming into
--| `wel_window_parent'.
--|
--| Revision 1.30  2000/04/29 03:35:58  pichery
--| Cosmetics
--|
--| Revision 1.29  2000/04/25 00:34:07  rogers
--| Parent from WEL_RADIO_BUTTON is now renamed as wel_parent.
--|
--| Revision 1.28  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.27  2000/03/22 00:53:15  brendel
--| Added FIXME.
--|
--| Revision 1.26  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.25.2.2  2000/03/11 00:19:21  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.25.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.25  2000/03/07 17:40:06  rogers
--| Undefined on_size from WEL_RADIO_BUTTON as this is now inherited from
--| EV_BUTTON_IMP.
--|
--| Revision 1.24  2000/03/04 04:19:22  pichery
--| Modified the inheritance since WEL_BITMAP_BUTTON now redefine make
--| and make_by_id
--|
--| Revision 1.23  2000/02/29 00:40:44  brendel
--| Added redefinition of `enable_select', see comments on feature.
--| Added redefinition of `on_bn_clicked', to call `enable_select' first.
--|
--| Revision 1.22  2000/02/25 20:26:07  brendel
--| Now redefined initialize instead of make.
--|
--| Revision 1.21  2000/02/25 02:17:44  brendel
--| Added inheritance of EV_RADIO_PEER_IMP.
--| Redefined make to set default `is_selected' `True'.
--|
--| Revision 1.20  2000/02/24 20:40:22  brendel
--| Revised.
--| Changed --| to --! for copyright notice.
--|
--| Revision 1.19  2000/02/17 02:18:47  oconnor
--| released
--|
--| Revision 1.18  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.10.3  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.10.2  2000/01/10 19:58:50  rogers
--| Altered to comply with the major Vision2 changes. See diff for
--| redefinitions. Added set_peer and remove_from_group which should not be
--| called as they are not yet implemented. I am not sure if this is possible
--| on Windows. This needs to be fixed soon.
--|
--| Revision 1.17.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
