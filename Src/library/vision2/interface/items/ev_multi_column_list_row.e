indexing
	description:
		"EiffelVision multi-column list row. These rows are used in %
		%the multi-column lists."
	status: "See notice at end of class"
	note: "It is not an item because it doesn't have the same options."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW

inherit
	EV_ANY
		redefine
			implementation
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_MULTI_COLUMN_LIST) is
			-- Create an empty row.
		do
			!EV_MULTI_COLUMN_LIST_ROW_IMP! implementation.make
			implementation.set_interface (Current)
			if par /= Void then
				set_columns (par.columns)
			end
			set_parent (par)
		end

	make_with_text (par: EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]) is
			-- Create a row with the given texts.
		do
			!EV_MULTI_COLUMN_LIST_ROW_IMP! implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
			-- List that container this row
		do
			Result := implementation.parent
		end

	columns: INTEGER is
			-- Number of columns in the row
		require
			exists: not destroyed
		do
			Result := implementation.columns
		end

	index: INTEGER is
			-- Index of the row in the list
		require
			exist: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.index
		end

	text: LINKED_LIST [STRING] is
			-- Return the text of the row
		require
			exists: not destroyed
		do
			Result := implementation.text
		end

	cell_text (column: INTEGER): STRING is
			-- Return the text of the cell number `column' 
		require
			exists: not destroyed
			valid_column: column >= 1 and column <= columns
		do
			Result := implementation.cell_text (column)
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.set_selected (flag)
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.toggle
		end

	set_columns (value: INTEGER) is
			-- Set the number of columns of the row.
			-- When there is a parent, the row has the
			-- same number of column than it.
		require
			exists: not destroyed
			no_parent: parent = Void
			valid_value: value > 0
		do
			implementation.set_columns (value)
		end

feature -- Element Change

	set_parent (par: EV_MULTI_COLUMN_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
			valid_size: par /= Void implies (columns = par.columns)
		do
			implementation.set_parent (par)
		ensure
			parent_set: parent = par
		end

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		require
			exists: not destroyed
			valid_column: column >= 1 and column <= columns
			valid_text: a_text /= Void
		do
			implementation.set_cell_text (column, a_text)
		end

	set_text (a_text: ARRAY[STRING]) is
		require
			exists: not destroyed
			valid_text: a_text /= Void
			valid_text_length: a_text.count = columns
		do
			implementation.set_text (a_text)
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_activate_command (cmd, arg)
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is deactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_deactivate_command (cmd, arg)		
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
		do
			implementation.remove_activate_commands			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed
			-- when the item is deactivated.
		require
			exists: not destroyed
		do
			implementation.remove_deactivate_commands		
		end

feature {EV_MULTI_COLUMN_LIST_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I

end -- class EV_MULTI_COLUMN_LIST_ROW

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
