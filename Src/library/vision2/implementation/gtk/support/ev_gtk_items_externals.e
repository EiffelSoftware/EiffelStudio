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

feature {NONE} -- GTK C functions for list items

	gtk_list_item_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_item_new_with_label (label_text: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_item_select (list_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_list_item_deselect (list_item: POINTER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library

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
