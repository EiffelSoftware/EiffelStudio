indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I

	EV_SIMPLE_ITEM_IMP
		redefine
			has_parent,
			set_text,
			parent_imp
		end

create
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create a list item with an empty name.
		do
			-- Create the gtk object.
			widget := gtk_list_item_new
			gtk_object_ref (widget)

			-- Create the `box'.	
			initialize
		end
	
	make_with_index (par: EV_LIST; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		local
			par_imp: EV_LIST_IMP
		do
			par_imp ?= par.implementation
			make

			-- set `par' as parent and put the item at the given position.
			set_parent (par)
			set_index (value)
		end

	make_with_all (par: EV_LIST; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		do
			make_with_index (par, value)
			set_text (txt)
		end

feature -- Access

	parent_imp: EV_LIST_IMP
			-- Parent of the Current item

	index: INTEGER is
			-- Index of the current item.
		do
			Result := gtk_list_child_position(parent_imp.list_widget, Current.widget) + 1 
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := c_gtk_list_item_is_selected (parent_imp.list_widget, widget)
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := ( gtk_list_child_position (parent_imp.list_widget, Current.widget) + 1 = 1 )
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := ( gtk_list_child_position (parent_imp.list_widget, Current.widget) + 1 = c_gtk_list_rows (parent_imp.list_widget) )
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				c_gtk_list_item_select (widget)
			else
				c_gtk_list_item_unselect (widget)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		local
			local_array: ARRAYED_LIST [EV_LIST_ITEM_IMP]
		do
			-- Reference the widget otherwise it will be destroyed
			-- when removed from the list.
			gtk_object_ref (widget)

			-- Remove the item from the list.
			c_gtk_list_remove_item (parent_imp.list_widget, widget)

			-- Add the item at the given index.
			c_gtk_list_insert_item (parent_imp.list_widget, widget, value - 1)

			-- Unreference the widget which has an extra reference.
			gtk_object_unref (widget)

			-- updating the parent `ev_children' array
			local_array := parent_imp.ev_children
			local_array.search (Current)
			local_array.remove

			local_array.go_i_th (value)
			local_array.put_left (Current)
			
		end

feature -- element change
	
	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			a: ANY
			combo_par: EV_COMBO_BOX_IMP
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)

			-- the gtk part if the parent is a combo_box
			combo_par ?= parent_imp
			if (combo_par /= Void) then
				gtk_combo_set_item_string (parent_imp.widget, widget, $a)
			end
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= void
		end

feature -- Event : command association

	add_select_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is selected
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command (widget, "select", command, arguments, default_pointer)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unselected.
		do
			add_command (widget, "deselect", cmd, arg, default_pointer)
		end	

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the item is double clicked
		do
			old_add_dblclk (1, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_commands (widget, select_id)
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do	
			remove_commands (widget, deselect_id)
		end

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		do
			old_remove_dblclk (1)
		end

end -- class EV_LIST_ITEM_IMP

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
