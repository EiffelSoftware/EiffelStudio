indexing
	description: 
		"EiffelVision list. Contains a list of items from %
		% which the user can select."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST

inherit
	EV_PRIMITIVE
		export
			{NONE} add_double_click_command
			{NONE} remove_double_click_commands
		redefine
			implementation
		end

	EV_ITEM_HOLDER
		redefine
			implementation,
			item_type
		end

create
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a list widget with `par' as
			-- parent.
			-- By default, a list allow only one selection.
		do
			!EV_LIST_IMP!implementation.make
			widget_make (par)
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected
			-- It needs to be in single selection mode
		require
			exists: not destroyed
			single_selection: not is_multiple_selection
		do
			Result := implementation.selected_item
		end

	selected_items: LINKED_LIST [EV_LIST_ITEM] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
			exists: not destroyed
		do
			Result := implementation.selected_items
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		do
			Result := implementation.selected
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		do
			Result := implementation.is_multiple_selection
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' the list.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= count
		do
			implementation.select_item (index)
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= count
		do
			implementation.deselect_item (index)
		end

	clear_selection is
			-- Clear the selection of the list.
		require
			exists: not destroyed
		do
			implementation.clear_selection
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		do
			implementation.set_multiple_selection	
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		do
			implementation.set_single_selection
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been selected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_select_command (cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been unselected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been selected.
		require
			exists: not destroyed
		do
			implementation.remove_select_commands
		end

	remove_unselect_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been unselected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands
		end

feature -- Implementation
	
	implementation: EV_LIST_I	
			-- Platform dependant access.

feature {NONE} -- Implementation

	item_type: EV_LIST_ITEM is
			-- Current item is a list item.
		do
		end

end -- class EV_LIST

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
--!---------------------------------------------------------------
