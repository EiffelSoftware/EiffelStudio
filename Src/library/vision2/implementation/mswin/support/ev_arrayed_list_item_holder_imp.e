indexing
	description:
		" A particular type of item-holder that uses an arrayed-list to store the%
		% children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARRAYED_LIST_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_IMP
	
feature -- Access

	get_item (index: INTEGER): EV_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
			Result ?= (ev_children @ index).interface
		end

feature -- Element change

	remove_all_items is
			-- Remove `ev_children' without destroying them.
		do
			from
				ev_children.finish
			until
				ev_children.count = 0
			loop
				ev_children.item.set_parent (Void)
				ev_children.back
			end
		end

feature -- Basic operations

	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		local
			list: ARRAYED_LIST [like item_type]
			litem: EV_ITEM
		do
			from
				list := ev_children
				list.start
			until
				list.after or Result /= Void
			loop
				litem ?= list.item.interface
				if litem.data.is_equal (data) then
					Result ?= litem
				end
				list.forth
			end
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [like item_type] is
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
