indexing
	description:
		"Base class for widgets that contain EV_ITEMs"
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST [G -> EV_ITEM]

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end

	EV_DYNAMIC_LIST [G]
		redefine
			implementation
		end

feature -- Access

	item_by_data (data: ANY): like item is
			-- First item with `data'.
		require
			data_not_void: data /= Void
		do
			Result := implementation.item_by_data (data)
		ensure
			bridge_ok: Result = implementation.item_by_data (data)
		end

feature -- Contract support

	parent_of_items_is_current: BOOLEAN is
			-- Do all items have parent `Current'?
		local
			c: CURSOR
			item_par: EV_ITEM_LIST [G]
		do
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				item_par ?= item.parent
				if item_par /= Current then
					Result := False
				end
				forth
			end
			go_to (c)
		end

	items_unique: BOOLEAN is
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		local
			c: CURSOR
			l: LINKED_LIST [G]
		do
			create l.make
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				if l.has (item) then
					Result := False
				end
				l.extend (item)
				forth
			end
			go_to (c)
		end

	lists_equal (list1, list2: DYNAMIC_LIST [G]): BOOLEAN is
			-- Are elements in `list1' equal to those in `list2'.
		require
			list1_not_void: list1 /= Void
			list2_not_void: list2 /= Void
		local
			cur1, cur2: CURSOR
		do
			if list1 = list2 then
				Result := True
			else
				if list1.count = list2.count then
					from
						cur1 := list1.cursor
						cur2 := list2.cursor
						list1.start
						list2.start
						Result := True
					until
						list1.after or else Result = False
					loop
						Result := list1.item = list2.item
						list1.forth
						list2.forth
					end
					list1.go_to (cur1)
					list2.go_to (cur2)
				end
			end
		end

feature -- Implementation

	changeable_comparison_criterion: BOOLEAN is False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.

feature {EV_ANY_I} -- Implementation

	implementation: EV_ITEM_LIST_I [G]
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
--| FIXME	parent_of_items_is_current: is_useable implies parent_of_items_is_current
--| FIXME	items_unique: is_useable implies items_unique
	
end -- class EV_ITEM_LIST

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
--| Revision 1.16  2000/06/07 17:28:08  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.15.2.2  2000/05/13 00:04:17  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.15.2.1  2000/05/03 19:10:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/04/19 01:36:39  pichery
--| Modified `lists_equal' to take into account
--| ARRAYED_LIST.
--|
--| Revision 1.14  2000/04/11 17:32:55  brendel
--| Added `item_by_data'.
--|
--| Revision 1.13  2000/04/05 21:16:13  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.12.2.2  2000/04/04 23:00:08  brendel
--| Added is_parent_of.
--|
--| Revision 1.12.2.1  2000/04/03 18:11:52  brendel
--| Removed all feature now implemented by EV_DYNAMIC_LIST.
--| Added new contract support features.
--|
--| Revision 1.12  2000/03/29 22:15:34  king
--| Corrected lists_equal
--|
--| Revision 1.11  2000/03/29 21:44:51  brendel
--| Corrected implementation of `lists_equal'.
--|
--| Revision 1.10  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.9  2000/03/16 23:14:06  king
--| Removed inapplicable indexing post cond from put_front
--|
--| Revision 1.8  2000/03/15 00:58:44  king
--| Revised post-conditions for insertions
--|
--| Revision 1.7  2000/03/14 23:48:45  brendel
--| Added features `finish', `merge_left', `merge_right'.
--|
--| Revision 1.6  2000/03/08 21:44:13  king
--| Added parent set post-conditions
--|
--| Revision 1.5  2000/03/03 22:04:25  king
--| Implemented start to set index to 1
--|
--| Revision 1.4  2000/03/01 23:43:21  king
--| Added lists_equal linked_list comparison feature
--|
--| Revision 1.3  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.12  2000/02/09 23:05:44  rogers
--| Changed the item type from EV_ITEM to G. All features that previously took
--| 'like item' as an argument now take 'G'.
--|
--| Revision 1.1.2.11  2000/02/09 21:50:29  oconnor
--| changed like item to G in renamed features
--|
--| Revision 1.1.2.10  2000/02/09 20:56:04  oconnor
--| removed inheritcance of ev_dynamic_list
--|
--| Revision 1.1.2.9  2000/02/08 05:11:23  oconnor
--| formatting
--|
--| Revision 1.1.2.8  2000/02/08 01:44:51  king
--| Correctly implemented item_parent and its caller
--|
--| Revision 1.1.2.7  2000/02/07 20:18:56  king
--| Added remove_from_parent
--|
--| Revision 1.1.2.6  2000/02/07 19:07:44  king
--| Implemented to fit in with new ev_dynamic_list structure
--|
--| Revision 1.1.2.5  2000/02/02 23:52:23  king
--| Added code to remove item from its parent before inserting in to new
--| container
--|
--| Revision 1.1.2.4  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.1.2.3  2000/01/28 19:06:49  king
--| Made ev_item_list generically constrained to ev_item
--|
--| Revision 1.1.2.2  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.1  2000/01/24 23:19:44  oconnor
--| renamed ev_item_holder.e to ev_item_list.e
--|
--| Revision 1.6.6.7  2000/01/14 18:45:41  oconnor
--| commenting tweaks
--|
--| Revision 1.6.6.6  2000/01/14 18:42:08  oconnor
--| Added comments.
--| Added check flase to unused feature new_chain.
--|
--| Revision 1.6.6.5  1999/12/07 20:48:21  oconnor
--| inherit SET
--|
--| Revision 1.6.6.4  1999/12/02 00:07:17  oconnor
--| changed type of item to EV_ITEM from EV_LIST_ITEM
--|
--| Revision 1.6.6.3  1999/12/01 22:23:36  oconnor
--| moved item to EV_ITEM_LIST
--|
--| Revision 1.6.6.2  1999/11/30 22:40:24  oconnor
--| renamed from EV_ITEM_HOLDER to EV_ITEM_LIST, inherit DYNAMIC_LIST
--|
--| Revision 1.6.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
