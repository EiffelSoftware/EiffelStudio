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
		redefine
			parent
		end

	EV_PND_SOURCE_I

	EV_PND_TARGET_I

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_COMPOSED_ITEM_I} Precursor
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- List implementation that contain this row

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		ensure
			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		do
			set_selected (not is_selected)
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed
			-- when the item is selected.
		require
			exists: not destroyed
		deferred			
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed
			-- when the item is unselected.
		require
			exists: not destroyed
		deferred		
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_I

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
