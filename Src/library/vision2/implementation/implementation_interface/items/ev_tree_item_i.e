indexing
	description:
		"EiffelVision tree item, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_SIMPLE_ITEM_I

	EV_TREE_ITEM_HOLDER_I

	EV_PND_SOURCE_I

	EV_PND_TARGET_I

feature {NONE} -- Initialization

	make_with_index (par: EV_TREE_ITEM_HOLDER; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		require
			valid_parent: par /= Void
--			valid_index: (value > 0) and (value <= par.count + 1)
		deferred
		end

	make_with_all (par: EV_TREE_ITEM_HOLDER; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		require
			valid_parent: par /= Void
--			valid_index: (value > 0) and (value <= par.count + 1)
		deferred
		end

feature -- Access

	parent_imp: EV_TREE_ITEM_HOLDER_IMP
			-- Parent implementation

	index: INTEGER is
			-- Index of the current item.
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
			is_selected: flag implies is_selected
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		do
			set_selected (not is_selected)
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
			is_parent: is_parent
		deferred
		ensure
			is_expanded: flag implies is_expanded
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		require
			exists: not destroyed
		deferred
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		deferred
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
--			valid_index: (value > 0) and (value <= par.count + 1)
		deferred
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		require
			exists: not destroyed
		deferred			
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		require
			exists: not destroyed
		deferred	
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
		deferred
		end

end -- class EV_TREE_ITEM_I

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
--|----------------------------------------------------------------
