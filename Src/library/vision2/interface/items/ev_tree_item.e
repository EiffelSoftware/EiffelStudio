--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			create_action_sequences,
			--make_with_index,
			--make_with_all,
			parent
		end

	EV_TREE_ITEM_HOLDER
		redefine
			implementation,
			create_action_sequences
		end

	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create
	--make,
	--make_with_text,
	--make_with_index,
	--make_with_all

feature {NONE} -- Initialization

	--make (par: like parent) is
	--		-- Create the widget with `par' as parent.
	--	do
	--		!EV_TREE_ITEM_IMP! implementation.make
	--		implementation.set_interface (Current)
	--		set_parent (par)
	--	end

	--make_with_text (par: like parent; txt: STRING) is
	--		-- Create an item with `par' as parent and `txt'
	--		-- as text.
	--	do
	--		!EV_TREE_ITEM_IMP! implementation.make
	--		implementation.set_interface (Current)
	--		implementation.set_text (txt)
	--		set_parent (par)
	--	end

	--make_with_index (par: like parent; value: INTEGER) is
	--		-- Create a row at the given `value' index in the list.
	--	do
	--		create {EV_TREE_ITEM_IMP} implementation.make
	--		{EV_SIMPLE_ITEM} Precursor (par, value)
	--	end

	--make_with_all (par: like parent; txt: STRING; value: INTEGER) is
	--		-- Create a row with `txt' as text at the given
	--		-- `value' index in the list.
	--	do
	--		create {EV_TREE_ITEM_IMP} implementation.make_with_text (txt)
	--		{EV_SIMPLE_ITEM} Precursor (par, txt, value)
	--	end

	--make_with_parent_and_text (par: like parent; txt: STRING) is
	--	do
	--	end

feature -- Access

	parent: EV_TREE_ITEM_HOLDER is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

	top_parent: EV_TREE_ITEM_HOLDER is
			-- Top item holder that contains the current item.
		do
				Result := implementation.top_parent
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			in_widget: top_parent /= Void
		do
			Result := implementation.is_selected
		end

	is_expanded: BOOLEAN is
			-- is the item expanded?
		require
			in_widget: top_parent /= Void
		do
			Result := implementation.is_expanded
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		require
		do
			Result := implementation.is_parent
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			in_widget: top_parent /= Void
		do
			implementation.set_selected (flag)
		ensure
 			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			in_widget: top_parent /= Void
		do
			implementation.toggle
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		require
			in_widget: top_parent /= Void
			is_parent: is_parent
		do
			implementation.set_expand (flag)
		ensure
			state_set: is_expanded = flag
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		require
			valid_command: cmd /= Void
		do
			--FIXME implementation.add_select_command (cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		require
			valid_command: cmd /= Void
		do
			--FIXME implementation.add_unselect_command (cmd, arg)		
		end

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		require
			valid_command: cmd /= Void
		do
			--FIXME implementation.add_subtree_command (cmd, arg)
		end

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		require
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			--FIXME implementation.add_button_press_command (mouse_button, cmd, arg)
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		require
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			--FIXME implementation.add_button_release_command (mouse_button, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		require
		do
			--FIXME implementation.remove_unselect_commands			
		end

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		require
		do
			--FIXME implementation.remove_unselect_commands	
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		require
		do
			--FIXME implementation.remove_subtree_commands
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			--FIXME implementation.remove_button_press_commands (mouse_button)
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			--FIXME implementation.remove_button_release_commands (mouse_button)
		end

feature -- Implementation

	implementation: EV_TREE_ITEM_I
			-- Platform dependent access

	create_implementation is
		do
		end

	create_action_sequences is
		do
			{EV_TREE_ITEM_HOLDER} Precursor
		end

end -- class EV_TREE_ITEM

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


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.26  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.25.6.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.25.6.2  1999/12/17 21:10:38  rogers
--| Now inherits EV_PICK_AND_DROPABLE instead of EV_PND_SOURCE and EV_PND_TARGET. Make procedures have been removed, ready for re-implementation. The addition and removal of commands have been commented, ready for re-implementation.
--|
--| Revision 1.25.6.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.25.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.25.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
