indexing
	description:
		"Eiffel Vision accelerator. Objects that call an action sequence %N%
		%when the given key combination is pressed any time in the %N%
		%window it is set in."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR

inherit
	EV_ANY
		redefine
			out,
			is_equal,
			create_action_sequences,
			implementation
		end

create
	default_create,
	make_with_key_combination

feature {NONE} -- Initialization

	make_with_key_combination (a_key: EV_KEY;
		a_shift_down, a_alt_down, a_control_down: BOOLEAN) is
			-- Create with `a_key'.
		require
			a_key_not_void: a_key /= Void
			a_key_valid_accelerator: a_key.is_valid_accelerator
		do
			default_create
			set_key (a_key)
			if a_shift_down then
				enable_shift_key
			end
			if a_alt_down then
				enable_alt_key
			end
			if a_control_down then
				enable_control_key
			end
		end

feature -- Events

	actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when key combination is pressed on the window
			-- it is set in.

feature -- Access

	key: EV_KEY is
			-- Key that has to pressed to trigger actions.
		do
			Result := implementation.key
		ensure
			bridge_ok: Result = implementation.key
		end

	shift_key: BOOLEAN is
			-- Must the shift key be pressed?
		do
			Result := implementation.shift_key
		ensure
			bridge_ok: Result = implementation.shift_key
		end

	alt_key: BOOLEAN is
			-- Must the alt key be pressed?
		do
			Result := implementation.alt_key
		ensure
			bridge_ok: Result = implementation.alt_key
		end

	control_key: BOOLEAN is
			-- Must the control key be pressed?
		do
			Result := implementation.control_key
		ensure
			bridge_ok: Result = implementation.control_key
		end

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key' as new key that has to be pressed.
		require
			a_key_not_void: a_key /= Void
			a_key_valid_accelerator: a_key.is_valid_accelerator
		do
			implementation.set_key (a_key)
		ensure
			assigned: key.is_equal (a_key)
		end

	enable_shift_key is
			-- "Shift" must be pressed for the key combination.
		do
			implementation.enable_shift_key
		ensure
			enabled: shift_key
		end

	disable_shift_key is
			-- "Shift" is not part of the key combination.
		do
			implementation.disable_shift_key
		ensure
			disabled: not shift_key
		end

	enable_alt_key is
			-- "Alt" must be pressed for the key combination.
		do
			implementation.enable_alt_key
		ensure
			enabled: alt_key
		end

	disable_alt_key is
			-- "Alt" is not part of the key combination.
		do
			implementation.disable_alt_key
		ensure
			disabled: not alt_key
		end

	enable_control_key is
			-- "Control" must be pressed for the key combination.
		do
			implementation.enable_control_key
		ensure
			enabled: control_key
		end

	disable_control_key is
			-- "Control" is not part of the key combination.
		do
			implementation.disable_control_key
		ensure
			disabled: not control_key
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same key combination as `Current'?
		do
			Result := key.is_equal (other.key) and then
				alt_key = other.alt_key and then
				shift_key = other.shift_key and then
				control_key = other.control_key
		end

	out: STRING is
			-- String representation of key combination.
		do
			create Result.make (0)
			if alt_key then
				Result.append ("Alt+")
			end
			if control_key then
				Result.append ("Ctrl+")
			end
			if shift_key then
				Result.append ("Shift+")
			end
			Result.append (key.out)
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	implementation: EV_ACCELERATOR_I
			-- Implementation of accelerator.

feature {NONE} -- Implementation

	create_action_sequences is
			-- Create action sequences for accelerator.
		do
			Precursor
			create actions
		end

	create_implementation is
			-- Create implementation of accelerator.
		do
			create {EV_ACCELERATOR_IMP} implementation.make (Current)
		end

invariant
	actions_not_void: actions /= Void
	key_not_void: key /= Void
	key_valid_accelerator: key.is_valid_accelerator

end -- class EV_ACCELERATOR

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
--| Revision 1.7  2000/03/15 21:14:52  brendel
--| Changed key_code: INTEGER to key: EV_KEY.
--| Improved comments.
--|
--| Revision 1.6  2000/02/29 16:11:43  brendel
--| Removed obsolete declaration. Added FIXME about usage of feature.
--|
--| Revision 1.5  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.3.6.5  2000/01/27 19:30:38  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.4  2000/01/25 22:09:00  brendel
--| Added feature `is_equal'.
--|
--| Revision 1.3.6.3  2000/01/25 03:16:38  brendel
--| Changed export status.
--|
--| Revision 1.3.6.2  2000/01/24 23:15:03  brendel
--| Accelerators are now platform dependent.
--| Features are not yet implemented.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
