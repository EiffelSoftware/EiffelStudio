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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

