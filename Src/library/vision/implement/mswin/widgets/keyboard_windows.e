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
			set_shift_pressed (key_state (Vk_shift))
			set_lock_pressed (key_state (Vk_capital))
			set_control_pressed (key_state (Vk_control))
			modifiers.put (key_state (Vk_menu), 1)
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
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
