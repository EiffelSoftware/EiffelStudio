indexing
	description:
		"Drop down menu containing EV_MENU_ITEMs"
	status: "See notice at end of class"
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			create_action_sequences,
			parent
		end
	
	EV_MENU_ITEM_LIST
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_MENU_ITEM} Precursor
			{EV_MENU_ITEM_LIST} Precursor
		end

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Menu item list containing `Current'.
			--| Redefined to avoid typing error.
		do
			Result := implementation.parent
		end

feature -- Standard operations

	show is
			-- Pop up on the current pointer position.
		do
			implementation.show
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
			implementation.show_at (a_widget, a_x, a_y)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_I	
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_MENU

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
--| Revision 1.26  2000/04/05 21:16:23  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.25.2.1  2000/04/03 18:14:13  brendel
--| Redefined parent.
--|
--| Revision 1.25  2000/03/22 21:34:12  brendel
--| Moved item_select_actions up to menu item list, because it also
--| applies to menu bars.
--|
--| Revision 1.24  2000/03/20 20:25:15  oconnor
--| added item_select_actions
--|
--| Revision 1.23  2000/03/17 19:28:54  brendel
--| Added interfaces for show and show_at.
--|
--| Revision 1.22  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.21  2000/02/29 18:09:11  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.20  2000/02/19 20:24:43  brendel
--| Updated copyright to 1986-2000.
--|
--| Revision 1.19  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.18.6.6  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.18.6.5  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.18.6.4  2000/02/02 00:06:46  oconnor
--| hacking menus
--|
--| Revision 1.18.6.3  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.18.6.2  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.18.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
