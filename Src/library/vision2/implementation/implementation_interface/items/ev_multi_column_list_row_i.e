indexing
	description:
		"Eiffel Vision multi column list row. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		require
			has_parent: parent /= Void
		deferred
		end

feature -- Status setting

	enable_select is
			-- Select Current.
			-- Must be in a multi column list.
		require
			has_parent: parent /= Void
		deferred
		ensure
			selected: is_selected
		end

	disable_select is
			-- Deselect Current.
			-- Must be in a multi column list.
		require
			has_parent: parent /= Void
		deferred
		ensure
			not_selected: not is_selected
		end
		
	toggle is
			-- Change the state of selection of the item.
			-- Must be in a multi column list.
		require
			has_parent: parent /= Void
		deferred
		end

feature -- Basic operations

	update is
			-- Layout of row has been changed.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_I

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
--| Revision 1.33  2000/03/23 18:17:35  brendel
--| Revised in compliance with new interface.
--|
--| Revision 1.32  2000/03/10 01:26:41  king
--| Removed inheritence from PND, moved up to COMPOSED_ITEM
--|
--| Revision 1.31  2000/03/09 01:18:30  king
--| Now inheriting from PND
--|
--| Revision 1.30  2000/03/03 00:03:26  rogers
--| Split set_selected into enable_select and disable_select.
--|
--| Revision 1.29  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.28  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.27  2000/02/16 20:28:08  king
--| Removed inheritence from pnd
--|
--| Revision 1.26  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.25.6.5  2000/02/02 23:46:03  king
--| Removed command association routines
--|
--| Revision 1.25.6.4  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.25.6.3  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.25.6.2  1999/12/17 19:06:48  rogers
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I replaces EV_PND_SOURCE and EV_PND_TARGET.
--|
--| Revision 1.25.6.1  1999/11/24 17:30:02  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.25.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.25.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
