indexing	
	description: 
		"EiffelVision radio menu item. Implementatino interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I

	EV_CHECK_MENU_ITEM_IMP
		redefine
			set_selected,
			on_activate,
			destroy
		end

	EV_RADIO_IMP [EV_RADIO_MENU_ITEM]

creation
	make

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			group.remove_item (Current)
			parent_imp.remove_item (Current)
		end

	set_selected (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			{EV_CHECK_MENU_ITEM_IMP} Precursor (flag)
			if group /= Void then
				group.set_selection_at_no_event (Current)
			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activate.
		do
			if group /= Void then
				group.set_selection_at (Current)
			end
			set_selected (True)
			execute_command (Cmd_item_activate, Void)
		end

	on_unselect is
			-- Is called when the item is unselected.
		do
			execute_command (Cmd_item_deactivate, Void)
		end

end -- class EV_RADIO_MENU_ITEM_IMP

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
