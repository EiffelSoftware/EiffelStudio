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
			parent
		end
	
	EV_MENU_ITEM_HOLDER
		redefine
			implementation
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_HOLDER) is
			-- Create the widget with `par' as parent.
		do
			!EV_MENU_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_MENU_ITEM_HOLDER; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_MENU_ITEM_IMP! implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

feature -- Access

	parent: EV_MENU_ITEM_HOLDER is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

feature -- Status report

	insensitive: BOOLEAN is
			-- Is current item insensitive to
			-- user actions? 
		require
			exists: not destroyed
		do
			Result := implementation.insensitive
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
   			flag = insensitive
   		end

	set_selected is
   			-- Set current item as the selected one.
			-- we use it only when the grand parent is an option button.
   		require
			parent_is_an_option_button: grand_parent_is_option_button
   		do
 			implementation.set_selected
 		ensure
   			is_now_selected: is_selected
   		end

feature -- Element change

--	set_parent (par: EV_MENU_ITEM_HOLDER) is
--			-- Make `par' the new parent of the widget.
--			-- `par' can be Void then the parent is the screen.
--		require
--			exists: not destroyed
--		do
--			implementation.set_parent (par)
--		ensure
--			parent_set: parent = par
--		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- True if the grand parent is an option button.
			-- False otherwise.
		do
			Result := implementation.grand_parent_is_option_button
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- we use it only when the grand parent is an option button.
   		require
			valid_grand_parent: grand_parent_is_option_button
		do
			Result := implementation.is_selected
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

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		require
			exists: not destroyed
		do
			implementation.remove_activate_commands			
		end

feature -- Implementation

	implementation: EV_MENU_ITEM_I

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
