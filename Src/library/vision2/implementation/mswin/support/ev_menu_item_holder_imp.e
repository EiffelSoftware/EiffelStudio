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

	WEL_MENU

feature -- Initialization

	initialize is
			-- Initilize all the parameters of the container.
		do
			!! children.make
		end


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
				item_imp /= Void
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

feature -- Implementation

	name_item: STRING

	set_name (new_name: STRING) is
			-- Set `name_item' to `new_name'. This string corresponds
			-- to the name of the item that will be added next.
			-- This feature avoid to have a name feature on each
			-- menu item.
		require
			new_name /= Void
		do
			name_item := new_name
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
