indexing	
	description: 
		"Eiffel Vision list item. For use in EV_LIST and EV_COMBO_BOX."
	status: "See notice at end of class"
	keywords: "list, item"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			create_action_sequences,
			implementation
		end

create
	default_create,
	make_with_text

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		require
			parent_not_void: parent /= Void
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end

	is_first: BOOLEAN is
			-- Is `Current' first in list?
		require
			parent_not_void: parent /= Void
		do
			Result := implementation.is_first
		ensure
			bridge_ok: Result = implementation.is_first
		end

	is_last: BOOLEAN is
			-- Is `Current' last in list?
		require
			parent_not_void: parent /= Void
		do
			Result := implementation.is_last
		ensure
			bridge_ok: Result = implementation.is_last
		end

feature -- Status setting

	enable_select is
			-- Select `Current' in list.
		require
			parent_not_void: parent /= Void
		do
			implementation.set_selected (True)
		ensure
			is_selected: is_selected
		end

	disable_select is
			-- Deselect `Current' in list.
		require
			parent_not_void: parent /= Void
		do
			implementation.set_selected (False)
		ensure
			not_selected: not is_selected
		end

	toggle is
			-- Change selection state.
		require
			has_parent: parent /= Void
		do
			implementation.toggle
		ensure
			state_changed: old is_selected = not is_selected
		end

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when item is selected.

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when item is deselected.

feature -- Implementation

	implementation: EV_LIST_ITEM_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of list item.
		do
			create {EV_LIST_ITEM_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create action sequences.
		do
			{EV_SIMPLE_ITEM} Precursor
			create select_actions
			create deselect_actions
		end

invariant
	select_actions_not_void: select_actions /= Void
	deselect_actions_not_void: deselect_actions /= Void

end -- class EV_LIST_ITEM

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.24  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.12  2000/01/28 20:00:08  oconnor
--| released
--|
--| Revision 1.23.6.11  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.10  2000/01/26 23:21:49  king
--| Moved make_with_text up to ev_simple_item
--|
--| Revision 1.23.6.9  2000/01/14 21:43:35  oconnor
--| removed parent from redefine clause
--|
--| Revision 1.23.6.8  2000/01/14 21:42:38  oconnor
--| removed parent feature
--|
--| Revision 1.23.6.7  2000/01/14 21:41:01  oconnor
--| removed unused local
--|
--| Revision 1.23.6.6  2000/01/14 21:40:30  oconnor
--| reimplemented parent to call implementation.parent
--|
--| Revision 1.23.6.5  2000/01/14 21:37:58  oconnor
--| commenting
--|
--| Revision 1.23.6.4  2000/01/14 21:36:26  oconnor
--| added and improved contracts, fixed formatting/comments
--|
--| Revision 1.23.6.3  2000/01/11 19:28:59  king
--| Removed useless command association routines
--|
--| Revision 1.23.6.2  1999/11/30 22:42:40  oconnor
--| added  create_implementation , removed make_with_index make_with_all
--|
--| Revision 1.23.6.1  1999/11/24 17:30:41  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
