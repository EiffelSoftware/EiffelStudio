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

