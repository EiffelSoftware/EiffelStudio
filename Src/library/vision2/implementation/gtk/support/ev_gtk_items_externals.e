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
		external "C | <gtk/gtk.h>"
		end
	
	gtk_menu_item_new_with_label (label_text: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_menu_item_set_submenu (menu_item: POINTER; submenu: POINTER) is
		external "C | <gtk/gtk.h>"
		end	

	c_gtk_menu_item_submenu (menu_item: POINTER): POINTER is
		external "C [macro <gtk_eiffel.h>]"
		end

	gtk_check_menu_item_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_new_with_label (label_text: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_set_active (check_menu_item: POINTER; state: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_set_show_toggle (check_menu_item: POINTER; always: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_menu_item_toggled (check_menu_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_check_menu_item_active (check_menu_item: POINTER): BOOLEAN is
		external "C [macro <gtk_eiffel.h>]"
		end

	gtk_radio_menu_item_new (group: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_new_with_label (group: POINTER; label_text: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_group (radio_menu_item: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_menu_item_set_group (radio_menu_item: POINTER; group: POINTER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for list items

	gtk_list_item_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_item_new_with_label (label_text: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_list_item_select (list_item: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_unselect (list_item: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for multi-columns rows

	gtk_clist_set_text (list: POINTER; row, column: INTEGER; text: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_clist_set_foreground (list: POINTER; row: INTEGER; color: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_clist_set_background (list: POINTER; row: INTEGER; color: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_clist_select_row (list: POINTER; row, column: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_clist_unselect_row (list: POINTER; row, column: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C function for tree items

	gtk_tree_item_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_subtree (widget: POINTER): POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_TREE_ITEM_SUBTREE"
		end

	gtk_tree_item_set_subtree (item: POINTER; subtree: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_select (item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_deselect (item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_expand (item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tree_item_collapse (item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_tree_item_expanded (item: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_ITEMS_EXTERNALS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------
