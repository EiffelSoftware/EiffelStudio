--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" A particular type of item-holder that uses an arrayed-list to store the%
		% children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_IMP [G]
	
feature -- Access

	get_item (an_index: INTEGER): G is
			-- Give the item of the list at the zero-base
			-- `an_index'.
		local
			aa: ASSIGN_ATTEMPT [G]
		do
			create aa
			Result := aa.attempt (ev_children @ an_index)
		end

feature -- Element change

	remove_all_items is
			-- Remove `ev_children' without destroying them.
		do
			--from
			--	ev_children.finish
			--until
			--	ev_children.count = 0
			--loop
			--	ev_children.item.set_parent (Void)
			--	ev_children.back
			--end
		end

feature -- Basic operations

	find_item_by_data (data: ANY): G is
			-- Find a child with data equal to `data'.
		local
			list: ARRAYED_LIST [EV_ITEM_IMP]
			litem: EV_ITEM_IMP
			aa: ASSIGN_ATTEMPT [G]
		do
			from
				list := ev_children
				list.start
				create aa
			until
				list.after or Result /= Void
			loop
				litem ?= list.item
				if litem.interface.data.is_equal (data) then
					Result := aa.attempt (litem)
				end
				list.forth
			end
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_ITEM_IMP] is
			-- List used to store the items.
		deferred
		end

end -- class EV_ARRAYED_LIST_ITEM_HOLDER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.4  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.4.7  2000/02/01 20:36:08  king
--| Fixed arrayed list to use ASSIGN_ATTEMPT hack
--|
--| Revision 1.3.4.6  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.3.4.5  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.4.4  2000/01/19 20:08:37  rogers
--| Removed item, as it is now inherited from EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.4.3  1999/12/17 17:16:35  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.4.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. ev_item_holder_imp.e
--|
--| Revision 1.3.4.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
