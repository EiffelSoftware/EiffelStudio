indexing
	description:
		"EiffelVision menu container, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER_IMP

inherit
	EV_MENU_HOLDER_I
		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

	EV_CONTAINER_IMP

	EV_GTK_ITEMS_EXTERNALS

feature -- Access
 
 	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
 			-- List of the children.

feature -- Element change	
	
	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `menu_imp' in the container.
		deferred
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove `menu_imp' from the container.
		deferred
		end

end -- class EV_MENU_HOLDER_IMP


 --|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
