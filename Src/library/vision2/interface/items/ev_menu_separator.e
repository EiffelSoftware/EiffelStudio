indexing
	description: "Eiffel Vision menu separator."
	status: "See notice at end of class."
	keywords: "menu, item, separator"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR

inherit
	EV_MENU_ITEM
		export
			{NONE} all
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature {NONE} -- Implementation

	implementation: EV_MENU_SEPARATOR_I
			-- Platform dependent access

	create_implementation is
		do
			create {EV_MENU_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_MENU_SEPARATOR

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/02/05 01:43:44  brendel
--| Exports all inherited features to {NONE}. Can only be created using
--| `default_create' and cannot be manipulated or queried.
--|
--| Revision 1.2.6.4  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.2.6.3  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.2.6.2  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
