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
		

end -- class EV_TREE_ITEM_NDOE_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/06/25 16:55:31  rogers
--| Added `has_recursively'.
--|
--| Revision 1.2  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.1  2000/10/09 21:23:20  oconnor
--| Renamed ev_tree_item_holder_i.e to ev_tree_node_list_i.e
--|
--| Revision 1.10.4.3  2000/08/17 22:20:01  rogers
--| Removed fixme not_reviewed. Comments. Added postcondition to
--| find_item_Recursively_by_data.
--|
--| Revision 1.10.4.2  2000/05/16 16:59:07  oconnor
--| updated for EV_TREE_NODE
--|
--| Revision 1.10.4.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/03/16 23:13:06  king
--| Renamed class from holder to list
--|
--| Revision 1.14  2000/03/07 01:31:13  king
--| Implemented find_recursive feature
--|
--| Revision 1.13  2000/03/07 00:28:36  rogers
--| Removed --FIXME Not for release.
--|
--| Revision 1.12  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.6  2000/02/04 07:58:28  oconnor
--| ureleased
--|
--| Revision 1.10.6.5  2000/02/04 04:04:54  oconnor
--| released
--|
--| Revision 1.10.6.4  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.10.6.3  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.2  1999/12/01 19:27:24  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER_I to EV_ITEM_LIST_I
--|
--| Revision 1.10.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:36  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
