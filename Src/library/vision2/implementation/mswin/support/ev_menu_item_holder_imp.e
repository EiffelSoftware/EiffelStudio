--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine
			interface
		end

	EV_HASH_TABLE_ITEM_HOLDER_IMP [EV_MENU_ITEM]
		undefine
			item_by_data
		redefine
			interface,
			ev_children
		end
		
feature {NONE} -- Initialization

	initialize_children is
			-- Create the children list.
		do
			create ev_children.make (0)
		end

	remove_children is
			-- Remove the children list.
		do
			ev_children := Void
		end

feature -- Access

	ev_children: ARRAYED_LIST [EV_ITEM_IMP]
			-- List of EV_ITEM_IMP because of the separator
			-- Children of the menu in graphical order.
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

	remove_all_items is
			-- Remove `children' without destroying them.
		local
			temp_children: ARRAYED_LIST [EV_ITEM_IMP]
		do
			from
				temp_children := ev_children
				temp_children.finish
			until
				temp_children.before
			loop
				temp_children.item.set_parent (Void)
				temp_children.back
			end
		end


	--|FIXME this should be redundent, can use extend
	--add_item (item_imp: EV_MENU_ITEM_IMP) is
	--		-- Add `item_imp' into container.
	--	local
	--		iid: INTEGER
	--		c: ARRAYED_LIST [EV_ITEM_IMP]
	--		handler: EV_MENU_ITEM_HANDLER_IMP
	--	do
	--		-- We set the item in the list and set it a position
	--		if ev_children = Void then
	--			initialize_children
	--		end
	--		ev_children.extend (item_imp)
	--		menu.append_string (item_imp.text, item_imp.new_id)
	--
	--		-- Then, we add it in the top menu if there is one
	--		-- And we adapt the display
	--		handler := item_handler
	--		if handler /= Void then
	--			handler.register_item (item_imp)
	--			handler.update_menu
	--		end
	--	end

	insert_item (item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' at the position `pos'
		local
			handler: EV_MENU_ITEM_HANDLER_IMP
		do
			-- We set the item in the list and set it a position
			ev_children.go_i_th (pos)
			ev_children.put_left (item_imp)
			menu.insert_string (item_imp.text, pos - 1, item_imp.new_id)

			-- Then, we add it in the top menu if there is one.
			handler := item_handler
			if handler /= Void then
				handler.register_item (item_imp)
				handler.update_menu
			end
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the menu,
		local
			handler: EV_MENU_ITEM_HANDLER_IMP
		do
			-- First, we need to unregister the item from them
			-- general hash-table.
			handler := item_handler
			if handler /= Void then
				handler.unregister_item (item_imp)
				handler.update_menu
			end

			-- Then, we remove it from the children and the menu.
			menu.delete_position (internal_get_index (item_imp) - 1)
			ev_children.prune_all (item_imp)
			if ev_children.empty then
				remove_children
			end
		end

	add_separator (sep_imp: EV_MENU_SEPARATOR_IMP) is
			-- Add `sep_imp' at the end of the menu.
		do
			insert_separator (sep_imp, count + 1)
		end

	insert_separator (sep_imp: EV_MENU_SEPARATOR_IMP; pos: INTEGER) is
			-- Insert `sep_imp' at the position `pos' in the menu.
		do
			-- We insert the separator only in its parent because
			-- no event can be linl to it.
			ev_children.go_i_th (pos)
			ev_children.put_left (sep_imp)
			menu.insert_separator (pos - 1)

			if item_handler /= Void then
				item_handler.update_menu
			end
		end

	remove_separator (sep_imp: EV_MENU_SEPARATOR_IMP) is
			-- Remove `sep_imp' from the menu.
		do
			-- First, we remove it from the children.
			menu.delete_position (internal_get_index (sep_imp) - 1)
			ev_children.prune_all (sep_imp)
			if ev_children.empty then
				remove_children
			end

			if item_handler /= Void then
				item_handler.update_menu
			end
		end

	move_separator (sep_imp: EV_MENU_SEPARATOR_IMP; an_index: INTEGER) is
			-- Move `sep_imp' to the `an_index' position.
		do
			remove_separator (sep_imp)
			insert_separator (sep_imp, an_index)
		end

	clear_items is
			-- Clear all the items of the list.
		local
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
			sep: EV_MENU_SEPARATOR_IMP
		do
			cc := ev_children
			if not cc.empty then
				from
					cc.start
				until
					cc.empty
				loop
					it ?= cc.first
					if it = Void then
						sep ?= cc.first
						remove_separator (sep)
						sep.interface.destroy
					else
						remove_item (it)
						it.interface.destroy
					end
				end
			end
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature -- Basic operation

	internal_get_index (item_imp: EV_ITEM_IMP): INTEGER is
			-- Return the index of `item' in the list.
			-- Used by the separator also.
		do
			Result := ev_children.index_of (item_imp, 1)
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
			--| FIXME menu.insert_popup (item_imp.menu, item_imp.index - 1, item_imp.text)
		end

	internal_insert_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Graphical insert of a menu item.
		do
			--| FIXME menu.insert_string (item_imp.text, item_imp.index, item_imp.id)
		end

	internal_delete_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Graphically delete an item. Keep it in the list.
		do
			--| FIXME menu.delete_position (internal_get_index (item_imp) - 1)
		end

feature {NONE} -- Implementation

	item_type: EV_MENU_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

feature {EV_ANY_I}

	interface: EV_MENU_ITEM_HOLDER

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.6.6  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.21.6.5  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.21.6.4  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.6.3  1999/12/17 21:35:36  rogers
--| redefined implementation to be a a more refined type.
--|
--| Revision 1.21.6.2  1999/12/17 16:59:51  rogers
--| Altered to fit in with the review branch. ev_children replaces children for consistency with other classes.
--|
--| Revision 1.21.6.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
