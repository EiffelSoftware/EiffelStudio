--| FIXME NOT_REVIEWED this file has not been reviewed
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

end -- class EV_GTK_WIDGETS_EXTERNALS

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
