indexing
	description: "EiffelVision menu-container, Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER_IMP

inherit
	EV_MENU_HOLDER_I

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

	children: ARRAYED_LIST [EV_MENU_IMP]
			-- Ids of the children of the menu
			-- We need them in memory because we cannot
			-- get them from the system

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The container that handles the items.
		do
			Result ?= parent_imp
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		local
			cc: ARRAYED_LIST [EV_MENU_IMP]
		do
			cc := children
			if not cc.empty then
				from
					cc.start
				until
					cc.empty
				loop
					remove_menu (cc.first)
				end
			end
			remove_children
		end

	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `a_menu' into container.
		local
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- First, we add the menu here.
			menu_container.append_popup (menu_imp, menu_imp.text)
			if children = Void then
				initialize_children
			end
			children.extend (menu_imp)

			-- Then we register the items in it.
			cc := menu_imp.children
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						item_handler.register_item (it)
					end
					cc.forth
				end
			end
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove menu_imp from the container.
		local
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- First, we remove the menu from here.
			menu_container.delete_position (internal_get_index (menu_imp))
			children.prune_all (menu_imp)

			-- Then, we unregister all the items in it.
			cc := menu_imp.children
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						item_handler.unregister_item (it)
					end
					cc.forth
				end
			end

			-- The, we chack if there are no more children.
			if children.empty then
				remove_children
			end
		end

feature -- Basic operation

	internal_get_index (menu_imp: EV_MENU_IMP): INTEGER is
			-- Return the index of `menu_imp' in the list.
		do
			Result := children.index_of (menu_imp, 1)
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature {EV_MENU_IMP} -- Implementation

	menu_container: WEL_MENU is
			-- Actual WEL container
		deferred
		end

	parent_imp: EV_CONTAINER_IMP is
			-- The window where the menu is.
		deferred
		end

end -- class EV_MENU_HOLDER_IMP

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
