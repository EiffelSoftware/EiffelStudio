--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision radio menu item. Implementatino interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		select
			parent_imp
		end

	EV_CHECK_MENU_ITEM_IMP
		rename
			parent_imp as old_check_menu_parent_imp
		redefine
			set_selected,
			on_activate,
			destroy
		end

	EV_RADIO_IMP [EV_RADIO_MENU_ITEM]

creation
	make

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			group.remove_item (Current)
			{EV_CHECK_MENU_ITEM_IMP} Precursor
		end

	set_selected (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			{EV_CHECK_MENU_ITEM_IMP} Precursor (flag)
			if group /= Void then
				group.set_selection_at_no_event (Current)
			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activate.
		do
			if group /= Void then
				group.set_selection_at (Current)
			end
			set_selected (True)
			execute_command (Cmd_item_activate, Void)
		end

	on_unselect is
			-- Is called when the item is unselected.
		do
			execute_command (Cmd_item_deactivate, Void)
		end

end -- class EV_RADIO_MENU_ITEM_IMP

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
--| Revision 1.11  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.2  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
