indexing
	description: "External C functions for accessing gtk.%
		% Those are used by items.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_ITEMS_EXTERNALS


feature {NONE} -- GTK C functions for general items


feature {NONE} -- GTK C functions for menu items

	gtk_menu_item_new: POINTER is
		external
			"C (): EIF_POINTER | <gtk/gtk.h>"
		end
	
	gtk_menu_item_new_with_label (label_text: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_menu_item_set_submenu (menu_item: POINTER; submenu: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end	

	c_gtk_menu_item_submenu (menu_item: POINTER): POINTER is
		external
			"C [macro <gtk_eiffel.h>]"
		end

	gtk_check_menu_item_new: POINTER is
		external
			"C (): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_check_menu_item_new_with_label (label_text: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_set_active (check_menu_item: POINTER; state: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_set_show_toggle (check_menu_item: POINTER; always: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_toggled (check_menu_item: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_check_menu_item_active (check_menu_item: POINTER): BOOLEAN is
		external
			"C [macro <gtk_eiffel.h>]"
		end

	gtk_radio_menu_item_new (group: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_new_with_label (group: POINTER; label_text: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_group (radio_menu_item: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_set_group (radio_menu_item: POINTER; group: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for list items

	gtk_list_item_new: POINTER is
		external
			"C (): EIF_POINTER | <gtk/gtk.h>"
		end

	gtk_list_item_new_with_label (label_text: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_list_item_select (list_item: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_unselect (list_item: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_is_selected (list: POINTER; item: POINTER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for multi-columns rows

	c_gtk_clist_set_pixtext (list: POINTER; row, column: INTEGER; pixmap: POINTER; text: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_unset_pixmap (list: POINTER; row, column: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	gtk_clist_get_text (list: POINTER; row, column: INTEGER; text: POINTER): INTEGER is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_clist_set_fg_color (list: POINTER; row: INTEGER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_get_fg_color (list: POINTER; row: INTEGER; r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_set_bg_color (list: POINTER; row: INTEGER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_get_bg_color (list: POINTER; row: INTEGER; r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	gtk_clist_select_row (list: POINTER; row, column: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_unselect_row (list: POINTER; row, column: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_clist_row_move (list: POINTER; source_row, dest_row: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C function for tree items

--	gtk_tree_item_new: POINTER is
--		external "C | <gtk/gtk.h>"
--		end

--	gtk_tree_item_new_with_label (label: POINTER): POINTER is
--		external "C | <gtk/gtk.h>"
--		end

--	gtk_tree_item_subtree (widget: POINTER): POINTER is
--		external
--			"C [macro <gtk/gtk.h>]: EIF_POINTER"
--		alias
--			"GTK_TREE_ITEM_SUBTREE"
--		end

--	gtk_tree_item_set_subtree (item: POINTER; subtree: POINTER) is
--		external "C | <gtk/gtk.h>"
--		end

--	gtk_tree_item_select (treeItem: POINTER) is
--		external "C | <gtk/gtk.h>"
--		end

--	gtk_tree_item_deselect (treeItem: POINTER) is
--		external "C | <gtk/gtk.h>"
--		end

--	gtk_tree_insert (tree: POINTER; treeItem: POINTER; value: INTEGER ) is
--		external "C (GtkTree *, GtkWidget *, gint) | <gtk/gtk.h>"
--		end

--	gtk_tree_child_position (tree: POINTER; treeItem: POINTER): INTEGER is
--		external "C (GtkTree *, GtkWidget *): EIF_INTEGER | <gtk/gtk.h>"
--		end

--	gtk_tree_item_expand (treeItem: POINTER) is
--		external "C (GtkTreeItem *) | <gtk/gtk.h>"
--		end

--	gtk_tree_item_collapse (treeItem: POINTER) is
--		external "C (GtkTreeItem *) | <gtk/gtk.h>"
--		end

--	c_gtk_tree_item_is_selected (tree: POINTER; treeItem: POINTER): BOOLEAN is
--		external "C | %"gtk_eiffel.h%""
--		end

--	c_gtk_tree_item_expanded (treeItem: POINTER): BOOLEAN is
--		external "C (GtkTreeItem *): EIF_BOOLEAN | %"gtk_eiffel.h%""
--		end

feature {NONE} -- GTK C function for ctree items

	gtk_ctree_select (ctree: POINTER; ctreeNode: POINTER) is
		external
			"C (GtkCTree *, GtkCTreeNode *) | <gtk/gtk.h>"
		end

	gtk_ctree_unselect (ctree: POINTER; ctreeNode: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_ctree_move (ctree, ctreeNode, new_parent, new_sibling: POINTER) is
		external
			"C (GtkCTree *, GtkCTreeNode *, GtkCTreeNode *, GtkCTreeNode *) | <gtk/gtk.h>"
		end

	gtk_ctree_expand (ctree: POINTER; ctreeNode: POINTER) is
		external
			"C (GtkCTree *, GtkCTreeNode *) | <gtk/gtk.h>"
		end

	gtk_ctree_collapse (ctree: POINTER; ctreeNode: POINTER) is
		external
			"C (GtkCTree *, GtkCTreeNode *) | <gtk/gtk.h>"
		end

--	c_gtk_tree_item_is_selected (tree: POINTER; treeItem: POINTER): BOOLEAN is
--		external "C | %"gtk_eiffel.h%""
--		end

	c_gtk_ctree_item_is_expanded (node: POINTER): BOOLEAN is
		external
			"C (GtkCTreeNode *): EIF_BOOLEAN | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_item_set_pixtext (ctree, node: POINTER; column: INTEGER; pixmap: POINTER; txt: POINTER; spacing: INTEGER) is
		external
			"C (GtkCTree *, GtkCTreeNode *, gint, GtkPixmap *, gchar *, guint8) | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_item_get_position_in_tree (ctree, node: POINTER): INTEGER is
		external
			"C (GtkCTree *, GtkCTreeNode *): INTEGER | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C function for status bar items

	c_gtk_statusbar_item_create_pixmap_place (statusbar: POINTER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_unset_pixmap (statusbar: POINTER; pixmap: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_set_bg_color (statusbar: POINTER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_label (statusbar: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_statusbar_item_frame (statusbar: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

end -- class EV_GTK_ITEMS_EXTERNALS

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
