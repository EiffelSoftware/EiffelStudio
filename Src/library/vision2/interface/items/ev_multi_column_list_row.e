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
	EV_COMPOSED_ITEM
		rename
			count as columns,
			set_count as set_columns
		redefine
			parent,
			make_with_index,
			make_with_all,
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

	make (par: like parent) is
			-- Create an empty row.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make
			implementation.set_interface (Current)
			if par /= Void then
				set_columns (par.columns)
			end
			set_parent (par)
		end

	make_with_text (par: like parent; txt: ARRAY [STRING]) is
			-- Create a row with the given texts.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_index (par: like parent; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make
			{EV_COMPOSED_ITEM} Precursor (par, value)
		end

	make_with_all (par: like parent; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make_with_text (txt)
			{EV_COMPOSED_ITEM} Precursor (par, txt, value)
		end

feature -- Access

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

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.set_selected (flag)
		ensure
			state_set: is_selected = flag
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
			implementation.remove_select_commands			
		end

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands	
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

feature -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Platform dependent access.

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
