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

	EV_SIMPLE_ITEM_IMP
		undefine
			pixmap_size_ok
		redefine
			set_text
		end

	EV_MENU_ITEM_HOLDER_IMP
		rename
			item_command_count as command_count
		redefine
			add_item
		end

	EV_ID_IMP

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			set_text ("")
			id := new_id
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the menu.
		do
			Result := False
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
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			interface := Void
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

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- We use it only when the grand parent is an option button.
   		do
			parent_imp.on_selection_changed (Current)
   		end

feature -- Element change

	set_parent (par: EV_MENU_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				ev_children := parent_imp.ev_children
				parent_imp.add_item (Current)
			end
		end

	set_text (txt: STRING) is
			-- Set `text' to `txt'.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_menu.modify_string (txt, id)
			end
		end

	add_item (an_item: EV_MENU_ITEM_IMP) is
			-- Add `an_item' into container.
		do
			-- First, we transform the item into a menu.
			if submenu = Void then
				!! submenu.make
				ev_children := parent_imp.ev_children
				parent_menu.delete_item (id)
				parent_imp.insert_menu (submenu, position, text)
			end
			{EV_MENU_ITEM_HOLDER_IMP} Precursor (an_item)
		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- Is true if the grand parent is an option button.
			-- False otherwise.
		do
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- We use it only when the grand parent is an option button.
		local
			menu: EV_MENU_IMP
			option: EV_OPTION_BUTTON
			mitem: EV_MENU_ITEM
		do
			menu ?= parent_imp
			if menu /= Void then
				option ?= menu.parent_imp
				if option /= Void then
					mitem ?= interface
					Result := mitem.is_equal (option.selected_item)
				end
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do
			remove_command (Cmd_item_activate)			
		end

feature {EV_MENU_ITEM_HOLDER_IMP} -- Implementation
	
	parent_menu: WEL_MENU is
			-- Wel menu that contains the current item.
		local
			item: EV_MENU_ITEM_IMP
		do
			Result ?= parent_imp
			if Result = Void then
				item ?= parent_imp
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
			parent_imp.on_selection_changed (Current)
		end

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		do
			parent_imp.on_selection_changed (sitem)
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
