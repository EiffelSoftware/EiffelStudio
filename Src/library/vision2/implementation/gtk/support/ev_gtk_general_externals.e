--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "External C functions for accessing gtk.%
		% Those are used by all the widgets.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_GENERAL_EXTERNALS

feature {NONE} -- Cast features

	c_gtk_integer_to_pointer (i: INTEGER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_pointer_to_integer (i: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

end -- class EV_GTK_GENERAL_EXTERNALS

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
--| Revision 1.11  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.5  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.10.6.4  2000/01/27 19:29:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.3  1999/12/03 07:47:43  oconnor
--| removed obsolete manualy created externals
--|
--| Revision 1.10.6.2  1999/12/01 16:08:40  oconnor
--| rip manualy created externals
--|
--| Revision 1.10.6.1  1999/11/24 17:29:49  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
