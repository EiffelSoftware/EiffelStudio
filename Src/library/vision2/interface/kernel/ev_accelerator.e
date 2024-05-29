note
	description:
		"A keyboard accelerator defines `actions' to be performed when a%
		%`key' is pressed. See `{EV_TITLED_WINDOW}.accelerators'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "accelerator, keyboard, key, shortcut, hotkey"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR

inherit
	EV_ANY
		redefine
			out,
			is_equal,
			implementation
		end

	DEBUG_OUTPUT
		undefine
			out,
			is_equal,
			default_create,
			copy
		end

create
	default_create,
	make_with_key_combination

feature {NONE} -- Initialization

	make_with_key_combination (a_key: EV_KEY;
		 require_control, require_alt, require_shift: BOOLEAN)
			-- Create with `a_key' and modifiers.
		require
			a_key_not_void: a_key /= Void
		do
			default_create
			set_key (a_key)
			if require_control then
				enable_control_required
			end
			if require_alt then
				enable_alt_required
			end
			if require_shift then
				enable_shift_required
			end
		end

feature -- Events

	actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when key combination is received by the window within which
			-- `Current' is parented.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.actions
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access

	parented: BOOLEAN
			-- Does `Current' have a parent?
			-- `Current' is parented if it has been placed in the
			-- accelerator list of a window.
			-- key combination of `Current' cannot be modified if True.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parented
		end

	key: EV_KEY
			-- Key that will trigger `actions'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.key
		ensure
			bridge_ok: equal (Result, implementation.key)
		end

	shift_required: BOOLEAN
			-- Must the shift key be pressed to trigger `actions'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.shift_required
		ensure
			bridge_ok: Result = implementation.shift_required
		end

	alt_required: BOOLEAN
			-- Must the alt key be pressed to trigger `actions'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.alt_required
		ensure
			bridge_ok: Result = implementation.alt_required
		end

	control_required: BOOLEAN
			-- Must the control key be pressed to trigger `actions'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.control_required
		ensure
			bridge_ok: Result = implementation.control_required
		end

feature -- Status setting

	set_key (a_key: EV_KEY)
			-- Assign `a_key' to `key'.
		require
			not_destroyed: not is_destroyed
			a_key_not_void: a_key /= Void
			not_parented: not parented
		do
			implementation.set_key (a_key)
		ensure
			a_key_assigned: key.is_equal (a_key)
		end

	enable_shift_required
			-- Make `shift_required' True.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.enable_shift_required
		ensure
			shift_required: shift_required
		end

	disable_shift_required
			-- Make `shift_required' False.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.disable_shift_required
		ensure
			not_shift_required: not shift_required
		end

	enable_alt_required
			-- Make `alt_required' True.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.enable_alt_required
		ensure
			alt_required: alt_required
		end

	disable_alt_required
			-- Make `alt_required' False.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.disable_alt_required
		ensure
			not_alt_required: not alt_required
		end

	enable_control_required
			-- Make `control_required' True.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.enable_control_required
		ensure
			control_required: control_required
		end

	disable_control_required
			-- Make `control_required' False.
		require
			not_destroyed: not is_destroyed
			not_parented: not parented
		do
			implementation.disable_control_required
		ensure
			not_control_required: not control_required
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same key combination as `Current'?
		do
			Result := key.is_equal (other.key) and then
				alt_required = other.alt_required and then
				shift_required = other.shift_required and then
				control_required = other.control_required
		end

	text: STRING_32
			-- String representation of key combination.
		local
			a_key: STRING_32
		do
			create Result.make (0)
			if control_required then
				Result.append ("Ctrl+")
			end
			if alt_required then
				Result.append ("Alt+")
			end
			if shift_required then
				Result.append ("Shift+")
			end
			a_key := key.text
				--| We only need to convert the key to upper case if
				--| it is one character long such as 'a'. Other keys
				--| do not need to be converted.
			if a_key.count = 1 then
				a_key := a_key.as_upper
			end
			Result.append (a_key)
		ensure then
			Result_attached: Result /= Void
		end

	out: STRING
			-- <Precursor>
		obsolete
			"Use `text' instead. [2017-05-31]"
		do
			Result := text.as_string_8_conversion
		end

feature {EV_ANY, EV_ANY_I, EV_ACCELERATOR_LIST} -- Implementation

	implementation: EV_ACCELERATOR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'
		do
			create {EV_ACCELERATOR_IMP} implementation.make
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			Result := text
		end

invariant
	key_not_void: key /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_ACCELERATOR









