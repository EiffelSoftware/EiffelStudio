indexing
	description:
		" Text field inside a combo-box-ex when it is%
		% editable. It receive all the events, it forward%
		% them."
	note: "Created by pointer from the system."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_COMBO_FIELD_IMP

inherit
	WEL_SINGLE_LINE_EDIT
		redefine
			window_process_message,
			parent,
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
			on_set_cursor
		end

create
	make_from_combo

feature {NONE} -- Initialization

	make_from_combo (combo: EV_COMBO_BOX_IMP) is
			-- Create the text-field from `combo'.
		do
			parent := combo
			make_by_pointer (combo.edit_item)
			if item /= default_pointer then
				exists := True
				register_window (Current)
				set_default_window_procedure
			end
		end

feature -- Access

	parent: EV_COMBO_BOX_IMP
			-- Parent of the text field.

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_down (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_down (keys, x_pos, y_pos)
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_down (keys, x_pos, y_pos)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_up (keys, x_pos, y_pos)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_up (keys, x_pos, y_pos)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_up (keys, x_pos, y_pos)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_double_click (keys, x_pos, y_pos)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_double_click (keys, x_pos, y_pos)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_double_click (keys, x_pos, y_pos)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_mouse_move (keys, x_pos, y_pos)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_key_down (virtual_key, key_data)
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_key_up (virtual_key, key_data)
		end

	on_set_focus is
			-- Wm_setfocus message
		do
			parent.on_set_focus
		end

	on_kill_focus is
			-- Wm_killfocus message
		do
			parent.on_kill_focus
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			parent.on_set_cursor (hit_code)
		end

feature {WEL_DISPATCHER} -- Message dispatcher

	window_process_message (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			if msg = Wm_mousemove then
				on_mouse_move (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			elseif msg = Wm_size then
				on_size (wparam,
					cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_move then
				on_move (cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_lbuttondown then
				on_left_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = wm_lbuttonup then
				on_left_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_lbuttondblclk then
				on_left_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_mbuttondown then
				on_middle_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_mbuttonup then
				on_middle_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_mbuttondblclk then
				on_middle_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_rbuttondown then
				on_right_button_down (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_rbuttonup then
				on_right_button_up (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_rbuttondblclk then
				on_right_button_double_click (wparam,
					c_mouse_message_x (lparam),
					c_mouse_message_y (lparam))
			elseif msg = Wm_timer then
				on_timer (wparam)
			elseif msg = Wm_setfocus then
				on_set_focus
			elseif msg = Wm_killfocus then
				on_kill_focus
			elseif msg = Wm_keydown then
				on_key_down (wparam, lparam)
			elseif msg = Wm_keyup then
				on_key_up (wparam, lparam)
			elseif msg = Wm_showwindow then
				on_wm_show_window (wparam, lparam)
			elseif msg = Wm_notify then
				on_wm_notify (wparam, lparam)
			elseif msg = Wm_destroy then
				on_wm_destroy
			else
				default_process_message (msg, wparam, lparam)
			end
		end

end -- class EV_INTERNAL_COMBO_FIELD_IMP

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
