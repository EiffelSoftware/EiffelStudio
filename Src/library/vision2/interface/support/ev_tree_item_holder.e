indexing
	description:
		"Base class for EV_TREE and EV_TREE_ITEM."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_LIST

inherit
	EV_ITEM_LIST [EV_TREE_ITEM]
		redefine
			implementation
		end

feature -- Status report

	find_item_recursively_by_data (data: ANY): EV_TREE_ITEM is
			-- An item at any level in tree that has `data'.
		do
			Result := implementation.find_item_recursively_by_data (data)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TREE_ITEM_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_TREE_ITEM_LIST

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
--| Revision 1.14  2000/04/04 21:31:56  oconnor
--| comments
--|
--| Revision 1.13  2000/03/16 23:15:46  king
--| Renamed from holder to list
--|
--| Revision 1.12  2000/03/07 01:32:43  king
--| Reformatted text
--|
--| Revision 1.11  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.5  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.9.6.4  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.3  1999/12/17 20:55:11  rogers
--| item_type is no longer inherited and therefore is now defined in this class.
--|
--| Revision 1.9.6.2  1999/12/01 19:27:49  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER to EV_ITEM_LIST
--|
--| Revision 1.9.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
