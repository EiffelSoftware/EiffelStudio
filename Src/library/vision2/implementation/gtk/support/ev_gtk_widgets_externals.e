indexing
	description: "External C functions for accessing gtk.%
		% Those are used by widgets.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_WIDGETS_EXTERNALS

feature

	c_gtk_widget_has_focus (w: POINTER): BOOLEAN is
		external 
			"C [macro <gtk/gtk.h>] (GtkWidget *): EIF_BOOLEAN"
		alias
			"GTK_WIDGET_HAS_FOCUS"
		end

	c_gtk_widget_can_focus (w: POINTER): BOOLEAN is
		external 
			"C [macro <gtk/gtk.h>] (GtkWidget *): EIF_BOOLEAN"
		alias
			"GTK_WIDGET_CAN_FOCUS"
		end

	gtk_is_widget (w: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_IS_WIDGET"
		end

	gtk_is_container (w: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_IS_CONTAINER"
		end

end -- class EV_GTK_WIDGETS_EXTERNALS

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
--| Revision 1.16  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.15  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.4.3  2000/09/18 18:16:05  oconnor
--| added gtk_is_container
--|
--| Revision 1.12.4.2  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.12.4.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.7  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.12.6.6  2000/01/27 19:29:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.5  1999/12/04 18:59:16  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.12.6.4  1999/12/03 07:47:43  oconnor
--| removed obsolete manualy created externals
--|
--| Revision 1.12.6.3  1999/12/03 05:03:45  oconnor
--| added gtk_is_widget
--|
--| Revision 1.12.6.2  1999/11/30 22:59:56  oconnor
--| trimming externals
--|
--| Revision 1.12.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/04 23:10:27  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
