indexing
	description:
		" EiffelVision menu item container, mswindows implementation"
	note: " Menu-items have even ids and tool-bar buttons have%
		% odd ids because both use the on_wm_command."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_HOLDER_IMP

inherit
	EV_MENU_ITEM_HOLDER_I

	EV_HASH_TABLE_ITEM_HOLDER_IMP
		redefine
			add_item
		end

feature {NONE} -- Initialization

	initialize_children is
			-- Create the children list.
		do
			create children.make (1)
		end

	remove_children is
			-- Remove the children list.
		do
			children := Void
		end

feature -- Access

	children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- Ids of the children of the menu
			-- We need them in memory because we cannot
			-- get them from the system

	menu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		deferred
		end

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The handler of the item.
		deferred
		end

feature -- Element change

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		local
			iid: INTEGER
			c: ARRAYED_LIST [EV_MENU_ITEM_IMP]
		do
			-- We set the item in the list and set it a position
			if children = Void then
				initialize_children
			end
			children.extend (item_imp)
			menu.append_string (item_imp.text, item_imp.new_id)

			-- Then, we add it in the top menu if there is one.
			if item_handler /= Void then
				item_handler.register_item (item_imp)
			end
		end

	insert_item (item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' at the position `pos'
		do
			-- We set the item in the list and set it a position
			children.go_i_th (pos)
			children.put_left (item_imp)
			menu.insert_string (item_imp.text, pos - 1, item_imp.new_id)

			-- Then, we add it in the top menu if there is one.
			if item_handler /= Void then
				item_handler.register_item (item_imp)
			end
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the menu,
		do
			-- First, we remove it from the children.
			children.prune_all (item_imp)
			menu.delete_item (item_imp.id)
			if children.empty then
				remove_children
			end

			-- Then, we remove it from the top menu if there is one.
			if item_handler /= Void then
				item_handler.unregister_item (item_imp)
			end
		end

	clear_items is
			-- Clear all the items of the list.
		local
			cc: ARRAYED_LIST [EV_MENU_ITEM_IMP]
		do
			cc := children
			if not cc.empty then
				from
					cc.start
				until
					cc.empty
				loop
					remove_item (cc.first)
				end
			end
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature -- Basic operation

	internal_get_index (item_imp: EV_MENU_ITEM_IMP): INTEGER is
			-- Return the index of `item' in the list.
		do
			Result := children.index_of (item_imp, 1)
		end

	internal_get_id (item_imp: EV_MENU_ITEM_IMP): INTEGER is
			-- Return the `id' of the given item.
		do
			Result := menu.position_to_item_id (internal_get_index (item_imp) - 1)
		end

	internal_insensitive (item_imp: EV_MENU_ITEM_IMP): BOOLEAN is
			-- Is `item' enabled.
		do
			Result := not menu.position_enabled (internal_get_index (item_imp) - 1)
		end

	internal_set_insensitive (item_imp: EV_MENU_ITEM_IMP; flag: BOOLEAN) is
   			-- Set `item' in insensitive mode if `flag', in
			-- sensitive mode otherwise.
		do
			if flag then
				menu.disable_position (internal_get_index (item_imp) - 1)
			else
				menu.enable_position (internal_get_index (item_imp) - 1)
			end
		end

	internal_selected (item_imp: EV_MENU_ITEM_IMP): BOOLEAN is
			-- Is `item' selected?
		do
			Result := menu.item_checked (internal_get_id (item_imp))
		end

	internal_set_selected (item_imp: EV_MENU_ITEM_IMP; flag: BOOLEAN) is
   			-- Select `item' if `flag', unselect it otherwise.
		do
			if flag then
				menu.check_item (internal_get_id (item_imp))
			else
				menu.uncheck_item (internal_get_id (item_imp))
			end
		end

	internal_insert_menu (item_imp: EV_MENU_ITEM_IMP) is
			-- Graphical insert of a sub-menu.
			-- container.
		do
			menu.insert_popup (item_imp.menu, item_imp.index, item_imp.text)
		end

	internal_insert_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Graphical insert of a menu item.
		do
			menu.insert_string (item_imp.text, item_imp.index, item_imp.id)
		end

	internal_delete_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Graphically delete an item. Keep it in the list.
		do
			menu.delete_position (internal_get_index (item_imp) - 1)
		end

feature {NONE} -- Implementation

	item_type: EV_MENU_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
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
