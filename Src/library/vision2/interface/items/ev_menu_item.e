indexing	
	description: 
		"EiffelVision menu item. Item that must be put in an %
		% EV_MENU_ITEM_HOLDER."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			make_with_index,
			make_with_all,
			parent
		end
	
	EV_MENU_ITEM_HOLDER
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
			-- Create the widget with `par' as parent.
		do
			!EV_MENU_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: like parent; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_MENU_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_with_index (par: like parent; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
			create {EV_MENU_ITEM_IMP} implementation.make
			{EV_SIMPLE_ITEM} Precursor (par, value)
		end

	make_with_all (par: like parent; txt: STRING; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		do
			create {EV_MENU_ITEM_IMP} implementation.make_with_text (txt)
			{EV_SIMPLE_ITEM} Precursor (par, txt, value)
		end

feature -- Access

	parent: EV_MENU_ITEM_HOLDER is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

	top_parent: EV_MENU_ITEM_HOLDER is
			-- Top item holder that contains the current item.
		require
			exists: not destroyed
		do
			if implementation.top_parent_imp = Void then
				Result := Void
			else
				Result ?= implementation.top_parent_imp.interface
			end
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is current item insensitive to
			-- user actions? 
		require
			exists: not destroyed
		do
			Result := implementation.is_insensitive
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- we use it only when the grand parent is an option button.
  		require
			exists: not destroyed
			valid_grand_parent: grand_parent_is_option_button
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'. 
   		require
   			exists: not destroyed
   		do
 			implementation.set_insensitive (flag)
 		ensure
   			state_set: is_insensitive = flag
   		end

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- we use it only when the grand parent is an option button.
   		require
			exists: not destroyed
			parent_is_an_option_button: grand_parent_is_option_button
   		do
 			implementation.set_selected (flag)
 		ensure
   			state_set: is_selected = flag
   		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- True if the grand parent is an option button.
			-- False otherwise.
		do
			Result := implementation.grand_parent_is_option_button
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

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		require
			exists: not destroyed
		do
			implementation.remove_select_commands			
		end

feature -- Implementation

	implementation: EV_MENU_ITEM_I
			-- Platform dependent access.

end -- class EV_MENU_ITEM

--|----------------------------------------------------------------
--| EiffelVision Library: library of reusable components for ISE Eiffel.
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
