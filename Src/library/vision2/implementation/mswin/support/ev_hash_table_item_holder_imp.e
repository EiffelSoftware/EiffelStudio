indexing
	description:
		" A particular type of item-holder that uses a hash-table to store the%
		% children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HASH_TABLE_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_IMP

feature -- Access

	children: ARRAYED_LIST [EV_ITEM_IMP] is
			-- List of the direct children of the item holder.
			-- Should be define here, but is not because we cannot
			-- do the hastable deferred, it doesn't work, it should,
			-- but it doesn't.
		deferred
		end

	get_item (index: INTEGER): EV_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
			Result ?= (children @ index).interface
		end

feature -- Basic operations

	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		local
			list: ARRAYED_LIST [like item_type]
			litem: EV_ITEM
		do
			from
				list := children
				list.start
			until
				list.after or Result /= Void
			loop
				litem ?= list.item.interface
				if equal (data, litem.data) then
					Result ?= litem
				end
				list.forth
			end
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
