indexing
	description: "Gtk Version Dependent Externals"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

	signal_disconnect (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_disconnect"
		end

	signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
		external
			"C (GtkObject*, gpointer) | <gtk/gtk.h>"
		end

	signal_handler_block (a_object: POINTER; a_handler_id: INTEGER) is
			-- void   gtk_signal_handler_block (GtkObject *object, guint handler_id);)
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_handler_block"
		end

	signal_handler_unblock (a_object: POINTER; a_handler_id: INTEGER) is
			-- void   gtk_signal_handler_unblock      (GtkObject           *object,
			--                                         guint                handler_id);
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_handler_unblock"
		end

	signal_emit_stop_by_name (a_object: POINTER; a_name: POINTER) is
			-- void   gtk_signal_emit_stop_by_name    (GtkObject           *object,
			--                                         const gchar         *name);
		external
			"C (GtkObject*, gchar*) | <gtk/gtk.h>"
		alias
			"gtk_signal_emit_stop_by_name"
		end
		
	gtk_editable_struct_selection_start (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
		alias
			"selection_start_pos"
		end
		
	gtk_editable_struct_selection_end (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
		alias
			"selection_end_pos"
		end

	gtk_style_set_font (a_c_struct: POINTER; a_font: POINTER) is
		external
			"C [struct <gtk/gtk.h>] (GtkStyle, GdkFont*)"
		alias
			"font"
		end

	gtk_style_get_font (a_c_struct: POINTER): POINTER is
			-- (from C_GTK_STYLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"font"
		end

	gtk_paned_set_gutter_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C (GtkPaned*, guint16) | <gtk/gtk.h>"
		end

	gtk_paned_set_handle_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C (GtkPaned*, guint16) | <gtk/gtk.h>"
		end

	gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER) is
		external
			"C (GtkMenuBar*, GtkShadowType) | <gtk/gtk.h>"
		end

	gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN is
		do
			Result := gtk_editable_struct_editable (a_c_struct) /= 0
		end

	gtk_widget_set_default_visual (a_visual: POINTER) is
			-- void	     gtk_widget_set_default_visual   (GdkVisual	  *visual);
			-- (from C_GTK_WIDGET)
		external
			"C (GdkVisual*) | <gtk/gtk.h>"
		end

	object_destroy (a_c_object: POINTER) is
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_object_destroy)
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_destroy"
		end

	object_ref (a_c_object: POINTER) is
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_ref"
		end

	object_unref (a_c_object: POINTER) is
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_unref"
		end


feature {NONE} -- Implementation

        gtk_editable_struct_editable (a_c_struct: POINTER): INTEGER is
                        -- (from C_GTK_EDITABLE_STRUCT)
                external
                        "C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
                alias
                        "editable"
                end

end

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

