indexing
	description:
		"EiffelVision tree-item container. Common ancestor for%
		% EV_TREE and EV_TREE_ITEM."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER

inherit
	EV_ANY
		redefine
			implementation
		end

feature {EV_TREE_ITEM, EV_TREE_ITEM_I} -- Implementation

	implementation: EV_TREE_ITEM_HOLDER_I

feature -- Access

	count: INTEGER is
			-- Number of items
		require
			exists: not destroyed
		do
			Result := implementation.count
		end

	get_item (index: INTEGER): EV_TREE_ITEM is
			-- Give the item of the tree (or tree item) at
			-- `index'.
		require
			exists: not destroyed
			item_exists: (index <= count) and (index >= 0)
		do
			Result := implementation.get_item(index)
		end

end -- class EV_TREE_ITEM_HOLDER

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
