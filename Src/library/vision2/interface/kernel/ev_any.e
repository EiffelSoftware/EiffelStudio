indexing
	description:
		"Base class for Eiffel Vision interface.%N%
		%Eiffel Vision uses the bridge pattern.%N%
		%(See bridge pattern notes below.)%N%
		%Descendents of this class are coupled to descendents of EV_ANY_I%N%
		%(the base class for Eiffel Vision implementation classes).%N%
		%EV_ANY's descendants provide a common interface across all%N%
		%platforms while EV_ANY_I's descendants provide any necessary%N%
		%platform specific implementation."
	status: "See notice at end of class"
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
	
feature {EV_ANY} -- Initialization

--|-----------------------------------------------------------------------------
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
--|-----------------------------------------------------------------------------

	frozen default_create is
			-- Standard creation procedure.
			--| Must be called exactly once during creation.
		do
			check
				not_already_called: not default_create_called
					--| Calling default_create twice is not
					--| allowed. This means that reusing
					--| objects is not allowed unless a
					--| special purpose feature is provided.
			end
			check
				application_exists: application_exists
			end
			default_create_called := True
			create_implementation
			implementation.initialize
			initialize
		ensure then
			is_coupled: implementation /= Void
			is_initialized: is_initialized
			default_create_called_set: default_create_called
			is_in_default_state: is_in_default_state
		end
		
feature -- Command

	destroy is
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			implementation.destroy
		ensure
			is_destroyed: is_destroyed
		end

feature -- Status Report

	is_destroyed: BOOLEAN is
			-- Is `Current' no longer usable?
		do
			Result := implementation.is_destroyed
		ensure
			bridge_ok: Result = implementation.is_destroyed
		end

feature -- Status Report

	default_create_called: BOOLEAN
			-- Has `default_create' been called?

feature {EV_ANY, EV_ANY_I} -- Implementation

	 implementation: EV_ANY_I
			-- Responsible for interaction with the underlying native graphics
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

	replace_implementation (new_implementation: like implementation) is
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
			temp := c_check_assert (False)
			implementation.disable_initialized
			new_implementation.set_interface(Current)
			implementation := new_implementation
			implementation.enable_initialized
			temp := c_check_assert (temp)
		end

feature {EV_ANY} -- Implementation

	create_implementation is 
			-- Create `implementation'.
			-- Must be defined in each descendant to create the
			-- appropriate `implementation' object.
		require
			implementation_not_already_created: implementation = Void
		deferred
		ensure
			implementation_created: implementation /= Void
		end

	initialize is
			-- Mark `Current' as initialized.
			-- This must be called during the creation procedure
			-- to satisfy the `is_initialized' invariant.
			-- Descendants may redefine initialize to perform
			-- additional setup tasks.
		require
			not_already_initialized: not is_initialized
		do
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

	is_initialized: BOOLEAN
			-- Has `Current' been initialized properly?
			
feature --

	copy (other: like Current) is
			-- 
		do
			check
				cannot_copy_this_vision2_class: False
			end
			-- Copy is not permitted for most Vision2 classes.
			-- The following Vision2 classes may be copied :-
				-- EV_FONT
				-- EV_COLOR
				-- EV_CURSOR
				-- EV_PIXMAP
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
			--| Checked by the postcondition of default create.
			--| Should be redefined and precursed in decendants to check new
			--| objects for propper default state initialization.
			--| Redefinitions must be pure queries with no side effects.
			--| eg: do Result := Precursor and ( check_local_state ) end
		do
			check
				should_only_be_called_from_default_create_postcondition: False
					-- (Check is ignored when it is called from postcondition.)
			end
			Result := True
		end

feature {EV_ANY} -- Contract support

	is_usable: BOOLEAN is
			-- Is `Current' usable?
		do
			Result := is_initialized and not is_destroyed
		end

	application_exists: BOOLEAN is
			-- Does the application exist? This is used to stop
			-- manipulation of widgets before an application is created.
		do
			Result := (create {EV_ENVIRONMENT}).application /= Void
		end

invariant
	is_initialized: is_initialized
	is_coupled:
		implementation /= Void and then implementation.interface = Current
			-- The interface object (descended from this class)
			-- and the implementation object (from EV_ANY_I)
			-- must always be coupled.
			--| (See bridge pattern notes below.)
	default_create_called: default_create_called

end -- class EV_ANY

--|-----------------------------------------------------------------------------
--| The "bridge pattern" as used in Vision2
--|
--| The bridge pattern is described in the Design Patterns book (Gamma et al.).
--| It provides a way to seperate interface from implementation so that the two
--| can be structured differently.
--| The bridge pattern comes at the cost of a high maintenence overhead as any
--| change to the interface must be duplicated in the implementation interface.
--| The implementation interface should really be generated from the interface.
--|
--| The following features of the bridge patter are not used in Eiffel Vision.
--| - Hiding of propritary implementation through delivery of interface source
--|   but only compiled implementations. (Not applicable in Eiffel)
--| - Protection of clients from relinking due to implementation changes.
--|   (Not applicable in Eiffel)
--| - Sharing an implementation object among interface objects.
--| - Delaying creation of implementation object.
--|-----------------------------------------------------------------------------

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
