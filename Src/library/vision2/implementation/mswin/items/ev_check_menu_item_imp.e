--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision check menu item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			parent_imp
		end

	EV_MENU_ITEM_IMP
		redefine
			on_activate,
			is_selected,
			set_selected,
			parent_imp
		end
	
creation
	make

feature --  Access

	parent_imp: EV_MENU_IMP
		-- Parent of `Current'.

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is current menu-item selected?
		do
			Result := parent_imp.internal_selected (Current)	
		end
	
feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			parent_imp.internal_set_selected (Current, flag)
		end

	toggle is
			-- Change the state of the menu-item to
			-- opposite
		do
			set_selected (not is_selected)
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when th item is activate.
		do
			toggle
			execute_command (Cmd_item_activate, Void)
		end

end -- class EV_CHECK_MENU_ITEM_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.2  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
