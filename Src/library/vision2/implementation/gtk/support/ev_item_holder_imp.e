indexing
	description:
		"EiffelVision item holder, implementation."
	keywords: item
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_I


feature -- Access

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := ev_children.count
		end

	get_item (index: INTEGER): EV_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
			Result ?= (ev_children.i_th (index)).interface
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them and destroy them).
		deferred
		end

	remove_all_items is
			-- Remove all the items of the item holder.
			-- The items are not destroyed.
		local
			list: ARRAYED_LIST [EV_ITEM_IMP]
			litem: EV_ITEM
		do
			from
				list := ev_children
				list.finish
			until
				list.before
			loop
				litem ?= list.item.interface
				litem.set_parent (Void)
				list.back
			end
		end

feature -- Basic operations

	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		local
			list: ARRAYED_LIST [EV_ITEM_IMP]
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

feature {EV_ITEM_HOLDER_IMP, EV_ITEM_IMP} -- Implementation

	add_item (item_imp: EV_ITEM_IMP) is
			-- Add `item' to the list.
		deferred
		end

	remove_item (item_imp: EV_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		deferred
		end

feature {EV_ITEM_HOLDER_IMP} -- Implementation
 
 	ev_children: ARRAYED_LIST [EV_ITEM_IMP] is
 			-- List of the children
 		deferred
 		end
 
 	clear_ev_children is
 			-- Clear all the items of the list.
 		local
 			list: ARRAYED_LIST [EV_ITEM_IMP]
 		do
 			from
 				list := ev_children
 				list.start
 			until
 				list.after
 			loop
 				list.item.interface.remove_implementation
 				list.forth
 			end
 			list.wipe_out
 		end

end -- class EV_ITEM_HOLDER_IMP

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
