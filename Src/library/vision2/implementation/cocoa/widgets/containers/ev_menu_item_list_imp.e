indexing
	description: "Eiffel Vision menu item list. Cocoa implementation."

deferred class
	EV_MENU_ITEM_LIST_IMP

inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM, EV_MENU_ITEM_IMP]
		redefine
			interface,
			insert_i_th,
			remove_i_th
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert the item v in the current menu
		local
			v_imp: EV_MENU_ITEM_IMP
		do
			Precursor {EV_ITEM_LIST_IMP} (v, i)
			v_imp ?= v.implementation
			menu.insert_item_at_index (v_imp.menu_item, i - 1)
		end

	remove_i_th (i: INTEGER)
			-- Insert the item v in the current menu
		local
			v_imp: EV_MENU_ITEM_IMP
		do
			v_imp ?= i_th(i).implementation
			Precursor {EV_ITEM_LIST_IMP} (i)
			menu.remove_item_at_index (i - 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST;

	menu: NS_MENU
		deferred
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MENU_ITEM_LIST_IMP

