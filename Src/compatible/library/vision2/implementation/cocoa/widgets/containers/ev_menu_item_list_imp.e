note
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
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Implementation

	insert_item (item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Insert `item_imp' on `pos' in `ev_children'.
		do
			menu.insert_item_at_index (item_imp.menu_item, pos - 1)
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP)
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
		do
			pos := ev_children.index_of (item_imp, 1)
			menu.remove_item_at_index (pos - 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST;

	menu: NS_MENU
		deferred
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MENU_ITEM_LIST_IMP

