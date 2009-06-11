note
	description:
		"Base class for Eiffel Vision implementation interface. %N%
		%Eiffel Vision uses the bridge pattern. See notes in ev_any.e) %N%
		%Descendents of this class are coupled to descendants of EV_ANY %N%
		%(the base class for the Eiffel Vision interface) which provide user %N%
		%access. When a class requires different implementation on different %N%
		%platforms descendents of this class have further descendants with %N%
		%an _IMP suffix. %N%
		%eg. If button needs platform specific code then %N%
		%    - EV_BUTTON is the user interface, (descendant of EV_ANY) %N%
		%    - EV_BUTTON_I is the implementation interface, %N%
		%      (descendant of EV_ANY_I) %N%
		%    - EV_BUTTON_IMP is the native implementation. %N%
		%      It is implemented once for each platform, the actual class %N%
		%      included in a system at %N%
		%      compile time is determined by the Ace file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "FIXME"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY_I

feature {EV_ANY, EV_ANY_I} -- Initialization

	frozen assign_interface (an_interface: attached like interface)
			-- Assign `an_interface' to `interface'
			--| See notes on initialization in ev_any.e
		require
			an_interface_not_void: an_interface /= Void
			not_already_called: base_make_called = False
		do
			set_state_flag (base_make_called_flag, True)
			interface := an_interface
		ensure
			interface_assigned: interface = an_interface
			called_flag_set: base_make_called = True
		end

feature {EV_ANY} -- Initialization

	old_make (an_interface: like interface)
			-- Create underlying native toolkit objects.
			-- Every descendant should exactly one a creation procedure `make'.
			-- Must call `base_make'.
		obsolete
			"Should no longer be used"
		require
			an_interface_not_void: an_interface /= Void
		deferred
		ensure
			interface_assigned: interface = an_interface
			base_make_called: base_make_called
		end

	make
			-- Creation routine and initialization for `Current'.
			--| Called from EV_ANY.default_create
		deferred
		ensure
			is_initialized: get_state_flag (is_initialized_flag)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	frozen safe_destroy
			-- Protection against multiple calls of destroy whilst in the process of destruction
			-- Called directly from `interface'.destroy
		do
			if not is_in_destroy then
				set_is_in_destroy (True)
				destroy
			end
		end

	destroy
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		deferred
		ensure
			is_in_destroy_set: is_in_destroy
			is_destroyed_set: is_destroyed
		end

feature -- Status report

	is_destroyed: BOOLEAN
			-- Is `Current' no longer usable?
		do
			Result := get_state_flag (is_destroyed_flag)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	attached_interface: attached like interface
			-- Attached version of `interface'.
		require
			interface_attached: interface /= Void
		do
			Result := interface
		end

	interface: detachable EV_ANY note option: stable attribute end
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'
			-- (see bridge pattern notes in ev_any.e)
			--| Every descendant of EV_ANY_I must be coupled to an
			--| `interface' object (EV_ANY descendant). There is a
			--| 1-1 mapping between implementation and interface
			--| objects.

	state_flags: INTEGER_8
		-- Flags used to hold state of `base_make_called', `is_initialized', `is_destroyed' and `is_in_destroy'.
		-- By storing them in a single INTEGER_8, space is saved.
		-- bit_test (0) returns `base_make_called'.
		-- bit_test (1) returns `is_initialized'.
		-- bit_test (2) returns `is_destroyed'.
		-- bit_test (3) returns `is_in_destroy'.
		-- bit_test (4) returns `interface.default_create_called'
		-- bit_test (5) returns `interface.is_initialized'

	base_make_called_flag: INTEGER_8 = 0
	is_initialized_flag: INTEGER_8 = 1
	is_destroyed_flag: INTEGER_8 = 2
	is_in_destroy_flag: INTEGER_8 = 3
	interface_default_create_called_flag: INTEGER_8 = 4
	interface_is_initialized_flag: INTEGER_8 = 5
		-- Flag positions used for setting state of `Current' and `interface'.

	set_state_flag (a_flag: INTEGER_8; a_value: BOOLEAN)
			-- Set state flag `a_flag' to `a_value'.
		require
			a_flag_valid: a_flag >= base_make_called_flag and then a_flag <= interface_is_initialized_flag
		do
			state_flags := state_flags.set_bit (a_value, a_flag)
		end

	get_state_flag (a_flag: INTEGER_8): BOOLEAN
			-- Get state flag value for `a_flag' flag position.
		require
			a_flag_valid: a_flag >= base_make_called_flag and then a_flag <= interface_is_initialized_flag
		do
			Result := state_flags.bit_test (a_flag)
		end

	base_make_called: BOOLEAN
			-- Was `base_make' called?
		do
			Result := get_state_flag (base_make_called_flag)
		end

	is_initialized: BOOLEAN
			-- Has `Current' been initialized properly?
		do
			Result := get_state_flag (is_initialized_flag)
		end

	is_in_destroy: BOOLEAN
			-- Is `Current' in the process of being destroyed?
			-- Needed for call protection when in the process of `destroy' to prevent multiple calls as a result of destruction.
		do
			Result := get_state_flag (is_in_destroy_flag)
		end

	set_is_initialized (flag: BOOLEAN)
			-- Set `is_initialized' to `flag'.
		do
			set_state_flag (is_initialized_flag, flag)
		ensure
			is_initialized_set: get_state_flag (is_initialized_flag) = flag
		end

	set_is_destroyed (flag: BOOLEAN)
			-- Set `is_destroyed' to `flag'.
		do
			set_state_flag (is_destroyed_flag, flag)
		ensure
			is_destroyed_set: is_destroyed = flag
		end

	set_is_in_destroy (flag: BOOLEAN)
			-- Set `is_in_destroy' to `flag'.
		do
			set_state_flag (is_in_destroy_flag, flag)
		ensure
			is_in_destroy_set: is_in_destroy = flag
		end

	set_interface (an_interface: attached like interface)
			-- Assign `an_interface' to `interface'.
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: False
					-- replace_implementation calls turns assertions off.
			end
			interface := an_interface
		ensure
			interface_assigned: interface = an_interface
		end

	enable_initialized
			-- Set the implementation to be initialized
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: False
					-- replace_implementation calls turns assertions off.
			end
			set_is_initialized (True)
		ensure
			is_initialized: get_state_flag (is_initialized_flag)
		end

	disable_initialized
			-- Set the implementation to be un-initialized
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: False
					-- replace_implementation calls turns assertions off.
			end
			set_is_initialized (False)
		ensure
			not_is_initialized: not get_state_flag (is_initialized_flag)
		end

feature {NONE} -- Contract support

	is_usable: BOOLEAN
			-- Is `Current' usable?
		do
			Result := attached interface and then get_state_flag (is_initialized_flag) and then not is_destroyed
		end

invariant
	interface_coupled: is_usable implies
		interface /= Void and then attached_interface.implementation = Current
	base_make_called: is_usable implies base_make_called

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_ANY_I









