indexing

	description: 
		"EiffelVision menu item container. Abstract class and a common ancestor classes that can contain menu items."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_MENU_ITEM_CONTAINER

feature -- Element change

	add_menu (an_item: EV_MENU) is
			-- Add a sub-menu in the container.
		do
			implementation.add_menu (an_item)
		end

	add_menu_item (an_item: EV_MENU_ITEM) is
			-- Add an item in the container.
		do
			implementation.add_menu_item (an_item)
		end

feature -- Implementation

	implementation: EV_MENU_ITEM_CONTAINER_I
			
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
--|----------------------------------------------------------------
