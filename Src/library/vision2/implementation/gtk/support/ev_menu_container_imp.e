indexing
	description:
		"EiffelVision menu container, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MENU_CONTAINER_IMP

inherit
	EV_MENU_CONTAINER_I
		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

	EV_WIDGET_IMP 

	EV_GTK_ITEMS_EXTERNALS

feature {EV_MENU_CONTAINER} -- Element change	
	
	add_menu (menu: EV_MENU) is
			-- Set menu for menu item
		deferred
		end

end -- class EV_MENU_CONTAINER_IMP


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
