--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"A common class for the heirs of the WEL_CONTROL_WINDOW."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_CONTAINER_IMP

inherit
	EV_WIDGET_EVENTS_CONSTANTS_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position
		undefine
			window_process_message,
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_draw_item,
			background_brush,
			on_color_control,
 			on_wm_vscroll,
 			on_wm_hscroll,
			show,
			hide,
			on_destroy
		redefine
			default_style,
			default_ex_style
		end

feature {NONE} -- Initialization

	make is
			-- Create the box with the default options.
		do
			wel_make (default_parent, "")
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

feature {NONE} -- Implementation

	top_level_window_imp: WEL_WINDOW
			-- Top level window that contains the current widget.

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_clipchildren
					+ Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

feature {NONE} -- Deferred features

	default_parent: WEL_FRAME_WINDOW is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
