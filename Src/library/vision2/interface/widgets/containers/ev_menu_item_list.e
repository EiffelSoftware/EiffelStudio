--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision menu item list"
	status: "See notice at end of class"
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST

inherit
	EV_ITEM_LIST [EV_MENU_ITEM]
		redefine
			create_action_sequences
		end

feature {NONE} -- Initialization

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_ITEM_LIST} Precursor
			create item_select_actions
		end

feature -- Contract support

	is_parent_recursive (a_list: EV_MENU_ITEM_LIST): BOOLEAN is
			-- Is `a_widget' `parent' or recursively `parent' of `parent'.
		do
			Result := a_list = parent or else
				(parent /= Void and then parent.is_parent_recursive (a_list))
		end

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Container of `Current'.
		deferred
		end

feature -- Event handling

	item_select_actions: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE
			-- Actions to be performed when a menu item is selected.

invariant
	item_select_actions_not_void: is_useable implies item_select_actions /= Void

end -- class EV_MENU_ITEM_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/04/05 21:16:14  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.6.2.1  2000/04/03 18:12:38  brendel
--| Added is_parent_recursive and parent.
--|
--| Revision 1.6  2000/03/22 21:34:12  brendel
--| Moved item_select_actions up to menu item list, because it also
--| applies to menu bars.
--|
--| Revision 1.5  2000/03/17 23:50:41  oconnor
--| formatting
--|
--| Revision 1.4  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.3  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.1  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
