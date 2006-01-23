indexing
	description:
		"Base class for EV_TREE and EV_TREE_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."		
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
		obsolete "Use `retrieve_item_recursively_by_data' instead."
		do
			Result := implementation.find_item_recursively_by_data (some_data)
		ensure
			not_found_in_empty: Result /= Void implies not is_empty
			index_not_changed: old index = index
		end
		
	retrieve_item_recursively_by_data (some_data: ANY; should_compare_objects: BOOLEAN): EV_TREE_NODE is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		do
			Result := implementation.retrieve_item_recursively_by_data (some_data, should_compare_objects)
		ensure
			not_found_in_empty: Result /= Void implies not is_empty
			index_not_changed: old index = index
		end
		
	retrieve_items_recursively_by_data (some_data: ANY; should_compare_objects: BOOLEAN): ARRAYED_LIST [EV_TREE_NODE] is
			-- `Result' is all tree items contained in `Current' at any level
			-- with data matching `some_data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		do
			Result := implementation.retrieve_items_recursively_by_data (some_data, should_compare_objects)
		ensure
			Result_not_void: Result /= Void
			not_found_in_empty: not Result.is_empty implies not is_empty
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TREE_NODE_LIST_I;
			-- Responsible for interaction with native graphics toolkit.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TREE_NODE_LIST

