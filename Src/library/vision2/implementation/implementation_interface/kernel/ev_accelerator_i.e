--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision accelerator. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACCELERATOR_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	key_code: INTEGER is
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE
		deferred
		end

	shift_key: BOOLEAN is
			-- Must the shift key be pressed?
		deferred
		end

	alt_key: BOOLEAN is
			-- Must the alt key be pressed?
		deferred
		end

	control_key: BOOLEAN is
			-- Must the control key be pressed?
		deferred
		end

feature -- Element change

	set_key_code (a_key_code: INTEGER) is
			-- Set `a_key_code' as new key that has to be pressed.
		deferred
		end

	enable_shift_key is
			-- "Shift" must be pressed for the key combination.
		deferred
		end

	disable_shift_key is
			-- "Shift" is not part of the key combination.
		deferred
		end

	enable_alt_key is
			-- "Alt" must be pressed for the key combination.
		deferred
		end

	disable_alt_key is
			-- "Alt" is not part of the key combination.
		deferred
		end

	enable_control_key is
			-- "Control" must be pressed for the key combination.
		deferred
		end

	disable_control_key is
			-- "Control" is not part of the key combination.
		deferred
		end

feature {EV_ACCELERATOR_I} -- Implementation

	interface: EV_ACCELERATOR

end -- class EV_ACCELERATOR_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.3  2000/02/04 04:15:55  oconnor
--| release
--|
--| Revision 1.1.2.2  2000/01/27 19:29:53  oconnor
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
