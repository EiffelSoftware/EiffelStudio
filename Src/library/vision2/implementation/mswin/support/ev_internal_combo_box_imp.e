indexing
	description:
		" Text field inside a combo-box-ex when it is%
		% editable. All events are forewarded to the combo box.%
		%Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_COMBO_BOX_IMP

inherit
	WEL_COMBO_BOX
		redefine
			parent,
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
			on_set_cursor,
			on_char,
			on_erase_background
		end

create
	make_with_combo

feature {NONE} -- Initialization

	make_with_combo (combo: EV_COMBO_BOX_IMP) is
			-- Create the text-field from `combo'.
		do
			parent := combo
			make_by_pointer (combo.combo_item)
			if item /= default_pointer then
				register_current_window
				set_default_window_procedure
			end
		end

feature -- Access

	parent: EV_COMBO_BOX_IMP
			-- Parent of `Current'.

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

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `bip' when the user
			-- tab to another control.
		do
			if not has_focus then
				disable_default_processing
			end
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_key_up (virtual_key, key_data)
		end

	on_set_focus is
			-- Wm_setfocus message.
		do
			parent.on_set_focus
		end

	on_kill_focus is
			-- Wm_killfocus message.
		do
			parent.on_kill_focus
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			parent.on_set_cursor (hit_code)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (1)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- No use
		do
			Result := 0
		end

end -- class EV_INTERNAL_COMBO_FIELD_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.6  2000/08/11 19:10:17  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.2.8.5  2000/08/08 01:37:20  manus
--| No need for defining a custom made messges handling, we simply need to use
--| the new one from WEL.
--|
--| Revision 1.2.8.4  2000/06/12 22:04:43  rogers
--| Removed FIXME NOT_REVIEEWED. Comments, formatting.
--|
--| Revision 1.2.8.3  2000/05/09 00:49:41  manus
--| Update with recent WEL changes:
--| - replace `register_window (Current)' by `register_current_window'
--| - replace `windows.item (p)' by `window_of_item (p)'
--|
--| Revision 1.2.8.2  2000/05/07 03:53:09  manus
--| No need to set `exists' explicitely since it is not an attribute anymore and
--| we are using `exists' of WEL_ANY that computes this value automatically
--| without user intervention.
--|
--| Revision 1.2.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.4  2000/03/07 02:39:12  oconnor
--| released
--|
--| Revision 1.3  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.3  2000/01/29 02:17:44  rogers
--| Changed reference to make_with_pointer to make_by_pointer.
--|
--| Revision 1.2.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
