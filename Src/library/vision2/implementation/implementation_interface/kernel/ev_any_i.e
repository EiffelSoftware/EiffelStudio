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

feature {EV_ANY, EV_ANY_I} -- Command

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		deferred
		ensure
			is_destroyed_set: is_destroyed
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

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

	set_interface (an_interface: like interface) is
			-- Assign `an_interface' to `interface'. 
			-- Should only ever be called by {EV_ANY}.replace_implementation.
		do
			check
				called_by_replace_implementation_only: false
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
				called_by_replace_implementation_only: false
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
				called_by_replace_implementation_only: false
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.12  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.5  2001/05/18 18:20:51  king
--| Removed destroy_just_called code
--|
--| Revision 1.6.4.4  2001/05/17 22:22:59  king
--| Removed unworkable no_calls_after_destroy invariant
--|
--| Revision 1.6.4.3  2001/02/16 00:21:18  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.6.4.2  2000/10/12 15:18:02  pichery
--| invariant `no_calls_after_destroy' now takes into account
--| `is_destroyed'
--|
--| Revision 1.6.4.1  2000/05/03 19:08:55  oconnor
--| mergred from HEAD
--|
--| Revision 1.11  2000/04/12 01:21:06  pichery
--| - added feature `disable_initialized'
--| - renamed feature `set_initialized' to
--|   `enable_initialized'
--|
--| Revision 1.10  2000/04/11 17:46:18  oconnor
--| typo
--|
--| Revision 1.9  2000/04/11 17:29:43  oconnor
--| added set_interface and set_initialized
--|
--| Revision 1.8  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/02/04 04:15:55  oconnor
--| release
--|
--| Revision 1.6.6.8  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.7  1999/12/05 03:07:57  oconnor
--| added is_useable =  is_initialized and not is_destroyed
--|
--| Revision 1.6.6.6  1999/12/03 04:09:24  brendel
--| Added is_initialized as postcondition to initialize.
--|
--| Revision 1.6.6.5  1999/12/01 23:14:42  oconnor
--| fixed precondition tag
--|
--| Revision 1.6.6.4  1999/12/01 01:48:32  oconnor
--| spelink
--|
--| Revision 1.6.6.3  1999/12/01 01:20:51  oconnor
--| improved comments
--|
--| Revision 1.6.6.2  1999/11/26 19:47:39  oconnor
--| removed obsolete shell feature
--|
--| Revision 1.6.6.1  1999/11/23 23:22:13  oconnor
--| merged from REVIEW BRANCH
--|
--| Revision 1.6.2.8  1999/11/12 07:57:26  oconnor
--| removed inheritance of MEMORY
--|
--| Revision 1.6.2.7  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.6.2.6  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.5  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--| Revision 1.6.2.4  1999/10/14 21:59:41  oconnor
--| added cvs log
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
