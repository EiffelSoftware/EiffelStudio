indexing

	description: 
		"EiffelVision list. Contains a list of strings from %
		% which the user can select."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class EV_LIST

inherit

	EV_PRIMITIVE
		redefine
			implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a list widget with `par' as
			-- parent.
			-- By default, a list allow only one selection.
		do
			!EV_LIST_IMP!implementation.make (par)
			widget_make (par)
		end

feature -- Access

	get_item (index: INTEGER): EV_LIST_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: index <= count
		do
			Result := implementation.get_item(index)
		end

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
		require
			exists: not destroyed
			item_selected: selected
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
			item_selected: selected
		do
			Result := implementation.selected_items
		end

feature -- Status report

	count: INTEGER is
			-- Number of lines
		require
			exists: not destroyed
		do
			Result := implementation.count
		end

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

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		do
			implementation.clear_items
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
			-- Make `command' executed when an item is
			-- selected.
		require
			exists: not destroyed
		do
			implementation.add_selection_command (a_command, arguments)
		end

	add_double_click_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Make `command' executed when an item is
			-- selected by double clicked.
		require
			exists: not destroyed
		do
			implementation.add_double_click_selection_command (a_command, arguments)
		end
	
feature {EV_LIST_ITEM_IMP, EV_LIST_ITEM} -- Implementation
	
	implementation: EV_LIST_I	

end -- class EV_LIST

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
