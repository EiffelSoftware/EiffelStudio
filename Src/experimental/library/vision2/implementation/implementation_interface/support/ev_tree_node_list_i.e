note
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

	find_item_recursively_by_data (data: detachable ANY): detachable EV_TREE_NODE
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
			-- Use object comparison by default.
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			from
				attached_interface.start
			until
				attached_interface.after or Result /= Void
			loop
				actual_item := attached_interface.item
				if data ~ actual_item.data then
					Result := actual_item
				end
				attached_interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old attached_interface.index = attached_interface.index
		end

	retrieve_item_recursively_by_data (data: detachable ANY; should_compare_objects: BOOLEAN): detachable EV_TREE_NODE
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			from
				attached_interface.start
			until
				attached_interface.after or Result /= Void
			loop
				actual_item := attached_interface.item
				if
					(should_compare_objects and then data ~ actual_item.data) or else
					(not should_compare_objects and then data = actual_item.data)
				then
					Result := actual_item
				else
					Result := actual_item.implementation.retrieve_item_recursively_by_data (data, should_compare_objects)
				end
				attached_interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old attached_interface.index = attached_interface.index
		end

	retrieve_items_recursively_by_data (data: detachable ANY; should_compare_objects: BOOLEAN): ARRAYED_LIST [EV_TREE_NODE]
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
				attached_interface.start
			until
				attached_interface.after
			loop
				actual_item := attached_interface.item
				if
					(should_compare_objects and then data ~ actual_item.data) or else
					(not should_compare_objects and then data = actual_item.data)
				then
					Result.extend (actual_item)
				end
				Result.append (actual_item.implementation.retrieve_items_recursively_by_data (data, should_compare_objects))
				attached_interface.forth
			end
			go_to (temp_cursor)
		ensure
			Result_not_void: Result /= Void
		end

	has_recursively (an_item: like item): BOOLEAN
			-- Does `Current' contain `an_item' at any level?
		local
			temp_cursor: CURSOR
			actual_item: EV_TREE_NODE
		do
			temp_cursor := cursor
			from
				attached_interface.start
			until
				attached_interface.after or Result = True
			loop
				actual_item := attached_interface.item
				if an_item = actual_item then
					Result := True
				else
					Result := actual_item.implementation.has_recursively (an_item)
				end
				attached_interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old attached_interface.index = attached_interface.index
		end

	recursive_do_all (action: PROCEDURE [ANY, TUPLE [EV_TREE_NODE]])
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
		local
			l_item: like interface_item
		do
			from
				start
			until
				off
			loop
				l_item := interface_item
				check l_item /= Void end
				l_item.recursive_do_all (action)
				action.call ([l_item])
				forth
			end
		end

note
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










