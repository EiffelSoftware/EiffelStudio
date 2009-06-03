note
	description: "Eiffel Vision menu. Cocoa implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP

inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent
		redefine
			make,
			interface,
			initialize,
			destroy,
			show,
			menu_item
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface,
			initialize,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			--
		do
			base_make (an_interface)
			create menu_item.make
			create menu.make
			menu_item.set_submenu (menu)
		end

	initialize
		do
			Precursor {EV_MENU_ITEM_LIST_IMP}
			Precursor {EV_MENU_ITEM_IMP}
		end

feature -- Basic operations

	show
			-- Pop up on the current pointer position.
		do
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU

	menu: NS_MENU

	menu_item: NS_MENU_ITEM

feature {NONE} -- Implementation

	destroy
			-- Destroy the menu
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_MENU_ITEM_LIST_IMP}
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MENU_IMP

