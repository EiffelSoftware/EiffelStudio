indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_IMP

inherit
	EV_LIST_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			destroy
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			!! ev_children.make (1)
			widget := gtk_list_new
			set_single_selection
			gtk_object_ref (widget)
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
			-- XX Currently just give head of the gtk selection list
		local
			index: INTEGER
		do
			index := c_gtk_list_selected_item(widget)
			if index = -1 then
				Result := Void
			else
				-- Gtk has 0 based indicies
				Result ?= (ev_children @ (index+1)).interface
			end
		end

feature -- Status report

	rows: INTEGER is
		 	-- Number of lines
		do
			Result := c_gtk_list_rows (widget)
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := c_gtk_list_selected (widget)
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			Result := c_gtk_list_selection_mode (widget) = GTK_SELECTION_MULTIPLE
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects
		do
			clear_items
			{EV_PRIMITIVE_IMP} Precursor 
		end

	select_item (index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			gtk_list_select_item (widget, index - 1)
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			gtk_list_unselect_item (widget, index - 1)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			gtk_list_unselect_all (widget)
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_list_set_selection_mode (widget, GTK_SELECTION_MULTIPLE)
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_list_set_selection_mode (widget, GTK_SELECTION_SINGLE)
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			clear_ev_children
			gtk_list_clear_items (widget, 0, rows)
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Make `command' executed when an item is
			-- selected.
		do
			add_command (widget, "selection_changed", cmd, arg)
			-- add_command ("select_child", a_command, arguments)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_commands (widget, selection_changed_id)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	add_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Add `item' to the list.
		do
			ev_children.extend (item_imp)
			gtk_container_add (widget, item_imp.widget)
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; value: INTEGER) is
			-- insert `item_imp' at the position
			-- `value' of list.
		do
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			ev_children.prune_all (item_imp)
			gtk_container_remove (widget, item_imp.widget)
		end

end -- class EV_LIST_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
