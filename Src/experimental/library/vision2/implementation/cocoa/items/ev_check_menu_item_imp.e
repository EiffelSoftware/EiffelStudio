note
	description: "EiffelVision check menu. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface
		end

create
	make

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
			is_selected := True
			menu_item.set_state ({NS_CELL}.on_state)
		end

	disable_select
			-- Deselect this menu item.
		do
			is_selected := False
			menu_item.set_state ({NS_CELL}.off_state)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CHECK_MENU_ITEM note option: stable attribute end

end -- class EV_CHECK_MENU_ITEM_IMP
