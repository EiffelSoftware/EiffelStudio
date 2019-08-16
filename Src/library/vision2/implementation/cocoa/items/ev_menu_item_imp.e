note
	description: "Eiffel Vision menu item. Cocoa implementation."
	author:	"Daniel Furrer"
	revised_by: "Alexander Kogtenkov"

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
			set_pixmap
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

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN = False

	make
			-- Initialize `Current'
		do
			pixmapable_imp_initialize
			create menu_item.make
			menu_item.set_action (agent
				do
					select_actions.call ([])
				end)
			set_is_initialized (True)
		end

feature -- Status setting

	enable_sensitive
			-- Make the menu item avtive
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
--			if attached {EV_MENU_IMP} parent_imp as a_menu then
--				pos := a_menu.index_of (interface, 1)
--			end
			Precursor {EV_SENSITIVE_IMP}
		end

	disable_sensitive
			-- Make the menu item grayed out and ignore commands
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
--			if attached {EV_MENU_IMP} parent_imp as a_menu then
--				pos := a_menu.index_of (interface, 1)
--			end
			Precursor {EV_SENSITIVE_IMP}
		end

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to `pointer_style'
		do
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			l_text: STRING_32
			ns_text: NS_STRING
			l_split_list: LIST [STRING_32]
			i: INTEGER
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)

			-- Map the key equivalent
			l_text := a_text.as_string_32
			l_split_list :=  l_text.split ('%T')
			if l_split_list.count = 2 then
				l_text := (l_split_list @ 1).as_string_32
				set_key_equivalent (l_split_list @ 2)
			end

			-- Get rid of the & sign which denotes a shortcut key
			i := l_text.substring_index ("&", 1)
			if i /= 0 then
				l_text := l_text.substring (1, i - 1) + l_text.substring (i + 1, l_text.count)
			end

			create ns_text.make_with_string (l_text)
			menu_item.set_title (ns_text)
			if attached {EV_MENU_ITEM_LIST_IMP} current as a_menu_imp then
				a_menu_imp.menu.set_title (ns_text)
			end
		end

	set_key_equivalent (a_text: STRING_32)
		local
			l_key_mask: INTEGER
			l_split_list: LIST [STRING_32]
		do
			l_split_list :=  a_text.split ('+')
			menu_item.set_key_equivalent (l_split_list.last.as_lower)
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ({STRING_32} "Ctrl").same_string (other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.control_key_mask)
			end
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ({STRING_32} "Shift").same_string (other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.shift_key_mask)
			end
			if l_split_list.there_exists (agent (other: STRING_32): BOOLEAN do Result := ({STRING_32} "Alt").same_string (other) end) then
				l_key_mask := l_key_mask.bit_or ({NS_MENU_ITEM}.alternate_key_mask)
			end
			menu_item.set_key_equivalent_modifier_mask (l_key_mask)
		end

feature -- Measurement

	width: INTEGER
		do
--			io.put_string ("EV_MENU_ITEM_IMP.width: Not implemented%N")
		end

	height: INTEGER
		do
--			io.put_string ("EV_MENU_ITEM_IMP.height: Not implemented%N")
		end

	screen_x: INTEGER
		do
--			io.put_string ("EV_MENU_ITEM_IMP.screen_x: Not implemented%N")
		end

	screen_y: INTEGER
		do
--			io.put_string ("EV_MENU_ITEM_IMP.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
			-- Functionality may not be fully available in OS X
			-- see NSMenu locationForSubmenu, menuBarHeight
--			io.put_string ("EV_HEADER_ITEM_IMP.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
--			io.put_string ("EV_HEADER_ITEM_IMP.y_position: Not implemented%N")
		end

	minimum_width: INTEGER = 10

	minimum_height: INTEGER = 10

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	set_pixmap (a_pixmap: EV_PIXMAP)
		local
--			l_pixmap_imp: EV_PIXMAP_IMP
		do
--			l_pixmap_imp ?= a_pixmap.implementation
--			menu_item.set_image (l_pixmap_imp.image)
		end

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		do
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	accelerators_enabled: BOOLEAN = True

	menu_item: NS_MENU_ITEM

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU_ITEM note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
