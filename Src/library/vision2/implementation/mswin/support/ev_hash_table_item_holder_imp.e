--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" A particular type of item-holder that uses a hash-table to store the%
		% children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HASH_TABLE_ITEM_HOLDER_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_IMP [G]

feature -- Access

	ev_children: ARRAYED_LIST [EV_ITEM_IMP] is
			-- List of the direct children of the item holder.
			-- Should be define here, but is not because we cannot
			-- do the hastable deferred, it doesn't work, it should,
			-- but it doesn't.
		deferred
		end

	get_item (an_index: INTEGER): G is
			-- Give the item of the list at the zero-base
			-- `an_index'.
		do
		--| FIXME generize	Result ?= (ev_children @ an_index)
		end

feature -- Basic operations

	find_item_by_data (data: ANY): G is
			-- Find a child with data equal to `data'.
		--local
		--	list: ARRAYED_LIST [like item_type]
		--	litem: EV_ITEM
		do
		--	from
		--		list := children
		--		list.start
		--	until
		--		list.after or Result /= Void
		--	loop
		--		litem ?= list.item.interface
		--		if equal (data, litem.data) then
		--			Result ?= litem
		--		end
		--		list.forth
		--	end
		end

end -- class EV_HASH_TABLE_ITEM_HOLDER_IMP

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
--| Revision 1.3.6.6  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.3.6.5  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.4  2000/01/19 20:10:22  rogers
--| Removed item, as it is now inherited from EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.6.3  1999/12/17 17:13:34  rogers
--| Altered to fit in with the review branch. ev_children replaces children for consistency with other classes. Now inherits EV_ITEM_LIST_IMP.
--|
--| Revision 1.3.6.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. ev_item_holder_imp.e
--|
--| Revision 1.3.6.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
