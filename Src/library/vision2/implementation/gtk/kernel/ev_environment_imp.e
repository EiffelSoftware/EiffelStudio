indexing
	description:
		"Eiffel Vision Environment. GTK implementation."
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I

create
	make

feature -- Status report

	platform: INTEGER is 0

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Pass `an_interface' to base make.
		do
			base_make (an_interface)
		end

	initialize is
			-- No initialization needed.
		do
			is_initialized := True
		end

invariant
	platform_matches_interface: platform = interface.Ev_platform_gtk

end -- class EV_ENVIRONMENT_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.6.1  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:08  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.1.2.4  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  1999/12/15 16:32:46  oconnor
--| formatting
--|
--| Revision 1.1.2.2  1999/12/15 05:22:21  oconnor
--| EV_ENVIRONMENT now inherits EV_ANY
--|
--| Revision 1.1.2.1  1999/12/09 22:48:07  brendel
--| New version of EV_ENVIRONMENT with feature `platform'. This feature is not
--| intended to be used by the way.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
