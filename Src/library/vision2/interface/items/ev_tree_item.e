indexing	
	description: 
		"EiffelVision tree item. Item that can be put in a tree.%
		% A tree item is also a tree-item container because if%
		% we create a tree-item with a tree-item as parent, the%
		% parent will become a subtree."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			parent
		end

	EV_TREE_ITEM_HOLDER
		redefine
			implementation
		end

	EV_PND_SOURCE
		redefine
			implementation
		end

	EV_PND_TARGET
		redefine
			implementation
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the widget with `par' as parent.
		do
			!EV_TREE_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_TREE_ITEM_HOLDER; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_TREE_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_with_index (par: EV_TREE_ITEM_HOLDER; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		require
			valid_parent: par /= Void
			valid_index: (value > 0) and (value <= par.count + 1)
		do
			!EV_TREE_ITEM_IMP!implementation.make_with_index (par, value)
			implementation.set_interface (Current)
--			set_parent (par)
		end

	make_with_all (par: EV_TREE_ITEM_HOLDER; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		require
			valid_parent: par /= Void
			valid_index: (value > 0) and (value <= par.count + 1)
		do
			!EV_TREE_ITEM_IMP!implementation.make_with_all (par, txt, value)
			implementation.set_interface (Current)
--			set_parent (par)
		end

feature -- Access

	parent: EV_TREE_ITEM_HOLDER is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

	index: INTEGER is
			-- Index of the current item.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.index
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.set_selected (flag)
		ensure
			is_selected: flag implies is_selected
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.toggle
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		require
			exists: not destroyed
			has_parent: parent /= Void
			is_parent: is_parent
		do
			implementation.set_expand (flag)
		ensure
			is_expanded: flag implies is_expanded
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

	is_expanded: BOOLEAN is
			-- is the item expanded?
		require
			exists: not destroyed
		do
			Result := implementation.is_expanded
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		require
			exists: not destroyed
		do
			Result := implementation.is_parent
		end

feature -- Element change

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		require
			exists: not destroyed
			has_parent: parent /= Void
--			valid_index: (value > 0) and (value <= par.count + 1)
		do
			implementation.set_index (value)
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_select_command (cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)		
		end

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_subtree_command (cmd, arg)
		end

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.add_button_press_command (mouse_button, cmd, arg)
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.add_button_release_command (mouse_button, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands			
		end

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands	
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
		do
			implementation.remove_subtree_commands
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			exists: not destroyed
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.remove_button_press_commands (mouse_button)
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			exists: not destroyed
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.remove_button_release_commands (mouse_button)
		end

-- feature {EV_TREE_ITEM_HOLDER, EV_TREE_ITEM_HOLDER_I} -- Implementation
feature -- Implementation

	implementation: EV_TREE_ITEM_I

end -- class EV_TREE_ITEM

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

