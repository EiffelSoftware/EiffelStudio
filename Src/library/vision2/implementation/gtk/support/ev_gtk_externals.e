indexing
	description: "External C routines for accessing gtk";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class EV_GTK_EXTERNALS

feature -- GTK C functions for objects

	gtk_object_ref (w: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_object_unref (w: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for separators

	gtk_hseparator_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_vseparator_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for tooltips
		
	gtk_tooltips_new: POINTER is
		external
			"C : EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_tooltips_set_tip (tooltips, widget, txt, tip_private: POINTER) is
		external
			"C (GtkTooltips *, GtkWidget *, const gchar *txt, const gchar *tip_private) | <gtk/gtk.h>"
		end

	gtk_tooltips_enable (tooltips: POINTER) is
		external
			"C (GtkTooltips *) | <gtk/gtk.h>"
		end

	gtk_tooltips_disable (tooltips: POINTER) is
		external
			"C (GtkTooltips *) | <gtk/gtk.h>"
		end

	gtk_tooltips_set_delay (tooltips: POINTER; delay: INTEGER) is
		external
			"C (GtkTooltips *, guint) | <gtk/gtk.h>"
		end

	c_gtk_tooltips_delay (tooltips: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end
		
	c_gtk_tooltips_get_fg_color (tooltips: POINTER; r, g ,b: POINTER) is
		external
			"C (GtkTooltips *, int *, int *, int *) | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_get_bg_color (tooltips: POINTER; r, g ,b: POINTER) is
		external
			"C (GtkTooltips *, int *, int *, int *) | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_set_bg_color (tooltips: POINTER; r, g ,b: INTEGER) is
		external
			"C (GtkTooltips *, int, int, int) | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_set_fg_color (tooltips: POINTER; r, g ,b: INTEGER) is
		external
			"C (GtkTooltips *, int, int, int) | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for label

	gtk_label_new (l: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_label_set_text (l: POINTER; text: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_label_get (l: POINTER; text: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_misc_set_alignment (widget: POINTER; x_align, y_aligne: REAL) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_misc_set_padding (widget: POINTER; x_pad, y_pad: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for toolbars

	gtk_toolbar_new (o, s: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_toolbar_append_space (t: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_orientation (t: POINTER; o: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_style (t: POINTER; style: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_space_size (t: POINTER; sz: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_tooltips (t: POINTER; fl: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
feature {NONE} -- GTK C functions for gtkeditable

	gtk_editable_set_editable (edit: POINTER; flag: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_set_position (edit: POINTER; pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_insert_text (widget, text: POINTER; text_length, position: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_editable_delete_text (widget: POINTER; start_pos, end_pos: INTEGER) is
		external
			"C (GtkEditable *, gint, gint) | <gtk/gtk.h>"
		end
	
	gtk_editable_get_chars (widget: POINTER; start_pos, end_pos: INTEGER): POINTER is
		external
			"C (GtkEditable *, gint, gint): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_editable_select_region (edit: POINTER; start_pos, end_pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_delete_selection (edit: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_cut_clipboard (edit: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_copy_clipboard (edit: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_editable_paste_clipboard (edit: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_editable_position (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_editable_selection_start (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_editable_selection_end (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_editable_has_selection (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_editable_editable (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for text_component

	gtk_entry_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_new_with_max_length (len: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_set_editable (e: POINTER; f: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_set_text (e: POINTER; t: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_append_text (e: POINTER; t: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_prepend_text (e: POINTER; t: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_get_text (e: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_entry_set_max_length (e: POINTER; max: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_entry_select_region (e: POINTER; start_pos, end_pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_set_position (e: POINTER; pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_entry_set_visibility (widget: POINTER; flag: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_entry_get_max_length (widget: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for gtk_combo

	gtk_combo_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_value_in_list (combo: POINTER; val: BOOLEAN; ok_if_empty: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_use_arrows (combo: POINTER; val: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_use_arrows_always (combo: POINTER; val: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_case_sensitive (combo: POINTER; val: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_item_string (combo: POINTER; item: POINTER; item_value: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_set_popdown_strings (combo: POINTER; strings: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_combo_disable_activate (combo: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_combo_entry (combo: POINTER): POINTER  is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_combo_list (combo: POINTER): POINTER  is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for gtktext

	gtk_text_new (hadj, vajd: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
		
	gtk_text_set_word_wrap (text: POINTER; word_wrap: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_text_set_editable (text: POINTER; editable: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_text_set_point (text: POINTER; pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_text_get_point (text: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_text_get_length (text: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

	gtk_text_backward_delete (text: POINTER; nchar: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_text_forward_delete (text: POINTER; nchar: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_text_insert (text, font, fore, back, str: POINTER; length: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_text_insert (widget: POINTER; txt: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_text_full_insert (widget, font: POINTER; r, g, b: INTEGER;
			txt: POINTER; length: INTEGER) is
		external "C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for menu
 
	gtk_menu_new: POINTER is
		external "C | <gtk/gtk.h>"
		end	
	
	gtk_menu_append (menu: POINTER; menu_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end		

	gtk_menu_prepend (menu: POINTER; menu_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end		

feature {NONE} -- GTK C functions for menu item

	gtk_menu_bar_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_menu_bar_append (menu: POINTER; menu_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end	

feature {NONE} -- GTK C functions for status bar

	gtk_statusbar_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_statusbar_get_context_id (statusbar: POINTER; context_string: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

	gtk_statusbar_push (statusbar: POINTER; context_id: INTEGER; message: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

	gtk_statusbar_pop (statusbar: POINTER; context_id: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_statusbar_remove (statusbar: POINTER; context_id: INTEGER; mess_id: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for option buttons

	gtk_option_menu_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_option_menu_set_menu (widget: POINTER; menu: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_option_menu_set_history (widget: POINTER; index: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_option_menu_remove_menu (widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_option_button_selected_menu_item (widget: POINTER): POINTER is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_option_button_index_of_menu_item (option_menu: POINTER; menu_item: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for list

	gtk_list_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_append_items (list: POINTER; items_glist: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_clear_items (list: POINTER; starti: INTEGER; endi: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_select_item (list: POINTER; item: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_unselect_item (list: POINTER; item: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_select_all (list: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_unselect_all (list: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_set_selection_mode (list: POINTER; mode: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_list_rows (list: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selection_mode (list: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selected (list: POINTER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selected_item (list: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_insert_item (list, item: POINTER; position: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_remove_item (list, item: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	gtk_list_child_position (list: POINTER; child: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end


feature {NONE} -- GTK C functions for multi-column list

	gtk_clist_new (column: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_set_selection_mode (list: POINTER; mode: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_column_titles_show (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_column_titles_hide (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_column_titles_active (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_column_titles_passive (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_set_column_title (list: POINTER; column: INTEGER; title: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_set_column_justification (list: POINTER; column: INTEGER; justification: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_set_column_width (list: POINTER; column: INTEGER; width: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_set_row_height (list: POINTER; height: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_remove (list: POINTER; row: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_clear (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_clist_rows (list:POINTER): INTEGER is
		external
			"C [macro <gtk_eiffel.h>]"
		end
	
	c_gtk_clist_columns (list: POINTER): INTEGER is
		external
			"C [macro <gtk_eiffel.h>]"
		end
	
	c_gtk_clist_selection_mode (list: POINTER): INTEGER is
		external
			"C [macro <gtk_eiffel.h>]"
		end

	c_gtk_clist_append_row (list: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_selected (list: POINTER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_ith_selected_item (list: POINTER; i: INTEGER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_selection_length (list: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	gtk_clist_unselect_all (list: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for tree

--	gtk_tree_new: POINTER is
--		external
--			"C | <gtk/gtk.h>"
--		end

--	gtk_tree_append (tree: POINTER; item: POINTER) is
--		external
--			"C | <gtk/gtk.h>"
--		end

--	gtk_tree_remove_item (tree: POINTER; item: POINTER) is
--		external
--			"C | <gtk/gtk.h>"
--		end

--	c_gtk_tree_set_single_selection_mode (tree: POINTER) is
--      	external
--			"C | %"gtk_eiffel.h%""
--     		end

--	c_gtk_tree_selected_item (tree: POINTER): POINTER is
--   		external
--			"C | %"gtk_eiffel.h%""
--		end

feature {NONE} -- GTK C functions for ctree

	gtk_ctree_new (col, tree_col: INTEGER): POINTER is
		external
			"C (gint, gint): EIF_POINTER| <gtk/gtk.h>"
		end

	c_gtk_ctree_insert_node (ctree, parent, sibling, text: POINTER; spacing: INTEGER; pix, mask: POINTER; is_leaf, expand: BOOLEAN): POINTER is
		external
			"C (GtkCTree *,	GtkCTreeNode*, GtkCTreeNode*, gchar *, guint8, GdkPixmap*, GdkBitmap*, gboolean, gboolean): EIF_POINTER | %"gtk_eiffel.h%""
		end

	gtk_ctree_remove_node (ctree: POINTER; node: POINTER) is
		external
			"C (GtkCTree *, GtkCTreeNode *) | <gtk/gtk.h>"
		end

   	c_gtk_ctree_set_single_selection_mode (tree: POINTER) is
    	external
			"C (GtkCTree *) | %"gtk_eiffel.h%""
     	   	end

   	c_gtk_ctree_selected_item (ctree: POINTER): POINTER is
       	external
			"C (GtkCTree *): EIF_POINTER | %"gtk_eiffel.h%""
     		end

--   	 c_gtk_ctree_index_of_node (ctree, node: POINTER): INTEGER is
--		external "C (GtkCTree *, GtkCTreeNode *): EIF_INTEGER | %"gtk_eiffel.h%""
--      		end
	
feature {NONE} -- GTK C functions for pixmaps

	c_gtk_pixmap_width (pixmap: POINTER): INTEGER is
        external
			"C | %"gtk_eiffel.h%""
        end

	c_gtk_pixmap_height (pixmap: POINTER): INTEGER is
        external
			"C | %"gtk_eiffel.h%""
        end

	c_gtk_pixmap_gdk_unref (pixmap: POINTER) is
        external
			"C | %"gtk_eiffel.h%""
        end

	c_gtk_pixmap_create_empty (parent: POINTER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
        end

	c_gtk_pixmap_set_from_pixmap (pixmapDest, pixmapSource: POINTER) is
        external
			"C | %"gtk_eiffel.h%""
        end

feature {NONE} -- GTK C functions for progress bar

	gtk_progress_bar_new: POINTER is
		external
			"C : EIF_POINTER | <gtk/gtk.h>"
		end

	c_gtk_progress_bar_new_with_adjustment (val: INTEGER; min: INTEGER; max: INTEGER; step_increment: INTEGER; page_increment: INTEGER): POINTER is
		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_progress_bar_set_bar_style (progressbar: POINTER; style: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_progress_bar_set_orientation (progressbar: POINTER; orientation: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_progress_bar_update (progressbar: POINTER; percentage: REAL) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_progress_bar_style (progressbar: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_progress_bar_adjustment (progressbar: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkProgressBar *): EIF_POINTER"
		end

	c_gtk_progress_bar_set_adjustment (progressbar: POINTER; value: INTEGER; step: INTEGER; min: INTEGER; max: INTEGER) is
		external
			"C (GtkProgressbar *, gfloat, gfloat, gfloat, gfloat) | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for file and directory selection

	gtk_file_selection_new (name: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_file_selection_hide_fileop_buttons (dialog: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_file_selection_get_filename (dialog: POINTER): POINTER is
		external
			"C (GtkFileSelection *): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_file_selection_set_filename (dialog: POINTER; file: POINTER) is
		external
			"C (GtkFileSelection *, gchar*) | <gtk/gtk.h>"
		end

	c_gtk_file_selection_get_ok_button (dialog: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkFileSelection *): EIF_POINTER"
		end

	c_gtk_file_selection_get_cancel_button (dialog: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkFileSelection *): EIF_POINTER"
		end

	c_gtk_selection_get_selection_entry (dialog: POINTER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_file_selection_get_dir (dialog: POINTER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_directory_selection_new (name: POINTER): POINTER is
		external
			"C (const gchar *): EIF_POINTER | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for color selection

	c_gtk_color_selection_dialog_new (name: POINTER): POINTER is
		external
			"C (char*): EIF_POINTER | %"gtk_eiffel.h%""
		end

	gtk_color_selection_get_color (dialog: POINTER; color: POINTER) is
		external
			"C (GtkColorSelectionDialog *, gdouble *) | <gtk/gtk.h>"
		end

	gtk_color_selection_set_color (dialog: POINTER; color: POINTER) is
		external
			"C (GtkColorSelectionDialog *, gdouble *) | <gtk/gtk.h>"
		end

	c_gtk_color_selection_get_ok_button (dialog: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkColorSelectionDialog *): EIF_POINTER"
		end

	c_gtk_color_selection_get_cancel_button (dialog: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkColorSelectionDialog *): EIF_POINTER"
		end

	c_gtk_color_selection_get_help_button (dialog: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"] (GtkColorSelectionDialog *): EIF_POINTER"
		end

	c_gtk_color_selection_get_color (file_dialog: POINTER; r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_color_selection_set_color (file_dialog: POINTER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for spin buttons 

	c_gtk_spin_button_new (value, main, max: REAL; step, leap: REAL): POINTER is
 		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_step (spinButton: POINTER; step: INTEGER) is
 		external
			"C (GtkSpinButton *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_minimum (spinButton: POINTER; min: INTEGER) is
 		external
			"C (GtkSpinButton *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_maximum (spinButton: POINTER; max: INTEGER) is
 		external
			"C (GtkSpinButton *, gfloat) | %"gtk_eiffel.h%""
		end

	gtk_spin_button_get_value_as_float (spinButton: POINTER): INTEGER is
 		external
			"C (GtkSpinButton *): EIF_INTEGER | <gtk/gtk.h>"
		end

	gtk_spin_button_get_value_as_int (spinButton: POINTER): INTEGER is
 		external
			"C (GtkSpinButton *): EIF_INTEGER | <gtk/gtk.h>"
		end

	gtk_spin_button_set_value (spinButton: POINTER; value: INTEGER) is
 		external
			"C (GtkSpinButton *, gfloat) | <gtk/gtk.h>"
		end

	gtk_spin_button_get_adjustment (spinButton: POINTER): POINTER is
 		external
			"C (GtkSpinButton *): EIF_POINTER | <gtk/gtk.h>"
		end

	c_gtk_spin_button_step (spinButton: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_spin_button_minimum (spinButton: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_spin_button_maximum (spinButton: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_spin_button_entry (spinButton: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for gtk_range (EV_RANGE or EV_SCROLL_BAR)

	c_gtk_range_set_step (range: POINTER; step: REAL) is
 		external
			"C (GtkRange *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_minimum (range: POINTER; min: REAL) is
 		external
			"C (GtkRange *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_maximum (range: POINTER; max: REAL) is
 		external
			"C (GtkRange *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_leap (range: POINTER; leap: REAL) is
 		external
			"C (GtkRange *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_range_step (range: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_range_minimum (range: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_range_maximum (range: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_range_leap (range: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_range_adjustment (scroll: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for gtk_scale (EV_RANGE)

	c_gtk_vscale_new (value, min, max: REAL; step, leap: REAL): POINTER is
 		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | %"gtk_eiffel.h%""
		end

	c_gtk_hscale_new (value, min, max: REAL; step, leap: REAL): POINTER is
 		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | %"gtk_eiffel.h%""
		end

	gtk_scale_set_value_pos (scale: POINTER; value: INTEGER) is
 		external
			"C (GtkScale *, gfloat) | <gtk/gtk.h>"
		end

	gtk_scale_set_digits (scale: POINTER; value: INTEGER) is
 		external
			"C (GtkScale *, gint) | <gtk/gtk.h>"
		end

	c_gtk_scale_value (scale: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for gtk_scrollbar (EV_SCROL_BAR)

	c_gtk_vscrollbar_new (value, min, max: REAL; step, leap: REAL; page: REAL): POINTER is
 		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | %"gtk_eiffel.h%""
		end

	c_gtk_hscrollbar_new (value, min, max: REAL; step, leap: REAL; page: REAL): POINTER is
 		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat, gfloat): EIF_POINTER | %"gtk_eiffel.h%""
		end

	c_gtk_scrollbar_value (scroll: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_scrollbar_set_value (scroll: POINTER; value: INTEGER) is
 		external
			"C (GtkScrollbar *, gfloat) | %"gtk_eiffel.h%""
		end

	c_gtk_scrollbar_set_page_size (scroll: POINTER; value: INTEGER) is
 		external
			"C (GtkScrollbar *, gfloat) | %"gtk_eiffel.h%""
		end

feature {NONE} -- code in the glue library

	c_gtk_toolbar_append_item (t: POINTER; text, tip, private_tip,
							   icon: POINTER; func: POINTER;
							   object: ANY; p: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end
	
	-- message_d
--	c_gtk_create_message_d_buttons (dialog, ok_button,
--					cancel_button, 
--					help_button: POINTER) is
--		external "C | %"gtk_eiffel.h%""
--		end
	
--	c_gtk_create_message_d_label (dialog, label: POINTER) is
--		external "C | %"gtk_eiffel.h%""
--		end
	
	-- push_b
	c_gtk_get_label_widget (button: POINTER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
		end
	
	-- text
	c_gtk_get_text_length (text: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end
	
	-- text
	c_gtk_get_text_max_length (text: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end	

feature {NONE} -- GtkStyle functions

	c_gtk_style_default_bg_color (r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_style_default_fg_color (r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GtkWindow function

	c_gtk_window_set_modal (window: POINTER; state: BOOLEAN) is
		external
			"C | %"gtk_eiffel.h%""
		end

	gtk_window_set_modal (window: POINTER; state: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- Key Event function

	c_gtk_event_keys_state (p: POINTER): INTEGER is
		external 
			"C | %"gtk_eiffel.h%""
		end	

	c_gtk_widget_set_all_events (p: POINTER) is
		external 
			"C | %"gtk_eiffel.h%""
		end	
	
feature {NONE} -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end
end

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
