--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "This class is used by EV_ITEM_IMP. It gives%
				% the identifications of the different events%
				% that can occur. It is a class of constants"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- General events for items

	Cmd_item_activate: INTEGER is 1
			-- The item has been selected

	Cmd_item_deactivate: INTEGER is 2
			-- The item has been deselected

	Cmd_item_toggle: INTEGER is 3
			-- The item has been toggled.		

feature -- Event for list item

	Cmd_item_dblclk: INTEGER is 4
			-- The user dblclk on the item

feature -- Event for tree item

	Cmd_item_subtree: INTEGER is 11
			-- The user has expanded or collapsed a subtree
			-- item

feature -- Upper constants value

	command_count: INTEGER is 11
			-- Size of the list that contains the commands or the
			-- arguments.

end -- class EV_ITEM_EVENTS_CONSTANTS_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.2  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
