--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision accelerator. Objects that call an action sequence %N%
		%when the given key combination is pressed any time in the %N%
		%EiffelVision application."
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

	make_with_key_combination (a_key_code: INTEGER;
		a_shift_down, a_alt_down, a_control_down: BOOLEAN) is
			-- Create with `a_key_code'.
		do
			default_create
			set_key_code (a_key_code)
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
			-- Actions performed when key combination is pressed.

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

feature -- Access

	key_code: INTEGER is
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE
		do
			Result := implementation.key_code
		ensure
			bridge_ok: Result = implementation.key_code
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

	set_key_code (a_key_code: INTEGER) is
			-- Set `a_key_code' as new key that has to be pressed.
		do
			implementation.set_key_code (a_key_code)
		ensure
			assigned: key_code = a_key_code
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
			Result := key_code = other.key_code and then
				alt_key = other.alt_key and then
				shift_key = other.shift_key and then
				control_key = other.control_key
		end

	out: STRING is
			-- String representation of key combination.
		do
			Result := "<"
			if control_key then
				Result.append ("Ctrl-")
			end
			if alt_key then
				Result.append ("Alt-")
			end
			if shift_key then
				Result.append ("Shift-")
			end
			--| FIXME key-code to char.
			Result.append (key_code.out + ">")
		end

feature -- Obsolete

	id: INTEGER is
			-- Integer representation of key combination.
		obsolete
			"Useless?"
		do
			Result := key_code
			if control_key then
				Result := Result + 2048
			end
			if alt_key then
				Result := Result + 1024
			end
			if shift_key then
				Result := Result + 512
			end
		end

	keycode: INTEGER is
		obsolete
			"Use: key_code"
		do
			Result := key_code
		end

invariant
	actions_not_void: actions /= Void

end -- class EV_ACCELERATOR

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
