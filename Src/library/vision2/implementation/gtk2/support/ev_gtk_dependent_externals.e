indexing
	description: "Gtk Version Dependent Externals"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

	frozen g_object_set (a_object: POINTER; a_property: POINTER; arg1: POINTER; arg2: POINTER) is
		external
			"C signature (gpointer, gchar*, gpointer, gpointer) use <gtk/gtk.h>"
		end
		
	frozen g_object_set_string (a_object: POINTER; a_property: POINTER; string_arg: POINTER) is
		external
			"C signature (gpointer, gchar*, gchar*) use <gtk/gtk.h>"
		alias
			"g_object_set"
		end

	frozen g_object_set_integer (a_object: POINTER; a_property: POINTER; int_arg: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $int_arg)"
		end
		
	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $bool_arg)"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C signature (gpointer, gulong) use <gtk/gtk.h>"
		alias
			"g_signal_handler_disconnect"
		end
		
	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_disconnect_by_data"
		end

	frozen signal_handler_block (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_handler_block"
		end

	frozen signal_handler_unblock (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_handler_unblock"
		end

	frozen signal_emit_stop_by_name (a_object: POINTER; a_name: POINTER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_emit_stop_by_name"
		end
		
	frozen gtk_editable_struct_selection_start (a_c_struct: POINTER): INTEGER is
		external
			"C struct GtkOldEditable access selection_start_pos use <gtk/gtk.h>"
		end
		
	frozen gtk_editable_struct_selection_end (a_c_struct: POINTER): INTEGER is
		external
			"C struct GtkOldEditable access selection_end_pos use <gtk/gtk.h>"
		end

	frozen gtk_style_set_font (a_c_struct: POINTER; a_font: POINTER) is
		external
			"C signature (GtkStyle*, GdkFont*) use <gtk/gtk.h>"
		end

	frozen gtk_style_get_font (a_c_struct: POINTER): POINTER is
		external
			"C signature (GtkStyle*): EIF_POINTER use <gtk/gtk.h>"
		end

	frozen gtk_paned_set_gutter_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_paned_set_handle_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN is
		external
			"C signature (GtkEditable*): EIF_BOOLEAN use <gtk/gtk.h>"
		end
		
	frozen gtk_widget_set_default_visual (a_visual: POINTER) is
		external
			"C macro use <gtk/gtk.h>"
		end
	
	frozen object_destroy (a_c_object: POINTER) is
		external
			"C signature (GtkObject*) use <gtk/gtk.h>"
		alias
			"gtk_object_destroy"
		end

	frozen object_ref (a_c_object: POINTER) is
		external
			"C signature (gpointer) use <gtk/gtk.h>"
		alias
			"g_object_ref"
		end
		
	frozen object_unref (a_c_object: POINTER) is
		external
			"C signature (gpointer) use <gtk/gtk.h>"
		alias
			"g_object_unref"
		end

	frozen gtk_text_view_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_text_view_get_buffer (a_text_view: POINTER): POINTER is
		external
			"C signature (GtkTextView*): GtkTextBuffer* use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_set_text (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_insert_at_cursor (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_insert (a_text_buffer: POINTER; a_text_iter: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_start_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_end_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_selection_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_selection_bound (a_text_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_insert (a_text_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_move_mark (a_text_buffer: POINTER; a_text_mark: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextMark*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_text (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER; inc_hid_chars: BOOLEAN): POINTER is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, gboolean): gchar* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_line_count (a_text_buffer: POINTER): INTEGER is
		external
			"C signature (GtkTextBuffer*): gint use <gtk/gtk.h>"
		end	
		
	frozen gtk_text_iter_get_text (a_start_iter: POINTER; a_end_iter: POINTER): POINTER is
		external
			"C signature (GtkTextIter*, GtkTextIter*): gchar* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_set_editable (a_text_view: POINTER; a_setting: BOOLEAN) is
		external
			"C signature (GtkTextView*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_get_editable (a_text_view: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_set_wrap_mode (a_text_view: POINTER; a_wrap_mode: INTEGER) is
		external
			"C signature (GtkTextView*, GtkWrapMode) use <gtk/gtk.h>"
		end
	
	Gtk_wrap_none_enum: INTEGER is 0
	Gtk_wrap_char_enum: INTEGER is 1
	Gtk_wrap_word_enum: INTEGER is 2
	
	frozen gtk_text_tag_new (a_name: POINTER): POINTER is
		external
			"C signature (gchar*): GtkTextTag* use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_apply_tag (a_buffer: POINTER; a_tag: POINTER; a_start: POINTER; a_end: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextTag*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_tag_table (a_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextTagTable* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_tag_table_add (a_table: POINTER; a_tag: POINTER) is
		external
			"C signature (GtkTextTagTable*, GtkTextTag*)"
		end

	frozen gtk_text_buffer_remove_all_tags (a_buffer: POINTER; a_start: POINTER; a_end: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_iter_at_line (a_text_buffer: POINTER; a_text_iter: POINTER; a_line_number: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_iter_at_mark (a_text_buffer: POINTER; a_text_iter: POINTER; a_text_mark: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextMark*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_iter_at_offset (a_text_buffer: POINTER; a_text_iter: POINTER; a_char_offset: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_delete_selection (a_text_buffer: POINTER; a_interactive: BOOLEAN; a_default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, gboolean, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_delete (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end
	
	frozen gtk_text_buffer_place_cursor (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end		
	
	frozen gtk_text_iter_forward_to_line_end (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_forward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_forward_display_line_end (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_iter_get_offset (a_text_iter: POINTER): INTEGER is
		external
			"C signature (GtkTextIter*): gint use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_get (a_atom: INTEGER): POINTER is
		external
			"C signature (GdkAtom): GtkClipboard* use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_set_text (a_clipboard: POINTER; a_text: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkClipboard*, gchar*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_wait_for_text (a_clipboard: POINTER): POINTER is
		external
			"C signature (GtkClipboard*): gchar* use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_wait_is_text_available (a_clipboard: POINTER): BOOLEAN is
		external
			"C signature (GtkClipboard*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_cut_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_copy_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_paste_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; a_text_iter: POINTER; default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, GtkTextIter*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_scroll_to_iter (a_text_view: POINTER; a_text_iter: POINTER; within_margin: DOUBLE; use_align: BOOLEAN; xalign: DOUBLE; yalign: DOUBLE) is
		external
			"C signature (GtkTextView*, GtkTextIter*, gdouble, gboolean, gdouble, gdouble) use <gtk/gtk.h> "
		end
		
	frozen gtk_text_iter_copy (a_text_iter: POINTER): POINTER is
		external
			"C signature (GtkTextIter*): GtkTextIter* use <gtk/gtk.h>"
		end

	frozen gtk_image_set_from_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER) is
		external
			"C signature (GtkImage*, GdkPixmap*, GdkBitmap*) use <gtk/gtk.h>"
		end
		
	frozen gtk_image_get_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER) is
		external
			"C signature (GtkImage*, GdkPixmap**, GdkBitmap**) use <gtk/gtk.h>"
		end
		
	frozen gtk_image_new_from_pixmap (a_pixmap: POINTER; a_mask: POINTER): POINTER is
		external
			"C signature (GdkPixmap*, GdkBitmap*): GtkImage* use <gtk/gtk.h>"
		end

	frozen gtk_image_new: POINTER is
		external
			"C signature (): GtkImage* use <gtk/gtk.h>"
		end
		
	frozen gtk_dialog_new: POINTER is
		external	
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end
		
	frozen gtk_dialog_set_has_separator (a_dialog: POINTER; a_setting: BOOLEAN) is
		external
			"C signature (GtkDialog*, gboolean) use <gtk/gtk.h>"
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

