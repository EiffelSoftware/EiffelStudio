indexing
	description: "EiffelVision menu item container. %
				% Ms windows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_HOLDER_IMP

inherit
	EV_MENU_ITEM_HOLDER_I

	EV_ITEM_HOLDER_IMP

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

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature {EV_MENU_ITEM_I} -- Implementation

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

	insert_item (item_imp: EV_MENU_ITEM_IMP; value: INTEGER) is
			-- Insert `item_imp' at the position `value'
		local
			iid: INTEGER
		do
			-- First, we set the id of the item to the next available
			-- value.
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

	move_item (item_imp: EV_MENU_ITEM_IMP; value: INTEGER) is
			-- Move `item_imp' to the position `value'
		do
			submenu.delete_item (item_imp.id)
			ev_children.remove (item_imp.id)
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the menu,
		do
			submenu.delete_item (item_imp.id)
			ev_children.remove (item_imp.id)
		end

	insert_menu (wel_menu: WEL_MENU; pos: INTEGER; label: STRING) is
			-- Insert a new menu-item which is a menu into
			-- container.
		do
			submenu.insert_popup (wel_menu, pos, label)
		end

end -- class EV_MENU_ITEM_HOLDER_IMP

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
