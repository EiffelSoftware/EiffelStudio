indexing
	description:
		"A common class for the heirs of the WEL_CONTROL_WINDOW."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_CONTAINER_IMP

inherit

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			resize as wel_resize,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			text as wel_text,
			set_text as wel_set_text,
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
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_draw_item,
			background_brush,
			on_color_control,
 			on_wm_vscroll,
 			on_wm_hscroll,
			on_char,
			show,
			hide,
			on_destroy,
			on_size,
			x_position,
			y_position,
			on_notify,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			default_ex_style,
			class_name
		end

feature {NONE} -- Initialization

	make is
			-- Create `Current' with `default_parent'.
		do
			wel_make (default_parent, "")
		end

feature {NONE} -- Implementation

	top_level_window_imp: WEL_WINDOW
			-- Top level window that contains `Current'.

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used by windows at creation.
		do
			Result := Ws_child + Ws_clipchildren
					+ Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
			-- Extended style used by windows at creation.
		do
			Result := Ws_ex_controlparent
		end

	class_name: STRING is
			-- Window class name to create.
		do
			Result := generator
		end
	
feature {NONE} -- Deferred features

	default_parent: WEL_FRAME_WINDOW is
			-- Parent of `Current' when a parent is required and has not
			-- been specified.
		deferred
		end

feature {NONE} -- Features that should be directly implemented by externals.

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

	get_wm_hscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		do
			Result := cwin_get_wm_hscroll_code (wparam, lparam)
		end

	get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		do
			Result := cwin_get_wm_hscroll_hwnd (wparam, lparam)
		end

	get_wm_hscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		do
			Result := cwin_get_wm_hscroll_pos (wparam, lparam)
		end

	get_wm_vscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		do
			Result := cwin_get_wm_vscroll_code (wparam, lparam)
		end

	get_wm_vscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		do
			Result := cwin_get_wm_vscroll_hwnd (wparam, lparam)
		end

	get_wm_vscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		do
			Result := cwin_get_wm_vscroll_pos (wparam, lparam)
		end

end -- class EV_WEL_CONTROL_CONTAINER_IMP

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
--| Revision 1.24  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.23  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.22  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.8.14  2001/01/26 23:44:38  rogers
--| Undefined on_sys_key_up inherited from WEL.
--|
--| Revision 1.12.8.13  2001/01/09 22:21:47  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.12.8.12  2000/11/27 20:23:04  rogers
--| Undefined on_notify from WEL_CONTROL_WINDOW as we now use the version
--| inherited from EV_CONTAINER_IMP.
--|
--| Revision 1.12.8.11  2000/11/14 23:40:27  rogers
--| Removed premature addition of on_notify undefinition.
--|
--| Revision 1.12.8.10  2000/11/14 21:04:48  rogers
--| Changed all instances of `bang bang' to create.
--|
--| Revision 1.12.8.8  2000/10/10 23:56:30  raphaels
--| Added `on_desactivate' in list of undefined features from WEL_WINDOW.
--|
--| Revision 1.12.8.7  2000/08/11 20:11:39  rogers
--| Removed fixme NOT_REVIEWED. Comments. Fixed copyright clause.
--|
--| Revision 1.12.8.6  2000/08/08 01:46:44  manus
--| No need for the `wel_window_parent' hack due to a bug in the compiler.
--| Added undefine clauses for the `on_middle_button_*' routines that are now
--| defines in WEL.
--| `class_name' now returns `generator' for debugging purposes in `Spy++'.
--|
--| Revision 1.12.8.5  2000/07/12 16:13:49  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.12.8.4  2000/06/13 18:39:31  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.12.8.3  2000/06/13 17:26:52  rogers
--| Removed inheritance from EV_WIDGET_EVENTS_CONSTANTS_IMP as they were
--| used in the old event system and are no longer required by Vision2.
--|
--| Revision 1.12.8.2  2000/05/03 22:35:00  brendel
--| Fixed resize_actions.
--|
--| Revision 1.12.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.20  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.19  2000/03/21 23:39:01  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.18  2000/03/21 02:34:11  brendel
--| Removed on_accelerator_command from undefine clause.
--|
--| Revision 1.17  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.16.2.1  2000/03/09 21:58:05  brendel
--| Renamed x to x_position, y to y_position.
--|
--| Revision 1.16  2000/02/23 02:21:29  brendel
--| Removed `on_menu_command' from inh. clause.
--|
--| Revision 1.15  2000/02/22 18:21:01  pichery
--| added 4 times the same small hack with `wel_parent' in order to
--| avoid a Segmentation Violation with EiffelBench 4.6.008
--|
--| Revision 1.14  2000/02/19 06:19:24  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.10.3  2000/01/27 19:30:17  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.10.2  1999/12/17 01:04:18  rogers
--| Altered to fit in with the review branch. renaming required.
--|
--| Revision 1.12.10.1  1999/11/24 17:30:23  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
