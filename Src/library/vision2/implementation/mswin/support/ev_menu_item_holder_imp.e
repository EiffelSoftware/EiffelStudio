indexing
	description: "EiffelVision menu item container. %
				% Ms windows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_CONTAINER_IMP

inherit
	EV_MENU_ITEM_CONTAINER_I

	EV_ITEM_CONTAINER_IMP

feature -- Access

	ev_children: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]

	position: INTEGER
		-- Position of the item in the menu.

	submenu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		deferred
		end

feature -- Element change

	set_position (pos: INTEGER) is
			-- Make `pos' the new position of the item.
		do
			position := pos
		end

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		local
			iid: INTEGER
		do
			if not ev_children.empty then
				iid := ev_children.current_keys @ ev_children.count + 1
			else
				iid := 1
			end
			ev_children.force (item_imp, iid)
			submenu.append_string (item_imp.text, ev_children.count)
			item_imp.set_id (iid)
			item_imp.set_position (submenu.count - 1)
		end

	insert_item (wel_menu: WEL_MENU; pos: INTEGER; label: STRING) is
			-- Insert a new menu-item which is a menu into
			-- container.
		do
			submenu.insert_popup (wel_menu, pos, label)
		end

	remove_item (an_id: INTEGER) is
			-- Remove the item with `id' as identification
		do
			submenu.delete_item (an_id)
			ev_children.remove (an_id)
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

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
