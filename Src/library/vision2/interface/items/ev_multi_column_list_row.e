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
--	EV_ANY
--		redefine
--			implementation
--		end

	EV_COMPOSED_ITEM
		rename
			count as columns,
			set_count as set_columns
		redefine
			parent,
			implementation
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_MULTI_COLUMN_LIST) is
			-- Create an empty row.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make
			implementation.set_interface (Current)
			if par /= Void then
				set_columns (par.columns)
			end
			set_parent (par)
		end

	make_with_text (par: EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]) is
			-- Create a row with the given texts.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_index (par:EV_MULTI_COLUMN_LIST; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		require
			valid_parent: par /= Void
			valid_index: (value > 0 and value <= par.rows + 1)
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make_with_index (par, value)
			implementation.set_interface (Current)
		end

	make_with_all (par:EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		require
			valid_parent: par /= Void
			valid_index: (value > 0 and value <= par.rows + 1)
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make_with_all (par, txt, value)
			implementation.set_interface (Current)
		end

feature -- Access

	index: INTEGER is
			-- Index of the row in the list
		require
			exist: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.index
		end

	parent: EV_MULTI_COLUMN_LIST is
			-- Parent of the current item.
		do
			Result ?= {EV_COMPOSED_ITEM} Precursor
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

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		require
			exists: not destroyed
			has_parent: parent /= Void
			valid_index: (value > 0) and (value <= parent.rows + 1)
		do
			implementation.set_index (value)
		ensure
			index_set: index = value
		end
	
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
