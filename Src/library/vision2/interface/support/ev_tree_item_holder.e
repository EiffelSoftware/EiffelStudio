--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree-item container. Common ancestor for%
		% EV_TREE and EV_TREE_ITEM."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_HOLDER

inherit
	EV_ITEM_LIST [EV_TREE_ITEM]
		redefine
			implementation
		end

feature -- Implementation

	implementation: EV_TREE_ITEM_HOLDER_I
			-- Platform dependent access.

feature -- Status report

	find_item_recursively_by_data (data: ANY): EV_TREE_ITEM is
			-- If `data' contained in a tree item at any level then
			-- assign this item to `Result'.
		require
		do
			Result := implementation.find_item_recursively_by_data (data)
		end

feature {NONE} -- Implementation

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
