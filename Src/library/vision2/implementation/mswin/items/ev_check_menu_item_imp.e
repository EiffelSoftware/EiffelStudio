indexing	
	description: 
		"EiffelVision check menu item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I

	EV_MENU_ITEM_IMP
		redefine
			on_activate
		end
	
creation
	make,
	make_with_text

feature -- Status report
	
	state: BOOLEAN is
			-- Is current menu-item checked ?
		do
			Result := parent_menu.item_checked (id)	
		end
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			if flag then
				parent_menu.check_item (id)
			else
				parent_menu.uncheck_item (id)
			end
		end

	toggle is
			-- Change the state of the menu-item to
			-- opposite
		do
			set_state (not state)
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when th item is activate.
		do
			toggle
			execute_command (Cmd_item_activate, Void)
		end

end -- class EV_CHECK_MENU_ITEM_IMP

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
