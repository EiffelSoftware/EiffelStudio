note
	description: "EiffelVision check menu. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create a menu.
		do
			create {NS_MENU_ITEM}cocoa_item.make
		end

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

feature {NONE} -- Implementation

	interface: detachable EV_CHECK_MENU_ITEM note option: stable attribute end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_CHECK_MENU_ITEM_IMP

