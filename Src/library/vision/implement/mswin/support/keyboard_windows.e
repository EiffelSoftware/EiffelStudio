indexing
	description: "This class represents a keyboard for EiffelVision %
		%implemented for WINDOWS"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD_WINDOWS

inherit
	KEYBOARD

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_MK_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make_from_key_state,
	make_from_mouse_state

feature -- Initialization

	make_from_key_state is
			-- Creates current state of keyboard when
			-- a keyboard button is pressed.
		do
			make (1)
			set_shift_pressed (key_down (Vk_shift))
			set_lock_pressed (key_locked (Vk_capital))
			set_control_pressed (key_down (Vk_control))
			modifiers.put (key_down (Vk_menu), 1)
		end

	make_from_mouse_state (flags: INTEGER) is
			-- Creates current state of keyboard when
			-- mouse button is pressed.
		do
			make (1)
			set_shift_pressed (flag_set (flags, Mk_shift))
			set_control_pressed (flag_set (flags, Mk_control))
		end

end -- class KEYBOARD_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

