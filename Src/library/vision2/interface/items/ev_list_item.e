indexing	
	description: 
		"EiffelVision list item. This items are used in %
		%the EV_LIST or EV_COMBO_BOX."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			parent
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Create the widget with `par' as parent.
		do
			!EV_LIST_ITEM_IMP!implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_LIST_ITEM_IMP!implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_with_index (par: EV_LIST; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		require
			valid_parent: par /= Void
		do
			!EV_LIST_ITEM_IMP!implementation.make_with_index (par, value)
			implementation.set_interface (Current)
		end

	make_with_all (par: EV_LIST; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		require
			valid_parent: par /= Void
		do
			!EV_LIST_ITEM_IMP!implementation.make_with_all (par, txt, value)
			implementation.set_interface (Current)
		end

feature -- Access

	parent: EV_LIST is
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

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected ?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_first
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_last
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

feature -- Element change

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		require
			exists: not destroyed
			has_parent: parent /= Void
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

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		obsolete
			"Will be removed in next week release, %
			 %use add_select_command instead."
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_select_command (cmd, arg)
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		obsolete
			"Will be removed in next week release, %
			 %use add_unselect_command instead."
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)		
		end

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- when the item is double clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_double_click_command (cmd, arg)
		end	

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		obsolete
			"Will be removed in next week release, %
			 %use remove_select_commands instead."
		require
			exists: not destroyed
		do
			implementation.remove_select_commands			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		obsolete
			"Will be removed in next week release, %
			 %use remove_unselect_commands instead."
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands	
		end

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

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		require
			exists: not destroyed
		do
			implementation.remove_double_click_commands
		end	

feature -- Implementation

	implementation: EV_LIST_ITEM_I

end -- class EV_LIST_ITEM

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
