indexing
	description: "Some C routines of wel used by Vision2."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_C_ROUTINE_IMP

feature -- Conversion

	cwel_pointer_to_integer (p: POINTER): INTEGER is
			-- Converts a pointer `p' to an integer
		external
			"C [macro <wel.h>] (EIF_POINTER): EIF_INTEGER"
		end

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		end

end -- class EV_C_ROUTINE_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision Library: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.8.2  2000/08/11 16:25:50  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.1.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
