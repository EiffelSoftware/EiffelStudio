indexing
	description:
		"A keyboard accelerator defines `actions' to be performed when a%
		%`key' is pressed. See `{EV_TITLED_WINDOW}.accelerators'"
	status: "See notice at end of class"
	keywords: "accelerator, keyboard, key, shortcut, hotkey"
	date: "$Date$"
	revision: "$Revision$"

--| FIXME Feature names in this class should be propogated to the _I.

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
		require_shift, require_alt, require_control: BOOLEAN) is
			-- Create with `a_key' and modifiers.
		require
			a_key_not_void: a_key /= Void
			a_key_is_valid_accelerator: a_key.is_valid_accelerator
		do
			default_create
			set_key (a_key)
			if require_shift then
				enable_shift_required
			end
			if require_alt then
				enable_alt_required
			end
			if require_control then
				enable_control_required
			end
		end

feature -- Events

	actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `key' is pressed.

feature -- Access

	key: EV_KEY is
			-- Key that will trigger `actions'.
		do
			Result := implementation.key
		ensure
			bridge_ok: equal (Result, implementation.key)
		end

	shift_required: BOOLEAN is
			-- Must the shift key be pressed to trigger `actions'?
		do
			Result := implementation.shift_key
		ensure
			bridge_ok: Result = implementation.shift_key
		end

	alt_required: BOOLEAN is
			-- Must the alt key be pressed to trigger `actions'?
		do
			Result := implementation.alt_key
		ensure
			bridge_ok: Result = implementation.alt_key
		end

	control_required: BOOLEAN is
			-- Must the control key be pressed to trigger `actions'?
		do
			Result := implementation.control_key
		ensure
			bridge_ok: Result = implementation.control_key
		end

feature -- Status setting

	set_key (a_key: EV_KEY) is
			-- Assign `a_key' to `key'.
		require
			a_key_not_void: a_key /= Void
			a_key_valid_accelerator: a_key.is_valid_accelerator
		do
			implementation.set_key (a_key)
		ensure
			a_key_assigned: key.is_equal (a_key)
		end

	enable_shift_required is
			-- Make `shift_required' True.
		do
			implementation.enable_shift_key
		ensure
			shift_required: shift_required
		end

	disable_shift_required is
			-- Make `shift_required' False.
		do
			implementation.disable_shift_key
		ensure
			not_shift_required: not shift_required
		end

	enable_alt_required is
			-- Make `alt_required' True.
		do
			implementation.enable_alt_key
		ensure
			alt_required: alt_required
		end

	disable_alt_required is
			-- Make `alt_required' False.
		do
			implementation.disable_alt_key
		ensure
			not_alt_required: not alt_required
		end

	enable_control_required is
			-- Make `control_required' True.
		do
			implementation.enable_control_key
		ensure
			control_required: control_required
		end

	disable_control_required is
			-- Make `control_required' False.
		do
			implementation.disable_control_key
		ensure
			not_control_required: not control_required
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same key combination as `Current'?
		do
			Result := key.is_equal (other.key) and then
				alt_required = other.alt_required and then
				shift_required = other.shift_required and then
				control_required = other.control_required
		end

	out: STRING is
			-- String representation of key combination.
		do
			create Result.make (0)
			if alt_required then
				Result.append ("Alt+")
			end
			if control_required then
				Result.append ("Ctrl+")
			end
			if shift_required then
				Result.append ("Shift+")
			end
			Result.append (key.out)
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	implementation: EV_ACCELERATOR_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'
		do
			Precursor
			create actions
		end

	create_implementation is
			-- See `{EV_ANY}.create_implementation'
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
--| Revision 1.12  2000/03/21 20:12:19  brendel
--| Improved postcodition on `key'.
--|
--| Revision 1.11  2000/03/16 17:17:49  brendel
--| disable_control_key -> disable_control_required.
--|
--| Revision 1.10  2000/03/16 01:08:06  oconnor
--| reinserted accidently removed FIXME
--|
--| Revision 1.9  2000/03/15 23:04:46  brendel
--| Fixed compiler errors.
--|
--| Revision 1.8  2000/03/15 22:08:24  oconnor
--| updated comments and modifier feature names
--|
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
