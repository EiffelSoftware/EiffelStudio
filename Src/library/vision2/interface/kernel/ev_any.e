note
	description: "[
		Base class for Eiffel Vision interface.
		
		Eiffel Vision uses the bridge pattern. (See bridge pattern notes below.)
		Descendents of this class are coupled to descendents of EV_ANY_I
		(the base class for Eiffel Vision implementation classes).
		
		EV_ANY's descendants provide a common interface across all
		platforms while EV_ANY_I's descendants provide any necessary
		platform specific implementation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "interface, base, root, any"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY

inherit
	ANY
		redefine
			default_create,
			copy
		end

feature {EV_ANY_HANDLER} -- Initialization

 --|----------------------------------------------------------------
 --| Creation sequence for all Vision2 objects is like this:
 --|
 --| - Default_create is defined once in EV_ANY.
 --| - create_implementation is defined in descendants, default_create calls them
 --| - After it is created, initialize is called on the implementation, this will
 --|   do extra setup work but need not be redefined in every descendant.
 --|   (Probably redefined in EV_WIDGET_IMP but not too many other places)
 --|   Next default_create calls initialize on Current.
 --|
 --| `default_create' must be called during creation to satisfy the invariant.
 --| The normal pattern is that default_create will produce a properly
 --| initialized default object and any special convenience creation features
 --| will call default_create then do their extra work.
 --|
 --| The postcondition of `default_create' checks `is_in_default_state', this
 --| returns True by default but should be redefined by decendants to check for
 --| proper initial results from class queries.
 --|----------------------------------------------------------------

	frozen default_create
			-- Standard creation procedure.
			--| Must be called exactly once during creation.
		do
			create_interface_objects
			create_implementation
			check
				not_already_called: not implementation.get_state_flag ({EV_ANY_I}.interface_default_create_called_flag)
					--| Calling default_create twice is not
					--| allowed. This means that reusing
					--| objects is not allowed unless a
					--| special purpose feature is provided.
			end
			implementation.set_state_flag ({EV_ANY_I}.interface_default_create_called_flag, True)
			implementation.assign_interface (Current)
			initialize
		ensure then
			is_coupled: implementation /= Void
			is_initialized: is_initialized
			default_create_called: default_create_called
			is_in_default_state: is_in_default_state
		end

feature -- Access

	data: detachable ANY
			-- Arbitrary user data may be stored here.

feature -- Element change

	set_data (some_data: like data)
			-- Assign `some_data' to `data'.
		require
			not_destroyed: not is_destroyed
		do
			data := some_data
		ensure
			data_assigned: data = some_data
		end

feature -- Command

	destroy
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			implementation.safe_destroy
		ensure
			is_destroyed: is_destroyed
		end

feature -- Status Report

	is_destroyed: BOOLEAN
			-- Is `Current' no longer usable?
		do
			Result := implementation.is_destroyed
		ensure
			bridge_ok: Result = implementation.is_destroyed
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	 implementation: EV_ANY_I
			-- Responsible for interaction with native graphics
			-- toolkit.
			--| The `Current' object serves only as an interface
			--| it does not do any actual computation or interaction
			--| with the native graphics toolkit. These tasks are
			--| performed by the `implementation' object. Every
			--| descendant of EV_ANY must have an `implementation'
			--| object. There is a 1-1 mapping between implementation
			--| and interface objects.
			--| The `implementation' object will be different
			--| depending on the underlying platform and graphics
			--| toolkit, but descendents of this class provide a
			--| consistent interface to users.
			--| (See bridge pattern description below)

	replace_implementation (new_implementation: like implementation)
			-- Replace `implementation' with `new_implementation'.
			-- The caller has complete responsibility for releasing any
			-- resources held by the old `implementation'.
			--| See `clone' for useage of `c_check_assert'.
		require
			implementation_not_void: implementation /= Void
			new_implementation_not_void: new_implementation /= Void
		local
			temp: BOOLEAN
		do
			temp := {ISE_RUNTIME}.check_assert (False)
			implementation.disable_initialized
			new_implementation.set_interface (Current)
			implementation := new_implementation
			implementation.enable_initialized
			implementation.set_state_flag ({EV_ANY_I}.interface_default_create_called_flag, True)
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, True)
			temp := {ISE_RUNTIME}.check_assert (temp)
		end

feature {EV_ANY} -- Implementation

	create_implementation
			-- Create `implementation'.
			-- Must be defined in each descendant to create the
			-- appropriate `implementation' object.
--		require
--			implementation_not_already_created: implementation = Void
		deferred
		ensure
			implementation_created: attached implementation
		end

	create_interface_objects
			-- Create objects to be used by `Current' in `initialize'
			-- Implemented by descendants to create attached objects
			-- in order to adhere to void-safety due to the implementation bridge pattern.
		deferred
		end

	initialize
			-- Mark `Current' as initialized.
			-- This must be called during the creation procedure
			-- to satisfy the `is_initialized' invariant.
			-- Descendants may redefine initialize to perform
			-- additional setup tasks.
		require
			not_already_initialized: not is_initialized
		do
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, True)
		ensure
			is_initialized: is_initialized
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		obsolete
			"[
				Copy is not permitted for most Vision classes.
				Copy is supported for:
					EV_CHARACTER_FORMAT
					EV_COLOR
					EV_FONT
					EV_PIXMAP
					EV_POINTER_STYLE
					EV_REGION
			]"
		do
			check can_copy_this_vision2_class: False then end
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
			--| Checked by the postcondition of default create.
			--| Should be redefined and precursed in decendants to check new
			--| objects for proper default state initialization.
			--| Redefinitions must be pure queries with no side effects.
			--| eg: do Result := Precursor and ( check_local_state ) end
		do
			check
				should_only_be_called_from_default_create_postcondition: False
					-- (Check is ignored when it is called from postcondition.)
			end
			Result := True
		end

feature {NONE} -- Implementation

	environment_i: EV_ENVIRONMENT_I
			-- Once access to Environment Implementation Object
		once
			create {EV_ENVIRONMENT_IMP} Result.make
		end

feature {EV_ANY} -- Contract support

	action_sequence_call_counter: NATURAL_32
			-- Call counter for `{EV_LITE_ACTION_SEQUENCE}.call', used to determine
			-- if calls have been made as a result of a routine executing.
		do
			Result := environment_i.application_i.action_sequence_call_counter
		end

	is_usable: BOOLEAN
			-- Is `Current' usable?
		do
			Result := default_create_called and then not is_destroyed
		end

	default_create_called: BOOLEAN
			-- Has `default_create' been called on `Current'?
		do
			Result := implementation.get_state_flag ({EV_ANY_I}.interface_default_create_called_flag)
		end

	is_initialized: BOOLEAN
			-- Has `Current' been initialized properly?
		do
			Result := implementation.get_state_flag ({EV_ANY_I}.interface_is_initialized_flag)
		end

invariant
	is_initialized: is_initialized
	default_create_called: default_create_called
	is_coupled:
		default_create_called implies (implementation.interface = Current or (attached {EV_ENVIRONMENT} Current and then attached implementation.interface))
			-- The interface object (descended from this class)
			-- and the implementation object (from EV_ANY_I)
			-- must always be coupled.

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
