indexing
	description:
	" Externals C function of Gdk and Gtk specific for the%
	% fonts."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT_EXTERNALS

feature

	c_gdk_font_ascent (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

	c_gdk_font_descent  (font: POINTER): INTEGER is
		external
			"C [macro %"gdk_eiffel.h%"]"
		end

end -- class EV_GDK_FONT_EXTERNALS

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.2  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.4.4.1  2000/05/03 19:08:42  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.4.6.3  2000/01/27 19:29:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  1999/12/04 18:59:14  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.4.6.1  1999/11/24 17:29:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
