indexing
	description:
		"Eiffel Vision Environment.%N%
		%Provides access to global environment information."
	status: "See notice at end of class"
	keywords: "environment, application, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT

inherit
	EV_ANY
		redefine
			implementation
		end

create
	default_create

feature -- Access

	application: EV_APPLICATION is
			-- Single application object for system.
		do
			Result := application_cell.item
		ensure
			Result = application_cell.item
		end

feature -- Status report

	Ev_platform_gtk: INTEGER is 0
			-- Code for GTK platform.

	Ev_platform_win32: INTEGER is 1
			-- Code for win32 platform.

	platform: INTEGER is
			-- Current underlying platform.
			-- Either `Ev_platform_gtk' or `Ev_platform_win32'.
		obsolete
			"This feature was not intended to be used, EiffelVision should be%N%
			%platform independent. Please let us know why you need this.%N%
			%email: vision2@eiffel.com"
		do
			Result := implementation.platform
		ensure
			bridge_ok: Result = implementation.platform
			within_range: Result = Ev_platform_gtk or Result = Ev_platform_win32
		end

feature {EV_APPLICATION} -- Access

	set_application (an_application: EV_APPLICATION) is
			-- Specify `an_application' as the single application object for the
			-- system.
			-- Must be called exactly once from EV_APPLICATION's creation
			-- procedure.
		require
			application_not_already_set: application = Void
		do
			application_cell.put (an_application)
		ensure
			application_assigned: application = an_application
		end

feature {NONE} -- Implementation

	application_cell: CELL [EV_APPLICATION] is
			-- A global cell where `item' is the single application object for
			-- the system.
		once
			create Result.put (Void)
		end

	implementation: EV_ENVIRONMENT_I
            -- Responsible for interaction with the underlying native graphics
            -- toolkit.

	create_implementation is
			-- Create implementation of environment.
		do
			create {EV_ENVIRONMENT_IMP} implementation.make (Current)
		end

end -- class EV_ENVIRONMENT

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
--| Revision 1.2  2000/02/14 12:05:12  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.5  2000/01/28 20:02:21  oconnor
--| released
--|
--| Revision 1.1.4.4  2000/01/27 19:30:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.3  1999/12/15 05:22:22  oconnor
--| EV_ENVIRONMENT now inherits EV_ANY
--|
--| Revision 1.1.4.2  1999/12/09 22:48:08  brendel
--| New version of EV_ENVIRONMENT with feature `platform'. This feature is not
--| intended to be used by the way.
--|
--| Revision 1.1.4.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.1  1999/11/02 17:21:01  oconnor
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
