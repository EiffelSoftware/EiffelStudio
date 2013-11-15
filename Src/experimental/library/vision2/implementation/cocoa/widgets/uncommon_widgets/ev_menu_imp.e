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
			create menu.make
			initialize_item_list
			Precursor {EV_MENU_ITEM_IMP}
			menu_item.set_submenu (menu)
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

	menu: NS_MENU

	menu_item: NS_MENU_ITEM

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_MENU_IMP
