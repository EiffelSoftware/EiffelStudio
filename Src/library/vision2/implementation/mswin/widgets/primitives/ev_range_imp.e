indexing
	description: "Eiffel Vision range. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface
		end

	WEL_TRACK_BAR
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			position as value,
			set_position as wel_set_value,
			line as step,
			page as leap,
			set_line as wel_set_step,
			set_page as wel_set_leap,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			set_range as wel_set_range,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
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
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control.
		do
			Result := Ws_visible + Ws_child + Ws_group
				+ Ws_tabstop + Tbs_tooltips
		end

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
			check
				Never_called: False
			end
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

feature {EV_ANY_I, EV_INTERNAL_SILLY_WINDOW_IMP} -- Interface

	interface: EV_RANGE

end -- class EV_RANGE_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.10  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.9  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.8.13  2001/01/26 23:21:08  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.3.8.12  2001/01/09 19:13:11  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.3.8.11  2000/11/14 18:24:50  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.3.8.10  2000/11/06 17:56:52  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.3.8.9  2000/10/11 00:01:49  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.3.8.8  2000/08/22 00:26:31  rogers
--| Interface is now also exported to EV_INTERNAL_SILLY_WINDOW_IMP. Removed
--| fixme regarding recieving of the scroll message.
--|
--| Revision 1.3.8.7  2000/08/11 18:46:12  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.3.8.6  2000/08/08 02:42:14  manus
--| Updated inheritance with new WEL messages handling
--|
--| Revision 1.3.8.5  2000/07/12 16:08:56  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.3.8.4  2000/06/19 19:09:05  rogers
--| Minor formatting. Improved FIXME comment.
--|
--| Revision 1.3.8.3  2000/06/13 18:35:44  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.3.8.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/03/21 23:39:00  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.6  2000/02/19 07:11:26  oconnor
--| fixed broken comment
--|
--| Revision 1.5  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.4  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.5  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.3.10.4  2000/02/03 17:22:55  brendel
--| Removed leap_* since they are now defined in EV_GAUGE.
--|
--| Revision 1.3.10.3  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  2000/01/06 20:37:19  rogers
--| Now works with the major changes in Vision2. The interface has been added.
--| A lot of renaming has been done from ancestors, to fit in with changes.
--| See the diff.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
