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
			set_text,
			parent_imp
		end

	EV_MENU_ITEM_HOLDER_IMP
		rename
			item_command_count as command_count
		redefine
			add_item,
			insert_item,
			remove_item
		end

	EV_ID_IMP

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			set_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		do
			set_text (txt)
		end

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent implementation

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	id: INTEGER is
			-- Identifier of the item
		do
			Result := parent_imp.internal_get_id (Current)
		end

	menu: WEL_MENU
			-- Wel menu used when the item is a sub-menu.

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The handler of the item.
		do
			if parent_imp /= Void then
				Result := parent_imp.item_handler
			else
				Result := Void
			end
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the menu.
		do
			Result := False
		end

	is_insensitive: BOOLEAN is
			-- Is current menu_item insensitive ?
		do
			Result := parent_imp.internal_insensitive (Current)
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- We use it only when the grand parent is an option button.
		local
			menu_imp: EV_MENU_IMP
			option: EV_OPTION_BUTTON
			mitem: EV_MENU_ITEM
		do
			menu_imp ?= parent_imp
			if menu_imp /= Void then
				option ?= menu_imp.parent_imp
				if option /= Void then
					mitem ?= interface
					Result := mitem.is_equal (option.selected_item)
				end
			end
		end

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := children.count
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'.
		do
			parent_imp.internal_set_insensitive (Current, flag)
		end

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- We use it only when the grand parent is an option button.
   		do
			parent_imp.on_selection_changed (Current)
   		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set `text' to `txt'.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.menu.modify_string (txt, id)
				item_handler.update_menu
			end
		end

	add_item (an_item: EV_MENU_ITEM_IMP) is
			-- Add `an_item' into container.
		do
			-- First, we transform the item into a menu.
			if menu = Void then
				!! menu.make
				if parent_imp /= Void then
					parent_imp.internal_delete_item (Current)
					parent_imp.internal_insert_menu (Current)
				end
			end

			-- Then we normaly add the item.
			{EV_MENU_ITEM_HOLDER_IMP} Precursor (an_item)
		end

	insert_item (item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' at the position `pos'
		do
			-- First, we transform the item into a menu.
			if menu = Void then
				!! menu.make
				if parent_imp /= Void then
					parent_imp.internal_delete_item (Current)
					parent_imp.internal_insert_menu (Current)
				end
			end

			-- Then we normaly add the item.
			{EV_MENU_ITEM_HOLDER_IMP} Precursor (item_imp, pos)
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the menu,
		do
			-- First, we call the precursor
			{EV_MENU_ITEM_HOLDER_IMP} Precursor (item_imp)

			-- If there is no more children, it becomes a normal item.
			if children = Void then
				if parent_imp /= Void then
					parent_imp.internal_delete_item (Current)
					parent_imp.internal_insert_item (Current)
				end
				menu := Void
			end
		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- Is true if the grand parent is an option button.
			-- False otherwise.
		local
			option: EV_OPTION_BUTTON_IMP
		do
			option ?= item_handler
			if option = Void then
				Result := False
			else
				Result := True
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

feature {EV_MENU_ITEM_HANDLER_IMP} -- WEL Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			execute_command (Cmd_item_activate, Void)
			parent_imp.on_selection_changed (Current)
		end

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'.
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
