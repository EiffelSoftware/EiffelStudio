indexing
	description: "EiffelVision accelerator. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I

	EV_WEL_KEY_CONVERSION

	WEL_ACCELERATOR
		rename
			make as wel_make,
			key as wel_key,
			set_key as wel_set_key
		end

	WEL_ACCELERATOR_FLAG_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	EV_ID_IMP

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
			is_initialized := True
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
			is_destroyed := True
		end

end -- class EV_ACCELERATOR_IMP

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

