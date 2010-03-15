note
	description: "Eiffel Vision radio menu item. Cocoa implementation."
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
			interface
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization


feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
			is_selected := True
		end

feature {EV_ANY_I} -- Implementation

	disable_select
			-- Used to deselect is without firing actions.
		do
			is_selected := False
		end

	ignore_select_actions: BOOLEAN
		-- Should select_actions be called.

	set_radio_group (a_gslist: POINTER)
			-- Make current a member of `a_gslist' radio group.
		do
		end

	radio_group: LINKED_LIST [like current]
			-- List of all radio item implementations
		do
		end

	interface: EV_RADIO_MENU_ITEM;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_RADIO_MENU_ITEM_IMP

