indexing
	description: "Eiffel Vision check button. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end
		
	EV_TOGGLE_BUTTON_IMP
		redefine
			default_style,
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the check button with no label.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
					+ Ws_tabstop + Bs_autocheckbox
		end

	interface: EV_CHECK_BUTTON

end -- class EV_CHECK_BUTTON_IMP

--!----------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--!----------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.27  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.26  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.20.8.1  2000/05/03 19:09:49  oconnor
--| mergred from HEAD
--|
--| Revision 1.25  2000/02/25 21:28:16  brendel
--| Formatting.
--|
--| Revision 1.24  2000/02/24 20:38:33  brendel
--| Revised.
--| Does not inherit from WEL_CHECK_BOX anymore, but just redefines
--| `default_style'. See class WEL_CHECK_BOX.
--|
--| Revision 1.23  2000/02/23 20:35:01  rogers
--| improved comments. Added wel parenting compiler fix.
--|
--| Revision 1.22  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.21  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.20.10.3  2000/01/27 19:30:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.10.2  2000/01/10 20:00:54  rogers
--| Altered to comply with the major Vision2 changes. See diff for redefinitions. Make now takes an interface and make_with_text has been removed.
--|
--| Revision 1.20.10.1  1999/11/24 17:30:31  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
