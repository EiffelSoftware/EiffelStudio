indexing
	description: "Eiffel Vision accelerator. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	interface: EV_ACCELERATOR;

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




end -- class EV_ACCELERATOR_I

