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

feature -- Access

	ev_children: LINKED_LIST [EV_MENU_ITEM_IMP]

	position: INTEGER
		-- Position of the item in the menu.

feature -- Element change

	set_position (pos: INTEGER) is
			-- Make `pos' the new position of the item.
		do
			position := pos
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	add_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		deferred
		end

	insert_item (wel_menu: WEL_MENU; pos: INTEGER; label: STRING) is
			-- Insert a new menu-item whixh is a menu into
			-- container.
		deferred
		end

	remove_item (an_id: INTEGER) is
			-- Remove the item with `id' as identification
		deferred
		end

--	remove_menu (menu: EV_MENU_IMP) is
			-- Remove `menu' from the container.
			-- In fact, the destroy fonction destroy the wel_item
			-- then here, we must only remove the menu and its
			-- item from `ev_children'.
--require
--	menu_exists: not menu.destroyed
--		do
			-- Pas forcement vrai tout ca, a faire.
--		end

	uncheck_radio_items is
			-- Uncheck all the radio-items of the container.
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
