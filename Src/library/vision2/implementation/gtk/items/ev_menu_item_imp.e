indexing

	description: 
		"EiffelVision menu item, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP
	
inherit
	EV_MENU_ITEM_I
		redefine
			parent_imp
		end

	EV_SIMPLE_ITEM_IMP
		undefine
			pixmap_size_ok
		redefine
			parent_imp
		end

	EV_MENU_ITEM_HOLDER_IMP
		rename
			parent_imp as widget_parent_imp,
			parent_set as widget_parent_set
		undefine
			has_parent,
			set_foreground_color
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			-- Create the gtk object.
			widget := gtk_menu_item_new
			gtk_object_ref (widget)

			-- Create the `box'.
			initialize

			-- Create the array where the items will be listed.
			create ev_children.make (0)
		end

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent of the current widget.

	index: INTEGER is
			-- Index of the current item.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is current widget insensitive?
   		do
                        Result := not c_gtk_widget_sensitive (widget)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- We use this function only when the parent
			-- of the parent (the menu) is an option button.
		local
			pos: INTEGER
   		do
			if (flag) then
				pos := c_gtk_option_button_index_of_menu_item (parent_imp.parent_imp.widget, widget)
				gtk_option_menu_set_history (parent_imp.parent_imp.widget, pos)
			end  
 		end

feature -- Element change

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
			check
				To_be_implemented: False
			end
		end

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them from the menu and destroy them).
		do
			-- clear the EiffelVision objects.
			clear_ev_children

			-- clear the gtk objects.
			c_gtk_menu_remove_all_items (C_GTK_MENU_ITEM_SUBMENU (widget))
		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- Is true if the grand parent is an option button.
			-- False otherwise.
		local
			gd_par: EV_OPTION_BUTTON
		do
			gd_par ?= parent_imp.parent_imp.interface
			Result := (gd_par /= Void)
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- Works only when the parent is an option button.
		local
			selected_item_p: POINTER
		do
			-- Pointer to the menu_item which is currently selected:
			selected_item_p := c_gtk_option_button_selected_menu_item (parent_imp.parent_imp.widget)
			if widget = selected_item_p then
				Result := True
			else
				Result := False
			end
		end

feature -- Event : command association

	add_select_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command (widget, "activate", command, arguments, default_pointer)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_commands (widget, activate_id)
		end	

feature {NONE} -- Implementation

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add an item to the current item. The current
			-- item become then a sub-menu
		local
			submenu: POINTER
		do
			if C_GTK_MENU_ITEM_SUBMENU(widget) = default_pointer then
				submenu := gtk_menu_new () 
				gtk_menu_item_set_submenu (GTK_MENU_ITEM (widget), submenu)
			end
			gtk_menu_append (C_GTK_MENU_ITEM_SUBMENU(widget), item_imp.widget)

			-- Update the array `ev_children'.
			ev_children.extend (item_imp)			
		end		

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			gtk_container_remove (GTK_CONTAINER (C_GTK_MENU_ITEM_SUBMENU(widget)), item_imp.widget)

			-- Update the array `ev_children'.
			ev_children.prune_all (item_imp)
		end

end -- class EV_MENU_ITEM_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
