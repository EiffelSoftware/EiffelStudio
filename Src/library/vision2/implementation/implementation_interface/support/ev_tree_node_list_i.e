indexing
	description:
		"EiffelVision tree-item container. Implementation interface."
	status: "See notice at end of class"
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
		do
			from
				interface.start
				temp_cursor := cursor
			until
				interface.after or Result /= Void
			loop
				if equal (data, item.data) then
					Result := item
				else
					Result := item.find_item_recursively_by_data (data)
				end
				interface.forth
			end
			go_to (temp_cursor)
		ensure
			index_not_changed: old interface.index = interface.index
		end
		
	has_recursively (an_item: like item): BOOLEAN is
			-- Does `Current' contain `an_item' at any level?
		local
			temp_cursor: CURSOR
		do
			from
				interface.start
				temp_cursor := cursor
			until
				interface.after or Result = True
			loop
				if equal (an_item, item) then
					Result := True
				else
					Result := item.has_recursively (an_item)
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
		local
			t: TUPLE [EV_TREE_NODE]
		do
			create t.make
			from
				interface.start
			until
				interface.after
			loop
				item.recursive_do_all (action)
				t.put (item, 1)
				action.call (t)
				interface.forth
			end
		end


end -- class EV_TREE_ITEM_NODE_I

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

