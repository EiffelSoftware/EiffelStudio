indexing
	description:
		"EiffelVision option button, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_OPTION_BUTTON_IMP

inherit
	EV_OPTION_BUTTON_I

	EV_MENU_CONTAINER_IMP

	EV_BUTTON_IMP
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as parent.
			-- We can't use `widget_make' here, because a menu
			-- is not a child, otherwise, you couldn't put more
			-- than a menu in a window. A menu is an option of a
			-- window
		do
			widget := gtk_option_menu_new ()
			show
		end	

feature {EV_MENU_ITEM_CONTAINER} -- Element change	
	
	add_menu (menu: EV_MENU) is
			-- Set menu for menu item
		local
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= menu.implementation
			check
				correct_imp: menu_imp /= void
			end
			gtk_option_menu_set_menu (widget, menu_imp.widget)
		end
	
end -- class EV_OPTION_BUTTON_IMP

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
