indexing
	description:
		"Eiffel Vision item list. Implementation interface."
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_I [G -> EV_ITEM]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

feature -- Access

	item_by_data (data: ANY): like item is
			-- First item with `data'.
		require
			data_not_void: data /= Void
		local
			c: CURSOR
			curr_data: like data
		do
			c := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				curr_data := interface.item.data
				if equal (curr_data, data) then
					Result := interface.item
				end
				interface.forth
			end
			go_to (c)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.1  2000/10/09 21:17:08  oconnor
--| Renamed ev_item_holder_i.e to ev_item_list_i.e
--|
--| Revision 1.4.4.2  2000/07/01 08:58:16  pichery
--| Fixed bugs
--|
--| Revision 1.4.4.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.7.4.1  2000/04/03 18:04:59  brendel
--| Revised with new EV_DYNAMIC_LIST.
--|
--| Revision 1.7  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/18 21:30:06  bonnard
--| Corrected `item_by_data' to deal with empty lists.
--|
--| Revision 1.5  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.10  2000/02/07 19:00:31  king
--| Converted to new ev_dynamic_list structure
--|
--| Revision 1.4.6.9  2000/02/04 04:04:54  oconnor
--| released
--|
--| Revision 1.4.6.8  2000/01/28 19:07:54  king
--| Converted to fit in with generic structure of ev_item_list
--|
--| Revision 1.4.6.7  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.6  2000/01/14 18:45:37  oconnor
--| commenting tweaks
--|
--| Revision 1.4.6.5  1999/12/01 19:01:26  oconnor
--| simplifed item_by_data and fixed type bug
--|
--| Revision 1.4.6.4  1999/12/01 18:57:22  oconnor
--| fixed over restrictive export status on interface
--|
--| Revision 1.4.6.3  1999/12/01 18:55:43  oconnor
--| moved in item_by_data from _IMP
--|
--| Revision 1.4.6.2  1999/11/30 22:50:08  oconnor
--| renamed from EV_ITEM_HOLDER_I to EV_ITEM_LIST_I, EV_ITEM_LIST inherits
--| DYNAMIC_LIST
--|
--| Revision 1.4.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:36  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
