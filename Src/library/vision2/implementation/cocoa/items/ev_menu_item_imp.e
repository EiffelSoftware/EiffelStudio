indexing
	description: "Eiffel Vision menu item. Cocoa implementation."

class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			width,
			height
		end

	EV_SENSITIVE_IMP
		redefine
			interface,
			enable_sensitive,
			disable_sensitive
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			accelerators_enabled
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN = False

	make (an_interface: like interface)
			-- Create a menu.
		do
			base_make (an_interface)
			pixmapable_imp_initialize
			create {NS_MENU_ITEM}cocoa_item.new
		end

	initialize
			-- Initialize `Current'
		do
			menu_item.set_action (agent
				do
					select_actions.call ([])
				end)
			set_is_initialized (True)
		end

feature -- Status setting

	enable_sensitive
			-- Make the menu item avtive
		local
			pos: INTEGER
			a_menu: EV_MENU_IMP
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
			a_menu ?= parent_imp
			if a_menu /= Void then
				pos := a_menu.index_of (interface, 1)
			end
		end

	disable_sensitive
			-- Make the menu item grayed out and ignore commands
		local
			pos: INTEGER
			a_menu: EV_MENU_IMP
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
			a_menu ?= parent_imp
			if a_menu /= Void then
				pos := a_menu.index_of (interface, 1)
			end
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			l_text: STRING_32
			l_split_list: LIST [STRING_32]
			i: INTEGER
			a_menu_imp: EV_MENU_ITEM_LIST_IMP
		do
			l_text := a_text.as_string_32
			l_split_list :=  l_text.split ('%T')
			if l_split_list.count = 2 then
				Precursor {EV_TEXTABLE_IMP} (l_split_list @ 1)
				l_text := (l_split_list @ 1).as_string_32
				set_key_equivalent (l_split_list @ 2)
			else
				Precursor {EV_TEXTABLE_IMP} (a_text)
				l_text := a_text.as_string_32
			end

			-- Get rid of the & sign which denotes a shortcut key
			i := l_text.substring_index ("&", 1)
			if i /= 0 then
				l_text := l_text.substring (1, i - 1) + l_text.substring (i + 1, l_text.count)
			end

			menu_item.set_title (l_text)
			a_menu_imp ?= current
			if a_menu_imp /= void then
				a_menu_imp.menu.set_title (l_text)
			end
		end

	set_key_equivalent (a_text: STRING_32)
		local
			l_key_mask: INTEGER
			l_split_list: LIST [STRING_32]
		do
			l_split_list :=  a_text.split ('+')
			menu_item.set_key_equivalent (l_split_list.last.as_lower)
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ("Ctrl").is_equal(other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.control_key_mask)
			end
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ("Shift").is_equal(other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.shift_key_mask)
			end
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ("Alt").is_equal(other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.alternate_key_mask)
			end
			menu_item.set_key_equivalent_modifier_mask (l_key_mask)
		end

feature -- Measurement

	width, height: INTEGER

	minimum_width: INTEGER is 10

	minimum_height: INTEGER is 10

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		do
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	accelerators_enabled: BOOLEAN = True

	interface: EV_MENU_ITEM;

	menu_item: NS_MENU_ITEM
		do
			Result ?= cocoa_item
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_MENU_ITEM_IMP

