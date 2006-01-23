indexing
	description: "This class represents a keyboard for EiffelVision %
		%implemented for WINDOWS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class KEYBOARD_WINDOWS

