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
			interface,
			parent_imp
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_I

feature -- Status report

	is_selectable: BOOLEAN is
			-- May the tree item be selected.
		do
			Result := parent /= Void
		end

feature -- Element Change

	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			pixmap := clone (a_pix)
			update
		end

	pixmap: EV_PIXMAP
			-- Pixmap used at the start of the row.

	remove_pixmap is
			-- Remove the rows pixmap.
		do
			pixmap := Void
			update
		end

feature -- Basic operations

	update is
			-- Layout of row has been changed.
		local
			app: EV_APPLICATION_I
		do
			if parent_imp /= Void then
				update_needed := True
				app := (create {EV_ENVIRONMENT}).application.implementation
				if interface.count > parent_imp.count then
					parent_imp.update_children_agent.call ([])
					app.once_idle_actions.prune (parent_imp.update_children_agent)
				elseif not app.once_idle_actions.has (
						parent_imp.update_children_agent) then
					app.do_once_on_idle (
						parent_imp.update_children_agent)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	parent_imp: EV_MULTI_COLUMN_LIST_IMP is
		deferred
		end

	dirty_child is
			-- Mark `Current' as dirty.
		do
			update_needed := True
		end

	update_needed: BOOLEAN
			-- Is the child dirty.

	update_performed is
			-- Mark `Current' as up to date.
		do
			update_needed := False
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
--| Revision 1.40  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.25.4.12  2001/06/05 21:55:33  rogers
--| Set_pixmap now uses clone internally instead of copy. Saves creation line.
--|
--| Revision 1.25.4.11  2001/06/05 18:55:28  rogers
--| we now create pixmap before calling `copy' on it.
--|
--| Revision 1.25.4.10  2001/06/04 19:38:03  rogers
--| Replaced use of ev_clone with copy.
--|
--| Revision 1.25.4.9  2000/12/01 18:27:33  king
--| Reimplemented update to immediately update list if row size is bigger than list count
--|
--| Revision 1.25.4.8  2000/08/09 20:57:10  oconnor
--| use ev_clone instead of clone as per instructions of manus
--|
--| Revision 1.25.4.7  2000/08/08 20:41:10  rogers
--| Replaced use of ev_clone with clone.
--|
--| Revision 1.25.4.6  2000/07/24 21:31:44  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.25.4.5  2000/07/05 23:59:27  king
--| Added period/full stop to comment
--|
--| Revision 1.25.4.4  2000/05/09 23:22:41  king
--| Redefined is_selectable
--|
--| Revision 1.25.4.3  2000/05/09 23:12:26  king
--| Made mcl inheirt from deselectable
--|
--| Revision 1.25.4.2  2000/05/05 22:28:38  pichery
--| Replaced (Create + Copy) with `ev_clone'
--|
--| Revision 1.25.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.38  2000/03/29 01:42:33  king
--| Redefined pixmapping functions to call update
--|
--| Revision 1.37  2000/03/28 00:33:12  king
--| Added dirty_child feature
--|
--| Revision 1.36  2000/03/25 01:45:14  brendel
--| Replaced once_on_idle_actions.extend with do_once_on_idle.
--|
--| Revision 1.35  2000/03/24 17:29:34  brendel
--| Moved platform independent update code here.
--|
--| Revision 1.34  2000/03/23 19:20:05  king
--| Made toggle platform independent
--|
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
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I
--|  replaces EV_PND_SOURCE and EV_PND_TARGET.
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
