indexing
	description:
		"Eiffel Vision menu separator. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with `an_interface'.
		do
			base_make (an_interface)
			make_id
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Access

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radio items following this separator.

	create_radio_group is
			-- Create `radio_group'.
		require
			radio_group_void: radio_group = Void
		do
			create radio_group.make
		ensure
			radio_group_not_void: radio_group /= Void
		end

	set_radio_group (a_list: like radio_group) is
			-- Assign `a_list' to `radio_group'.
		require
			a_list_not_void: a_list /= Void
		do
			radio_group := a_list
		ensure
			assigned: radio_group = a_list
		end

	remove_radio_group is
			-- Set `radio_group' to `Void'.
		do
			radio_group := Void
		ensure
			void: radio_group = Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_SEPARATOR

end -- class EV_MENU_SEPARATOR_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.8.2  2000/08/11 19:18:08  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.1.8.1  2000/05/03 19:09:10  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/24 01:45:17  brendel
--| Added functions to modify radio_group.
--|
--| Revision 1.4  2000/02/23 02:15:49  brendel
--| Revised. Added feature `radio_group' and `create_radio_group', to save
--| the need for a list of radiogroups.
--|
--| Revision 1.3  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.6  2000/02/05 02:09:41  brendel
--| Works now.
--| Needs cleanup.
--|
--| Revision 1.1.10.5  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.1.10.4  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.1.10.3  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.2  1999/12/17 17:33:46  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.1.10.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
