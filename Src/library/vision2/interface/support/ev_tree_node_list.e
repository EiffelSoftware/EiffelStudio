indexing
	description:
		"Base class for EV_TREE and EV_TREE_ITEM."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_NODE_LIST

inherit
	EV_ITEM_LIST [EV_TREE_NODE]
		redefine
			implementation
		end
		
feature -- Access

	find_item_recursively_by_data (some_data: ANY): EV_TREE_NODE is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		do
			Result := implementation.find_item_recursively_by_data (some_data)
		ensure
			not_found_in_empty: Result /= Void implies not is_empty
			index_not_changed: old index = index
		end
		
	has_recursively (an_item: EV_TREE_NODE): BOOLEAN is
			-- Is `an_item' contained in `Current' at any level?
		require
			item_not_void: an_item /= Void
		do
			Result := implementation.has_recursively (an_item)
		ensure
			not_found_in_empty: Result implies not is_empty
			index_not_changed: old index = index
		end
		
feature -- Basic operation
		
	recursive_do_all (action: PROCEDURE [ANY, TUPLE [EV_TREE_NODE]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
		require
			action_not_void: action /= Void
		do
			implementation.recursive_do_all (action)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TREE_NODE_LIST_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_TREE_NODE_LIST

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

