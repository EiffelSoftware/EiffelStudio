indexing
	description: "Eiffel Vision radio menu item. Carbon implementation."
	-- Note: Carbon does not support radio-buttons in menus. Use check-buttons and emulate the behaviour.

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

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
		end

feature {EV_ANY_I} -- Implementation

	disable_select is
			-- Used to deselect is without firing actions.
		do
		end

	ignore_select_actions: BOOLEAN
		-- Should select_actions be called.

	set_radio_group (a_gslist: POINTER) is
			-- Make current a member of `a_gslist' radio group.
		do
		end

		radio_group: LINKED_LIST [like current] is
			-- List of all radio item implementations
		do
		end


	interface: EV_RADIO_MENU_ITEM;

indexing
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"

end -- class EV_RADIO_MENU_ITEM_IMP

