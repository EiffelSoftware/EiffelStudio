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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

