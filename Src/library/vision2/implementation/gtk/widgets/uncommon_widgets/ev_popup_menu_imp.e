indexing
	description: 
		"EiffelVision popup menu. A popup menu can appear%
		 %anywhere in the window. It contains menus."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_MENU_IMP

inherit
	EV_POPUP_MENU_I
	EV_MENU_HOLDER_IMP

creation
	make
	
feature {NONE} -- Initialization
	
	make is         
			-- Create an empty popup menu with `par' as parent.
		do
		end	

feature -- Access

	parent: EV_CONTAINER is
			-- Parent of the popup.
		do
		end

feature -- Status setting

	show_at_position (x_coord, y_coord: INTEGER) is
			-- Show the popup menu at the given position
		do
		end

feature -- Element change
	
	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `menu_imp' in the container.
		do
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove `menu_imp' from the container.
		do
		end

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		do
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		do
		end

end -- class EV_POPUP_MENU_IMP

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
