indexing
	description:
		"EiffelVision tree-item container, Mswindows implementation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER_IMP

inherit
	EV_TREE_ITEM_HOLDER_I

	EV_HASH_TABLE_ITEM_HOLDER_IMP
	
feature -- element_change

	remove_all_items is
			-- Remove `children' without destroying them.
		local
			temp_children: ARRAYED_LIST [EV_ITEM_IMP]
			current_item:  EV_TREE_ITEM
		do
			from
				temp_children := children
				temp_children.finish
			until
				temp_children.before
			loop
				current_item ?= temp_children.item.interface
				current_item.set_parent (Void)
				temp_children.back
			end
		end


Feature -- Status report

	find_item_recursively_by_data (data: ANY): EV_TREE_ITEM is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		local
			list: ARRAYED_LIST [EV_ITEM_IMP]
			litem: EV_TREE_ITEM
		do
			from
				list := children
				list.start
			until
				list.after or Result/= Void
			loop
				litem ?= list.item.interface
				if equal (data, litem.data) then
					Result ?= litem
				else
					Result ?= litem.find_item_recursively_by_data (data)
				end
				list.forth
			end
		end


feature {NONE} -- Implementatin

	item_type: EV_TREE_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

end -- class EV_TREE_ITEM_HOLDER_IMP

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
