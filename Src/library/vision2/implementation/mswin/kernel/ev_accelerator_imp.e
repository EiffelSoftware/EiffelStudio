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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.7  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.6  2001/05/18 20:50:19  pichery
--| Updated for destroy_just_called
--|
--| Revision 1.6.4.5  2000/09/08 00:19:09  rogers
--| Changed feature names to match those of the interface.
--|
--| Revision 1.6.4.4  2000/06/12 19:46:46  rogers
--| Remove FIXME from destroy. Destroy now calls destroy_item instead of dispose.
--|
--| Revision 1.6.4.3  2000/06/12 19:27:06  rogers
--| Implemented destroy with a FIXME, as a temporary measure.
--|
--| Revision 1.6.4.1  2000/05/03 19:09:12  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/03/16 17:11:24  brendel
--| Implemented.
--|
--| Revision 1.5  2000/03/15 21:16:17  brendel
--| Changed key_code to key.
--|
--| Revision 1.4  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.1  2000/01/24 23:15:03  brendel
--| Accelerators are now platform dependent.
--| Features are not yet implemented.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
