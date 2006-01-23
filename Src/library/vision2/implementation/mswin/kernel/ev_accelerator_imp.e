indexing
	description: "EiffelVision accelerator. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		undefine
			copy, is_equal
		end

	EV_WEL_KEY_CONVERSION
		undefine
			copy, is_equal
		end

	WEL_ACCELERATOR
		rename
			make as wel_make,
			key as wel_key,
			set_key as wel_set_key
		end

	WEL_ACCELERATOR_FLAG_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	EV_ID_IMP
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_id
			wel_make (key_code_to_wel ((create {EV_KEY}).code), id, Fvirtkey)
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	key: EV_KEY is
			-- `Result' is key used by `Current' key combination.
		do
			create Result.make_with_code (key_code_from_wel (wel_key))
		end

	shift_required: BOOLEAN is
			-- Must the shift key be pressed?
		do
			Result := flag_set (flags, Fshift)
		end

	alt_required: BOOLEAN is
			-- Must the alt key be pressed?
		do
			Result := flag_set (flags, Falt)
		end

	control_required: BOOLEAN is
			-- Must the control key be pressed?
		do
			Result := flag_set (flags, Fcontrol)
		end

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key_code' as new key that has to be pressed.
		do
			wel_set_key (key_code_to_wel (a_key.code))
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		do
			set_flags (set_flag (flags, Fshift))
		end

	disable_shift_required is
			-- Remove "Shift" from the key combination of `Current'.
		do
			set_flags (clear_flag (flags, Fshift))
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		do
			set_flags (set_flag (flags, Falt))
		end

	disable_alt_required is
			-- Remove "Alt" from the key combination of `Current'.
		do
			set_flags (clear_flag (flags, Falt))
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		do
			set_flags (set_flag (flags, Fcontrol))
		end

	disable_control_required is
			-- Remove "Control" from the key combination of `Current'.
		do
			set_flags (clear_flag (flags, Fcontrol))
		end

feature {NONE} -- Implementation

	id4: INTEGER is
			-- Integer representation of key combination.
		do
			Result := key.code
			if control_required then
				Result := Result + 2048
			end
			if alt_required then
				Result := Result + 1024
			end
			if shift_required then
				Result := Result + 512
			end
		end

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
			set_is_destroyed (True)
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




end -- class EV_ACCELERATOR_IMP

