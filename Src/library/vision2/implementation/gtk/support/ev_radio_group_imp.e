indexing
	description: 
		"EiffelVision radio group. An exclusive group for radio items or buttons."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_GROUP

inherit
	LINKED_LIST [EV_RADIO [EV_ITEM]]

creation
	make

feature -- Status report

	selected_item: EV_RADIO [EV_ITEM]
			-- Currently selected item


feature -- Element change

	remove_item (an_item: EV_RADIO [EV_ITEM]) is
			-- Find an item and remove it.
		require
			valid_item: has (an_item)
		do
			start
			prune (an_item)
		ensure
			item_removed: not has (an_item)
		end

	add_item (an_item: EV_RADIO [EV_ITEM]) is
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

	last_selected: EV_RADIO [EV_ITEM]

	set_last_selected (an_item: EV_RADIO [EV_ITEM]) is
		do
			last_selected := an_item
		end

	just_selected (an_item: EV_RADIO [EV_ITEM]): BOOLEAN is
		do
			Result := equal (last_selected, an_item)
		end

	set_selection_at (an_item: EV_RADIO [EV_ITEM]) is
			-- Check the given item and uncheck the currently
			-- selected one.
		require
			valid_item: has (an_item)
		do
			if selected_item /= Void and then selected_item /= an_item then
				selected_item.on_unselect(an_item)
			end
			selected_item := an_item
		end

	set_selection_at_no_event (an_item: EV_RADIO [EV_ITEM]) is
			-- Select an_item and unselect the currently
			-- selected one.
		require
			valid_item: has (an_item)
		do
			if selected_item /= Void then
					selected_item.on_unselect(an_item)
			end
			selected_item := an_item
		end

end -- class EV_RADIO_GROUP

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
