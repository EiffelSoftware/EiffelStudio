indexing
	description: "Eiffel Vision accelerator. Implementation interface."
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

	parented: BOOLEAN
			-- Does `Current' have a parent?

	enable_parented is
			-- Assign True to `parented'.
		do
			parented := True
		end

	disable_parented is
			-- Assign False to `parented'.
		do
			parented := False
		end


	key: EV_KEY is
			-- Key that has to pressed to trigger actions.
		deferred
		end

	shift_required: BOOLEAN is
			-- Must the shift key be pressed?
		deferred
		end

	alt_required: BOOLEAN is
			-- Must the alt key be pressed?
		deferred
		end

	control_required: BOOLEAN is
			-- Must the control key be pressed?
		deferred
		end

feature -- Events

	actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `key' is pressed.
		do
			if actions_internal = Void then
				create actions_internal
			end
			Result := actions_internal
		end

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key_code' as new key that has to be pressed.
		deferred
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		deferred
		end

	disable_shift_required is
			-- "Shift" is not part of the key combination.
		deferred
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		deferred
		end

	disable_alt_required is
			-- "Alt" is not part of the key combination.
		deferred
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		deferred
		end

	disable_control_required is
			-- "Control" is not part of the key combination.
		deferred
		end

feature {EV_ACCELERATOR_I} -- Implementation

	actions_internal: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed on accelerator activation.

	interface: EV_ACCELERATOR

end -- class EV_ACCELERATOR_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.7  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.4  2000/09/08 00:18:33  rogers
--| Changed feature names that did not match the interface.
--|
--| Revision 1.4.4.3  2000/08/16 19:47:53  king
--| Moved actions from interface to i_i
--|
--| Revision 1.4.4.2  2000/05/19 21:58:45  rogers
--| Added parented, enable_parented and disable_parented.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:55  oconnor
--| mergred from HEAD
--|
--| Revision 1.4  2000/03/15 21:15:46  brendel
--| Changed key_code to key like in interface.
--|
--| Revision 1.3  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
