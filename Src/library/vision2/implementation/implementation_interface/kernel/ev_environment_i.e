indexing
	description:
		"Eiffel Vision Environment. Implementation interface.%N%
		%See ev_environment.e"
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ENVIRONMENT_I

inherit
	EV_ANY_I
		redefine
			interface
		end
		
feature {EV_ENVIRONMENT} -- Status report
		
	application: EV_APPLICATION is
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := application_cell.item
		ensure
			Result = application_cell.item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ENVIRONMENT
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'
            
feature {EV_APPLICATION_I} -- Access

	set_application (an_application: EV_APPLICATION) is
			-- Specify `an_application' as the single application object for the
			-- system. Must be called exactly once from EV_APPLICATION's
			-- creation procedure.
		require
			not_destroyed: not is_destroyed
			application_not_already_set: application = Void
		do
			application_cell.put (an_application)
		ensure
			application_assigned: application = an_application
		end

feature {NONE} -- Implementation

	Application_cell: CELL [EV_APPLICATION] is
			-- A global cell where `item' is the single application object for
			-- the system.
		require
			not_destroyed: not is_destroyed
		once
			create Result.put (Void)
		end

feature -- Command

	destroy is
			-- Render current unusable.
		do
			is_destroyed := True
		end

end -- class EV_ENVIRONMENT_I

--!----------------------------------------------------------------------------
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
--!----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/06/13 19:24:24  rogers
--| Removed platform.
--|
--| Revision 1.5  2001/06/13 19:08:43  rogers
--| Added `set_application', `Application_cell' and `application'. These
--| were in the interface, but as they are only used for implementatation,
--| they have been moved here to hide them from users of vision2.
--|
--| Revision 1.4  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.6.3  2001/05/18 18:21:14  king
--| Removed destroy_just_called code
--|
--| Revision 1.3.6.2  2001/02/16 00:21:18  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.3.6.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.1.2.4  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  1999/12/15 16:32:46  oconnor
--| formatting
--|
--| Revision 1.1.2.2  1999/12/15 05:22:21  oconnor
--| EV_ENVIRONMENT now inherits EV_ANY
--|
--| Revision 1.1.2.1  1999/12/09 22:48:08  brendel
--| New version of EV_ENVIRONMENT with feature `platform'. This feature is not
--| intended to be used by the way.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
