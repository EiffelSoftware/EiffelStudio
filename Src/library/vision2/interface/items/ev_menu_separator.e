indexing
	description:
		"Horizontal scored line separator for use in EV_MENU."
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

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_SEPARATOR_I
		-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_MENU_SEPARATOR

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
--| Revision 1.8  2000/03/23 01:40:33  oconnor
--| comments, formatting
--|
--| Revision 1.7  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.6  2000/02/29 18:09:07  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.5  2000/02/22 19:53:41  brendel
--| Changed export status of implementation.
--|
--| Revision 1.4  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
