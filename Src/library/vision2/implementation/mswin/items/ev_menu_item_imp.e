indexing
	description: 
		"EiffelVision menu item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP
	
inherit
	EV_MENU_ITEM_I

	EV_MENU_ITEM_CONTAINER_IMP
		rename
			item_command_count as command_count
		redefine
			add_item
		end

	EV_ITEM_IMP
		undefine
			pixmap_size_ok
		redefine
			parent
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_CONTAINER) is
			-- Create and add a menu_item with an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create and add a menu_item with `txt' as label.
		do
			parent ?= par.implementation
			check
				parent_not_void: parent /= Void
			end
			text := txt
			ev_children := parent.ev_children
		end

feature -- Access

	text: STRING
			-- Text of the current item

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the menu.
		do
			if submenu /= Void then
				Result := not parent_menu.popup_exists (position)
			else
				Result := not parent_menu.item_exists (id)
			end
		end

	insensitive: BOOLEAN is
			-- Is current menu_item insensitive ?
		do
			Result := not parent_menu.item_enabled (id)
		end

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			parent.remove_item (id)
		end

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'.
		do
			if flag then
				parent_menu.disable_item (id)
			else
				parent_menu.enable_item (id)
			end
		end

feature -- Element change

	set_text (str: STRING) is
			-- Set `text' to `str'
		do
			parent_menu.modify_string (str, id)
			text := str
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	add_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		do
			-- First, we transform the item into a menu.
			if submenu = Void then
				!! submenu.make
				ev_children := parent.ev_children
				parent_menu.delete_item (id)
				parent.insert_item (submenu, position, text)
			end
			{EV_MENU_ITEM_CONTAINER_IMP} Precursor (an_item)
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Access
	
	parent: EV_MENU_ITEM_CONTAINER_IMP
			-- The vision parent of the current item.

	parent_menu: WEL_MENU is
			-- Wel menu that contains the current item.
		local
			item: EV_MENU_ITEM_IMP
		do
			Result ?= parent
			if Result = Void then
				item ?= parent
				Result := item.submenu
			end
		end

	submenu: WEL_MENU
			-- Wel menu used when the item is a sub-menu.

feature {EV_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			execute_command (Cmd_item_activate, Void)
			parent.on_selection_changed (Current)
		end

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		do
			parent.on_selection_changed (sitem)
		end

end -- class EV_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
