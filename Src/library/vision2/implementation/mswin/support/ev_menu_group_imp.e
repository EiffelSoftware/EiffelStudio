indexing	
	description: 
		"EiffelVision menu group. An exclusive group for radio%
		% menu items."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_GROUP_IMP

inherit
	LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]

creation
	make

feature -- Status report

	uncheck_other_items (an_item: EV_RADIO_MENU_ITEM_IMP) is
			-- Uncheck all other items than `an_item'.
		require
			valid_item: has (an_item)
		do
			from
				start
			until
				after
			loop
				if item /= an_item then
					item.set_state (False)
				end
				forth
			end
		end

feature -- Element change

	remove_item (an_item: EV_RADIO_MENU_ITEM_IMP) is
			-- Find an item and remove it.
		require
			valid_item: has (an_item)
		do
			start
			prune (an_item)
		ensure
			item_removed: not has (an_item)
		end

	add_item (an_item: EV_RADIO_MENU_ITEM_IMP) is
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

end -- class EV_MENU_GROUP_IMP

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
