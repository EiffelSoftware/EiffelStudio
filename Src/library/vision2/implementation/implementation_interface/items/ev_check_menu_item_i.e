indexing	
	description: 
		"EiffelVision check menu item. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CHECK_MENU_ITEM_I

inherit
	EV_MENU_ITEM_I
	
feature -- Status report
	
	state: BOOLEAN is
			-- Is current menu-item checked ?.
		require
			exists: not destroyed
		deferred
		end 
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		require
			exists: not destroyed
		deferred
		ensure
			correct_state: state = flag
		end

feature -- Event : command association

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		require
			exists: not destroyed
		deferred	
		end

end -- class EV_CHECK_MENU_ITEM_I

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
