indexing
	description:
		"EiffelVision multi-column list row, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

inherit
	EV_COMPOSED_ITEM_I
		rename
			count as columns,
			set_count as set_columns
		end

feature -- Initialization

	make is
			-- Create an empty row with `par' as parent.
		deferred
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create a row with text in it.
		deferred
		end

	make_with_index (par:EV_MULTI_COLUMN_LIST; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		require
			valid_parent: par /= Void
		deferred
		end

	make_with_all (par:EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		require
			valid_parent: par /= Void
		deferred
		end

feature -- Access

--	parent: EV_MULTI_COLUMN_LIST is
--			-- List that container this row
--		deferred
--		end

--	columns: INTEGER is
--			-- Number of columns in the row
--		require
--			exists: not destroyed
--		deferred
--		end

	index: INTEGER is
			-- Index of the row in the list
		require
			exist: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

--	text: LINKED_LIST [STRING] is
--			-- Return the text of the row
--		require
--			exists: not destroyed
--		deferred
--		end

--	cell_text (column: INTEGER): STRING is
--			-- Return the text of the cell number `column' 
--		require
--			exists: not destroyed
--			valid_column: column >= 1 and column <= columns
--		deferred
--		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

feature -- Status setting

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		ensure
			index_set: index = value
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		do
			set_selected (not is_selected)
		end

--	set_columns (value: INTEGER) is
--			-- Set the number of columns of the row.
--			-- When there is a parent, the row has the
--			-- same number of column than it.
--		require
--			exists: not destroyed
--			no_parent: parent_imp = Void
--			valid_value: value > 0
--		deferred
--		end

feature -- Element Change

--	set_parent (par: EV_MULTI_COLUMN_LIST) is
--			-- Make `par' the new parent of the widget.
--			-- `par' can be Void then the parent is the screen.
--		require
--			exists: not destroyed
--			valid_size: par /= Void implies (columns = par.columns)
--		deferred
--		ensure
--			parent_set: parent = par
--		end

--	set_cell_text (column: INTEGER; a_text: STRING) is
--			-- Make `text ' the new label of the `column'-th
--			-- cell of the row.
--		require
--			exists: not destroyed
--			column_exists: column >= 1 and column <= columns
--			text_not_void: a_text /= Void
--		deferred
--		end

--	set_text (a_text: ARRAY[STRING]) is
--		require
--			exists: not destroyed
--			text_not_void: a_text /= Void
--			valid_text_length: a_text.count = columns
--		local
--			i: INTEGER
--			list_i: INTEGER
--		do
--			from
--				i := a_text.lower
--				list_i := 1
--			until
--				i = a_text.upper + 1
--			loop
--				set_cell_text (list_i, a_text @ i)
--				i := i + 1
--				list_i := list_i + 1
--			end
--		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is deactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
		deferred			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed
			-- when the item is deactivated.
		require
			exists: not destroyed
		deferred		
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_I

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
