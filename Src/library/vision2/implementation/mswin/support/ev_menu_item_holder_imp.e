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

	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- Access

	ev_children: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]

	position: INTEGER
		-- Position of the item in the menu.

	submenu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		deferred
		end

	-- A remplacer par parent_widget
	parent_container: EV_MENU_CONTAINER_IMP
			-- Top parent container of the menu.
			-- Used by EV_MENU_CONTAINER_IMP and
			-- EV_MENU_ITEM_CONTAINER_IMP

feature -- Element change

	set_parent_container (con: EV_MENU_CONTAINER_IMP) is
			-- Make `con' the new parent_container.
		do
			parent_container := con
		end

	set_position (pos: INTEGER) is
			-- Make `pos' the new position of the item.
		do
			position := pos
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	add_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		local
			item_imp: EV_MENU_ITEM_IMP
			iid: INTEGER
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			if not ev_children.empty then
				iid := ev_children.current_keys @ ev_children.count + 1
			else
				iid := 1
			end
			ev_children.extend (item_imp, iid)
			submenu.append_string (item_imp.text, ev_children.count)
			item_imp.set_id (iid)
			item_imp.set_position (submenu.count - 1)
			item_imp.set_parent_container (parent_container)
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
