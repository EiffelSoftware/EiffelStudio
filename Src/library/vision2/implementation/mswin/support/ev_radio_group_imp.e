--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision radio group. An exclusive group for radio items or buttons."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_GROUP_IMP

inherit
	LINKED_LIST [EV_RADIO_IMP [EV_ANY]]

creation
	make

feature -- Status report

	selected_item: EV_RADIO_IMP [EV_ANY]
			-- Currently selected item.

feature -- Element change

	remove_item (an_item: EV_RADIO_IMP [EV_ANY]) is
			-- Find an item and remove it.
		require
			valid_item: has (an_item)
		do
			start
			prune (an_item)
		ensure
			item_removed: not has (an_item)
		end

	add_item (an_item: EV_RADIO_IMP [EV_ANY]) is
			-- Check if the item is not already in the list,
			-- is not it is added to the list.
		require
			valid_item: an_item /= Void
		do
			if not has (an_item) then
				extend (an_item)
			end
		ensure
			item_added: has (an_item)
		end

feature -- Basic operations

	set_selection_at (an_item: EV_RADIO_IMP [EV_ANY]) is
			-- Check the given item and uncheck the currently
			-- selected one.
		require
			valid_item: has (an_item)
		do
			if selected_item /= Void and then selected_item /= an_item then
				selected_item.set_selected (False)
				selected_item.on_unselect
			end
			selected_item := an_item
		end

	set_selection_at_no_event (an_item: EV_RADIO_IMP [EV_ANY]) is
			-- Check the given item and uncheck the currently
			-- selected one.
		require
			valid_item: has (an_item)
		do
			if selected_item /= Void and then selected_item /= an_item then
				selected_item.set_selected (False)
			end
			selected_item := an_item
		end

end -- class EV_TOOL_BAR_GROUP_IMP

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
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
