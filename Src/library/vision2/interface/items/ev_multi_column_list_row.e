--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision multi-column list row. These rows are used in %
		%the multi-column lists."
	status: "See notice at end of class"
	note: "It is not an item because it doesn't have the same options."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW

inherit

	EV_COMPOSED_ITEM
		rename
			count as columns,
			set_count as set_columns
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

feature -- Status setting


	enable_select is
			-- Select Current.
		require
			has_parent: parent /= Void
		do
			implementation.enable_select
		ensure
			selected: is_selected
		end

	disable_select is
			-- Deselect Current.
		require
			has_parent: parent /= Void
		do
			implementation.disable_select
		ensure
			not_selected: not is_selected
		end
		
	toggle is
			-- Change the state of selection of the item.
		require
			has_parent: parent /= Void
		do
			implementation.toggle
		end

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when item is selected.

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when item is deselected.

feature {NONE} -- Implementation

	create_implementation is 
			-- Create `implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_COMPOSED_ITEM} Precursor
			create select_actions
			create deselect_actions
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Platform dependent access.

end -- class EV_MULTI_COLUMN_LIST_ROW

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
--| Revision 1.30  2000/03/10 01:28:03  king
--| Removed inheritence from PND
--|
--| Revision 1.29  2000/03/09 01:19:27  king
--| Now inheriting from PND
--|
--| Revision 1.28  2000/03/03 00:01:19  rogers
--| Split set_selected into enable_select and disable_select.
--|
--| Revision 1.27  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.26  2000/02/29 19:20:22  oconnor
--| removed simicolons from indexing
--|
--| Revision 1.25  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.24  2000/02/19 01:20:38  king
--| Reinstated deselect_actions
--|
--| Revision 1.23  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.22  2000/02/18 18:43:49  king
--| Added deselect_actions with fixme as it is currently not connected
--|
--| Revision 1.21  2000/02/17 22:46:29  king
--| Removed command association commands
--|
--| Revision 1.20  2000/02/16 20:32:09  king
--| Removed inheritence from pnd
--|
--| Revision 1.19  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.18.6.5  2000/02/02 23:49:03  king
--| Obsolete command association routines
--|
--| Revision 1.18.6.4  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.18.6.3  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.18.6.2  1999/12/17 21:14:50  rogers
--| Now inherits EV_PICK_AND_DROPABLE instead of EV_PND_SOURCE and EV_PND_TARGET. Make and make_with_text ahve been removed. Thwy will need to be re-implemented. The addition and removal of commands have been commented, ready for re-implementation.
--|
--| Revision 1.18.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.3  1999/11/04 23:10:51  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
