indexing
	description: 
		"EiffelVision invisible container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_CONTAINER_IMP
	
inherit
	EV_MENU_ITEM_CONTAINER_I

		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

	EV_WIDGET_IMP 

	EV_GTK_ITEMS_EXTERNALS
	
feature {EV_MENU_ITEM_CONTAINER} -- Element change	
	
	add_item (child: EV_MENU_ITEM) is
			-- Add menu item into container
--		local
--			item_imp: EV_MENU_ITEM_IMP
		deferred
--			item_imp ?= child.implementation
--			check
--				correct_imp: item_imp /= Void
--			end
--			add_menu_item_pointer (item_imp.widget)
--			gtk_widget_show (item_imp.widget)
		end			
	
--	add_menu (menu: EV_MENU) is
--			-- Set menu for menu item
--		local
--			item: POINTER
--			menu_imp: EV_MENU_IMP
--			a: ANY
--		do
--			menu_imp ?= menu.implementation
--			check
--				correct_imp: menu_imp /= void
--			end
--			a ?= menu_imp.name.to_c
--			item := gtk_menu_item_new_with_label ($a)
--			add_menu_item_pointer (item)
--			gtk_widget_show (item)
--			gtk_menu_item_set_submenu ( gtk_menu_item (item), 
--						    menu_imp.widget )
--		end
	
--feature {NONE} -- Implementation	

--	add_menu_item_pointer (item_p: POINTER) is
--		deferred
--		end


end -- class EV_MENU_ITEM_CONTAINER_IMP

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
