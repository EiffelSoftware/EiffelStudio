note
	description: "Eiffel Vision radio menu item. Cocoa implementation."
	author:	"Copyright (c) 2009, Daniel Furrer"
	-- Note: Cocoa does not support radio-buttons in menus. Use check-buttons and emulate the behaviour.

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface,
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			make,
			enable_select,
			disable_select
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_RADIO_PEER_IMP}
			menu_item.set_state ({NS_CELL}.on_state)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?
		do
			Result := menu_item.state = {NS_CELL}.on_state
		end

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
			Precursor
			menu_item.set_state ({NS_CELL}.on_state)
		end

feature {EV_ANY_I} -- Implementation

	disable_select
			-- Used to deselect is without firing actions.
		do
			Precursor
			menu_item.set_state ({NS_CELL}.off_state)
		end

	interface: detachable EV_RADIO_MENU_ITEM note option: stable attribute end;

end -- class EV_RADIO_MENU_ITEM_IMP