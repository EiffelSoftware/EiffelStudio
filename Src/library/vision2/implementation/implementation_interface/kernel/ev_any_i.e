indexing
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
	status: "See notice at end of class."
	keywords: "FIXME"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY_I

feature {EV_ANY_I} -- Initialization

	frozen base_make (an_interface: like interface) is
			-- Assign `an_interface' to `interface'
			--| Must be called from `make'.
			--| See notes on initialization in ev_any.e
		require
			an_interface_not_void: an_interface /= Void
			not_already_called: base_make_called = False
		do
			base_make_called := True
			interface := an_interface
		ensure
			interface_assigned: interface = an_interface
			called_flag_set: base_make_called = True
		end

feature {EV_ANY} -- Initialization

	make (an_interface: EV_ANY) is
			-- Create underlying native toolkit objects.
			-- Every descendant should exactly one a creation procedure `make'.
			-- Must call `base_make'.
		require
			an_interface_not_void: an_interface /= Void
		deferred
		ensure
			interface_assigned: interface = an_interface
			base_make_called: base_make_called
		end

	initialize is
			-- Do post creation initialization.
			-- While make must be redefined in each descendant,
			-- initialize may remain more general.
			--| Called from EV_ANY.default_create
		deferred
		ensure
			is_initialized: is_initialized
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	frozen safe_destroy is
			-- Protection against multiple calls of destroy whilst in the process of destruction
			-- Called directly from `interface'.destroy
		do
			if not is_in_destroy then
				is_in_destroy := True
				destroy
			end
		end

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		deferred
		ensure
			is_in_destroy_set: is_in_destroy
			is_destroyed_set: is_destroyed
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_ANY
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'
			-- (see bridge pattern notes in ev_any.e)
			--| Every descendant of EV_ANY_I must be coupled to an
			--| `interface' object (EV_ANY descendant). There is a
			--| 1-1 mapping between implementation and interface
			--| objects.

	base_make_called: BOOLEAN
			-- Was `base_make' called?

	is_initialized: BOOLEAN
			-- Has `Current' been initialized properly?

	is_destroyed: BOOLEAN
			-- Is `Current' no longer usable?

	is_in_destroy: BOOLEAN
			-- Is `Current' in the process of being destroyed?
			-- Needed for call protection when in the process of `destroy' to prevent multiple calls as a result of destruction.

	set_interface (an_interface: like interface) is
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

	enable_initialized is
			-- Set the implementation to be initialized
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: False
					-- replace_implementation calls turns assertions off.
			end
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

	disable_initialized is
			-- Set the implementation to be un-initialized
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: False
					-- replace_implementation calls turns assertions off.
			end
			is_initialized := False
		ensure
			not_is_initialized: not is_initialized
		end

feature {NONE} -- Contract support

	is_usable: BOOLEAN is
			-- Is `Current' usable?
		do
			Result := is_initialized and not is_destroyed
		end

invariant
	interface_coupled: is_usable implies
		interface /= Void and then interface.implementation = Current
	base_make_called: base_make_called

end -- class EV_ANY_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

