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
			ev_children
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

	WEL_MENU
		rename
			make as wel_make
		end

feature {EV_MENU_IMP} -- Status report

	ev_children: LINKED_LIST [EV_MENU_ITEM_IMP]

feature -- Event -- command association

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
		do
			ev_children.i_th(menu_id).on_activate
		end

feature -- Implementation

	add_menu (an_item: EV_MENU) is
			-- Add a sub-menu `an_item' into container.
		local
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= an_item.implementation
			check
				menu_imp /= Void
			end
			append_popup (menu_imp, menu_imp.text)
		end

	add_menu_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		local
			item_imp: EV_MENU_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			ev_children.extend (item_imp)
			append_string (name_item, ev_children.count)
			item_imp.set_id (ev_children.count)
		end

	remove_item (id: INTEGER) is
			-- Remove the item with `id' as identification
		do
			delete_item (id)
			ev_children.go_i_th (id)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index)
				ev_children.forth
			end
		end

	remove_menu (menu: EV_MENU_IMP) is
			-- Remove `menu' from the container.
			-- In fact, the destroy fonction destroy the wel_item
			-- then here, we must only remove the menu and its
			-- item from `ev_children'.
--require
--	menu_exists: not menu.destroyed
		do
			-- Pas forcement vrai tout ca, a faire.
		end

	uncheck_radio_items is
			-- Uncheck all the radio-items of the container.
		local
			item_test: EV_RADIO_MENU_ITEM_IMP
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_test ?= ev_children.item
				if item_test /= Void then
					item_test.set_state (false)
				end
				ev_children.forth
			end
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
