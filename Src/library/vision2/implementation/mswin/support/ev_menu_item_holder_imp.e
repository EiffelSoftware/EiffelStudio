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
		export {EV_MENU_ITEM_IMP}
			set_name
		redefine
			children
		end

	WEL_MENU

feature {EV_MENU_IMP} -- Status report

	children: LINKED_LIST [EV_MENU_ITEM_IMP]

feature -- Event -- command association

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
		do
			if children.i_th(menu_id).command /= Void then
				children.i_th(menu_id).command.execute (children.i_th(menu_id).arguments)
			end
		end

feature -- Implementation

	add_menu_item (an_item: EV_MENU_ITEM) is
			-- Add menu item into container
		local
			item_imp: EV_MENU_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			children.extend (item_imp)
			append_string (name_item, children.count)
			item_imp.set_id (children.count)
		end

	add_menu (menu: EV_MENU) is
			-- Add a menu into container.
			-- The menu is then a submenu.
		local
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= menu.implementation
			check
				menu_imp /= Void
			end
			append_popup (menu_imp, menu_imp.text)
		end

	remove_item (id: INTEGER) is
			-- Remove the item with `id' as identification
		do
			delete_item (id)
			children.go_i_th (id)
			children.remove
			from
			until
				children.after
			loop
				children.item.set_id (children.index)
				children.forth
			end
		end

	remove_menu (menu: EV_MENU_IMP) is
			-- Remove `menu' from the container.
			-- In fact, the destroy fonction destroy the wel_item
			-- then here, we must only remove the menu and its
			-- item from `children'.
--require
--	menu_exists: not menu.destroyed
		do
			-- Pas forcement vrai tout ca, a faire.
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
