indexing
	description:
		"EiffelVision tree-item container. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_NODE_LIST_I

inherit
	EV_ITEM_LIST_I [EV_TREE_NODE]

Feature -- Status report

	find_item_recursively_by_data (data: ANY): EV_TREE_NODE is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				actual_item := interface.item
				if (data = Void and then actual_item.data = Void) or
					data /= void and actual_item.data /= Void and then data.same_type (actual_item.data) and then
					data.is_equal (actual_item.data) then
					Result := actual_item
				end
				interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old interface.index = interface.index
		end
		
	retrieve_item_recursively_by_data (data: ANY; should_compare_objects: BOOLEAN): EV_TREE_NODE is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				actual_item := interface.item
				if (should_compare_objects and then ((data = Void and then actual_item.data = Void) or data /= void and actual_item.data /= Void and then data.same_type (actual_item.data) and then data.is_equal (actual_item.data)))
				or (not should_compare_objects and data = actual_item.data) then
					Result := actual_item
				else
					Result := actual_item.implementation.retrieve_item_recursively_by_data (data, should_compare_objects)
				end
				interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old interface.index = interface.index
		end
		
	retrieve_items_recursively_by_data (data: ANY; should_compare_objects: BOOLEAN): ARRAYED_LIST [EV_TREE_NODE] is
			-- `Result' is all tree items contained in `Current' at any level,
			-- with data matching `data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			create Result.make (0)
			from
				interface.start
			until
				interface.after
			loop
				actual_item := interface.item
				if (should_compare_objects and then ((data = Void and then actual_item.data = Void) or data /= void and actual_item.data /= Void and then data.same_type (actual_item.data) and then data.is_equal (actual_item.data)))
				or (not should_compare_objects and data = actual_item.data) then
					Result.extend (actual_item)
				end
				Result.append (actual_item.implementation.retrieve_items_recursively_by_data (data, should_compare_objects))
				interface.forth
			end
			go_to (temp_cursor)
		ensure
			Result_not_void: Result /= Void
		end
		
	
	has_recursively (an_item: like item): BOOLEAN is
			-- Does `Current' contain `an_item' at any level?
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor			
			from
				interface.start
			until
				interface.after or Result = True
			loop
				actual_item := interface.item
				if equal (an_item, actual_item) then
					Result := True
				else
					Result := actual_item.implementation.has_recursively (an_item)
				end
				interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old interface.index = interface.index
		end
		
	recursive_do_all (action: PROCEDURE [ANY, TUPLE [EV_TREE_NODE]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
		do
			from
				start
			until
				off
			loop
				item.recursive_do_all (action)
				action.call ([item])
				forth
			end
		end


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




end -- class EV_TREE_ITEM_NODE_I

