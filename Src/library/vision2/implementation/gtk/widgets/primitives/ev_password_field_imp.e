indexing
	description:
		"Eiffel Vision password field. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Create password field with `*'.
		do
			Precursor
			C.gtk_entry_set_visibility (c_object, False)		
		end

feature {NONE} -- Implementation

	interface: EV_PASSWORD_FIELD

end -- class EV_PASSWORD_FIELD_IMP

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
--| Revision 1.9  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/07 01:12:43  brendel
--| Revised.
--|
--| Revision 1.6  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
