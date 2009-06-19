note
	description: "Eiffel Vision menu. Cocoa implementation."
	author:	"Daniel Furrer"
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
			show,
			menu_item
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create menu_item.make
			create menu.make
			menu_item.set_submenu (menu)
			Precursor {EV_MENU_ITEM_IMP}
			initialize_item_list
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

	interface: detachable EV_MENU note option: stable attribute end;

	menu: NS_MENU

	menu_item: NS_MENU_ITEM

end -- class EV_MENU_IMP
