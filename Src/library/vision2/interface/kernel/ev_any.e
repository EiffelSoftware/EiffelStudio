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
			default_create
		end
	
feature {NONE} -- Initialization

--|-----------------------------------------------------------------------------
--| Creation sequence for all Vision2 objects is like this:
--|
--| - Default_create is defined once in EV_ANY.
--| - Create_action_sequences and create_implementation are defined in
--|   descendants, default_create calls them.
--| - After it is created, initialize is called on the implementation, this will
--|   do extra setup work but need not be redefined in every descendant.
--|   (Probably redefined in EV_WIDGET_IMP but not to many other places)
--|   Next default_create calls initialize on Current.
--|   (Note: FIXME we can probably remove this step (see note near feature))
--|
--| `default_create' must be called during creation to satisfy the invariant.
--| The normal pattern is that default_create will produce a properly
--| initialized default object and any special convenience creation features
--| will call default_create then do their extra work.
--|
--| The postcondition of `default_create' checks `is_in_deafult_state', this
--| returns True by default but should be redefined by decendants to check for
--| propper initial results from class queries.
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
			default_create_called := True
			create_action_sequences
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

feature {EV_ANY} -- Status Report

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

feature {EV_ANY} -- Implementation

	create_action_sequences is 
			-- Create action sequence objects.
			--| Should only be called from `default_create'
			--| Must be defined in each descendant to create the
			--| appropriate objects.
			--| Each redefinition should call `Precursor'.
		require
			implementation_not_already_created: implementation = Void
		do
		end

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
			--| FIXME if no one redefines this we can remove it.
			--| The interface object's should not need any state anyway.
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

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default sate.
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

	is_useable: BOOLEAN is
			-- Is `Current' useable?
		do
			Result := is_initialized and not is_destroyed
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
--| FIXME put notes on bridge pattern here. 
--|-----------------------------------------------------------------------------

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.21  2000/01/27 23:32:25  oconnor
--| released
--|
--| Revision 1.7.6.20  2000/01/27 19:30:39  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.19  2000/01/27 02:36:08  brendel
--| Removed frozen from `initialize'.
--|
--| Revision 1.7.6.18  2000/01/15 01:56:39  oconnor
--| formatting
--|
--| Revision 1.7.6.17  1999/12/16 09:24:30  oconnor
--| added is_useable = is_initialized and not is_destroyed
--|
--| Revision 1.7.6.16  1999/12/16 02:20:57  oconnor
--| extended creation sequence comment
--|
--| Revision 1.7.6.15  1999/12/16 02:18:14  oconnor
--| improved comment on is_in_default_state
--|
--| Revision 1.7.6.14  1999/12/16 02:13:52  oconnor
--| added comment to is_in_default_state
--|
--| Revision 1.7.6.13  1999/12/16 02:00:25  oconnor
--| added is_in_default_state: BOOLEAN feature to check initiali state
--|
--| Revision 1.7.6.12  1999/12/15 05:21:44  oconnor
--| formatting
--|
--| Revision 1.7.6.11  1999/12/15 00:24:54  oconnor
--| formatting tweak
--|
--| Revision 1.7.6.10  1999/12/07 20:48:01  oconnor
--| added frozen to initialize, no one should use it
--|
--| Revision 1.7.6.9  1999/12/01 01:49:36  oconnor
--| formatting
--|
--| Revision 1.7.6.8  1999/12/01 01:46:52  oconnor
--| spelink
--|
--| Revision 1.7.6.7  1999/12/01 01:02:12  oconnor
--| layout tweak
--|
--| Revision 1.7.6.6  1999/12/01 00:59:28  oconnor
--| improved layout and variable names
--|
--| Revision 1.7.6.5  1999/12/01 00:48:51  oconnor
--| improved comments
--|
--| Revision 1.7.6.4  1999/11/24 22:40:03  oconnor
--| improved comments
--|
--| Revision 1.7.6.3  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.6.2  1999/11/24 00:13:11  oconnor
--| merged new comment from REVIEW_BRANCH
--|
--| Revision 1.7.6.1  1999/11/23 23:18:00  oconnor
--| merged from REVIEW BRANCH
--|
--| Revision 1.7.2.8  1999/11/23 02:10:49  oconnor
--| added create_action_sequences
--|
--| Revision 1.7.2.7  1999/11/04 23:07:14  oconnor
--| strengthend is_coupled invariant, added destroy feature
--|
--| Revision 1.7.2.6  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--| Revision 1.7.2.5  1999/10/14 21:58:20  oconnor
--| tweaked cvs log
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
