indexing
	description: "External C routines for accessing gtk.%
		% Those are used fot casting types.";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_GTK_TYPES_EXTERNALS


feature {NONE} -- GTK macros for casting types

	gtk_object (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_OBJECT"
		end

	gtk_misc (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_MISC"
		end
	
	gtk_object_type  (widget: POINTER): INTEGER is
		external
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_INTEGER"
		alias
			"GTK_OBJECT_TYPE"
		end
			

feature {NONE} -- Primitives

	gtk_editable (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_EDITABLE"
		end

	gtk_menu_bar (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_MENU_BAR"
		end

	gtk_tree (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_TREE"
		end

	gtk_tree_item (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_TREE_ITEM"
		end

feature {NONE} -- Containers

	gtk_container (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_CONTAINER"
		end
	
	gtk_box (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_BOX"
		end
	
	gtk_table (widget: POINTER): POINTER is
		external
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_TABLE"
		end
	
	gtk_scrolled_window (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_SCROLLED_WINDOW"
		end

	gtk_window (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_WINDOW"
		end

	gtk_file_selection (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_FILE_SELECTION"
		end

feature {NONE} -- Items	
	
	gtk_menu_item (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_MENU_ITEM"
		end
	
	gtk_menu (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>] (GtkObject *): EIF_POINTER"
		alias
			"GTK_MENU"
		end

end -- class EV_GTK_TYPES_EXTERNALS

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
--| Revision 1.11  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.2  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.7.4.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.4  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.7.6.3  2000/01/27 19:29:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  1999/12/04 18:59:16  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.7.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
