indexing
	description: "External C routines for accessing gtk";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_EXTERNALS

feature -- GTK C functions for objects

	gtk_object_floating (w: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_OBJECT_FLOATING"
		end

feature  -- GtkWindow function

	gtk_is_window (w: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_IS_WINDOW"
		end
	
feature  -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end
end

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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.62  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.58.4.4  2000/10/06 20:11:47  oconnor
--| cosmetics
--|
--| Revision 1.58.4.3  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.58.4.2  2000/05/25 00:32:34  king
--| Removed redundant externals
--|
--| Revision 1.58.4.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.60  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.59  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.58.6.7  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.58.6.6  2000/01/27 19:29:35  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.58.6.5  1999/12/04 18:59:15  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.58.6.4  1999/12/01 16:58:58  oconnor
--| removed old externals, now in EV_C_GTK
--|
--| Revision 1.58.6.3  1999/12/01 16:09:20  oconnor
--| rip manualy created externals
--|
--| Revision 1.58.6.2  1999/11/30 22:59:56  oconnor
--| trimming externals
--|
--| Revision 1.58.6.1  1999/11/24 17:29:49  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.58.2.4  1999/11/17 01:50:27  oconnor
--| removed externals that are genereated by GOTE anyway
--|
--| Revision 1.58.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.58.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
