indexing	
	description: 
		"EiffelVision check menu item. Item that must be put in%
		% an EV_MENU_ITEM_HOLDER. It has two states : check and%
		% unchecked."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			make,
			make_with_text,
			implementation
		end
	
creation
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_HOLDER) is
			-- Create the widget with `par' as parent.
		do
			!EV_CHECK_MENU_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_MENU_ITEM_HOLDER; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_CHECK_MENU_ITEM_IMP!implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

feature -- Status report
	
	state: BOOLEAN is
			-- Is current menu-item checked ?.
		obsolete
			"Will be removed in next week release, %
			 %use is_selected instead."
		require
			exists: not destroyed
		do
			Result := implementation.is_selected
		end 
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		obsolete
			"Will be removed in next week release, %
			 %use set_selected instead."
		require
			exists: not destroyed
		do
			implementation.set_selected (flag)
		ensure
			correct_state: state = flag
		end

	toggle is
			-- Change the state of the menu-item to
			-- opposite
		require
			exists: not destroyed
		do
			set_selected (not is_selected)
		ensure
			state_is_true: is_selected = not old is_selected
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)		
		end

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		obsolete
			"Will be removed in next week release, %
			 %use add_select_command instead."
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)		
		end

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands	
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

feature -- Implementation

	implementation: EV_CHECK_MENU_ITEM_I

end -- class EV_CHECK_MENU_ITEM

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
