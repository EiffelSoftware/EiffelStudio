indexing
	description: "EiffelVision multi-column list row, mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I

	EV_COMPOSED_ITEM_IMP
		rename
			count as columns,
			set_count as set_columns
		redefine
			set_cell_text
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make_with_index (par: EV_MULTI_COLUMN_LIST; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		local
			par_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			create internal_text.make (1)
			internal_text.extend ("")
			par_imp ?= par.implementation
			set_columns (par_imp.columns)
			parent_imp := par_imp
			parent_imp.insert_item (Current, value)
		end

	make_with_all (par: EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		do
			internal_text ?= txt.linear_representation
			parent_imp ?= par.implementation
			parent_imp.insert_item (Current, value)
		end

feature -- Access

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- List implementation that contain this row

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	index: INTEGER is
			-- Index of the row in the list
		do
			Result := parent_imp.internal_get_index (Current)
		end

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current row destroyed?  
		do
			Result := (internal_text = Void) or else (internal_text.empty)
		end

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			Result := parent_imp.internal_is_selected (Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual object.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			internal_text := Void
			interface := Void
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		do
			parent_imp.move_item (Current, value)
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
 			if flag then
 				parent_imp.internal_select (Current)
 			else
				parent_imp.internal_deselect (Current)
 			end
		end

feature -- Element Change

	set_parent (par: EV_MULTI_COLUMN_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			new_text: ARRAY [STRING]
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_item (Current)
			end
		end

	set_cell_text (column: INTEGER; txt: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		do
			{EV_COMPOSED_ITEM_IMP} Precursor (column, txt)
			if parent_imp /= Void then
				parent_imp.set_cell_text (column - 1, index - 1, txt)
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed
			-- when the item is selected.
		do
			remove_command (Cmd_item_activate)
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed
			-- when the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
