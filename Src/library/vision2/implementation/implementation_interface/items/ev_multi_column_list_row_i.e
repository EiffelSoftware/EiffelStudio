--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision multi-column list row, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

inherit
	EV_COMPOSED_ITEM_I
		rename
			count as columns,
			set_count as set_columns
		redefine
			parent,
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end
	
feature -- Access

	parent: EV_ITEM_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_COMPOSED_ITEM_I} Precursor
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			has_parent: parent_imp /= Void
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			has_parent: parent_imp /= Void
		deferred
		ensure
			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			has_parent: parent_imp /= Void
		do
			set_selected (not is_selected)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
