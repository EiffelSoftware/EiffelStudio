indexing
	description: "Gtk Version Dependent Externals"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

	signal_disconnect (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C (gpointer, gulong) | <gtk/gtk.h>"
		alias
			"g_signal_handler_disconnect"
		end
		
	signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_signal_disconnect_by_data"
		end

	signal_handler_block (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_signal_handler_block"
		end

	signal_handler_unblock (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_signal_handler_unblock"
		end

	signal_emit_stop_by_name (a_object: POINTER; a_name: POINTER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_signal_emit_stop_by_name"
		end
		
	gtk_editable_struct_selection_start (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkOldEditable): EIF_INTEGER"
		alias
			"selection_start_pos"
		end
		
	gtk_editable_struct_selection_end (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkOldEditable): EIF_INTEGER"
		alias
			"selection_end_pos"
		end

	gtk_style_set_font (a_c_struct: POINTER; a_font: POINTER) is
		external
			"C (GtkStyle*, GdkFont*) | <gtk/gtk.h>"
		end

	gtk_style_get_font (a_c_struct: POINTER): POINTER is
		external
			"C (GtkStyle*): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_paned_set_gutter_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			" "
		end

	gtk_paned_set_handle_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			" "
		end

	gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER) is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			" "
		end

	gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN is
		external
			"C (GtkEditable*): EIF_BOOLEAN | <gtk/gtk.h>"
		end
		
	gtk_widget_set_default_visual (a_visual: POINTER) is
		external
			"C [macro <gtk/gtk.h>]"
		end
	
	object_destroy (a_c_object: POINTER) is
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_destroy"
		end

	object_ref (a_c_object: POINTER) is
		external
			"C (gpointer) | <gtk/gtk.h>"
		alias
			"g_object_ref"
		end
		
	object_unref (a_c_object: POINTER) is
		external
			"C (gpointer) | <gtk/gtk.h>"
		alias
			"g_object_unref"
		end

	gtk_text_view_new: POINTER is
		external
			"C (): GtkWidget* | <gtk/gtk.h>"
		end

	gtk_text_view_get_buffer (a_text_view: POINTER): POINTER is
		external
			"C (GtkTextView*): GtkTextBuffer* | <gtk/gtk.h>"
		end

	gtk_text_buffer_set_text (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	gtk_text_buffer_get_start_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C (GtkTextBuffer*, GtkTextIter*) | <gtk/gtk.h>"
		end
		
	gtk_text_buffer_get_end_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C (GtkTextBuffer*, GtkTextIter*) | <gtk/gtk.h>"
		end
		
	gtk_text_buffer_get_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) | <gtk/gtk.h>"
		end

	gtk_text_buffer_get_text (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER; inc_hid_chars: BOOLEAN): POINTER is
		external
			"C (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, gboolean ): gchar* | <gtk/gtk.h>"
		end
		
	gtk_text_buffer_get_line_count (a_text_buffer: POINTER): INTEGER is
		external
			"C (GtkTextBuffer*): gint | <gtk/gtk.h>"
		end	
		
	gtk_text_iter_get_text (a_start_iter: POINTER; a_end_iter: POINTER): POINTER is
		external
			"C (const GtkTextIter*, const GtkTextIter*): gchar* | <gtk/gtk.h>"
		end
		
	gtk_text_view_set_editable (a_text_view: POINTER; a_setting: BOOLEAN) is
		external
			"C (GtkTextView*, gboolean) | <gtk/gtk.h>"
		end
		
	gtk_text_view_get_editable (a_text_view: POINTER): BOOLEAN is
		external
			"C (GtkTextView*): gboolean | <gtk/gtk.h>"
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

