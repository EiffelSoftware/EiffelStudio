indexing
	description:
		"EiffelVision tree-item container. Common ancestor for%
		% EV_TREE and EV_TREE_ITEM."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER

inherit
	EV_ITEM_HOLDER
		redefine
			implementation,
			item_type
		end

feature -- Implementation

	implementation: EV_TREE_ITEM_HOLDER_I
			-- Platform dependent access.

feature -- Status report

	find_item_recursively_by_data (data: ANY): EV_TREE_ITEM is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		require
			exists: not destroyed
		do
			Result := implementation.find_item_recursively_by_data (data)
		end

feature {NONE} -- Implementation

	item_type: EV_TREE_ITEM is
			-- Current item is a tree item.
		do
		end

end -- class EV_TREE_ITEM_HOLDER

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
