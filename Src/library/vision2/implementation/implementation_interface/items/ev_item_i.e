indexing	
	description: 
		"Eiffel Vision item. Implementation interface."
	status: "See notice at end of class"
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_I

inherit
	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_I

feature -- Access

	parent: EV_ITEM_LIST [EV_ITEM] is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
				check 
					parent_not_void: Result /= Void
				end
			end
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.16  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.15  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.4.3  2000/07/24 21:31:44  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.8.4.2  2000/05/18 00:29:04  king
--| Added check to parent
--|
--| Revision 1.8.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/04/07 22:10:00  brendel
--| EV_SIMPLE_ITEM_I -> EV_ITEM_I & EV_TEXTABLE_I.
--|
--| Revision 1.12  2000/04/07 20:47:35  brendel
--| Merged with EV_SIMPLE_ITEM_I. (except for EV_TEXTABLE_I).
--|
--| Revision 1.11  2000/02/22 23:04:44  rogers
--| Removed parent_set. This was marked as obsolete, but still required by Windows, so moved into the Windows ev_item_imp.
--|
--| Revision 1.10  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.9  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.9  2000/02/04 04:02:40  oconnor
--| released
--|
--| Revision 1.8.6.8  2000/02/03 23:30:59  brendel
--| Removed deferred and obsolete feature `index'.
--|
--| Revision 1.8.6.7  2000/02/02 00:47:42  king
--| Made parent_imp deferred so it can be defined as a function
--|
--| Revision 1.8.6.6  2000/01/28 18:54:18  king
--| Removed redundant features, changed to generic structure of ev_item_list
--|
--| Revision 1.8.6.5  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.4  2000/01/14 21:17:20  oconnor
--| commenting
--|
--| Revision 1.8.6.3  1999/12/17 19:14:12  rogers
--| Removed set_parent, set_parent_with_index and set_index.
--|
--| Revision 1.8.6.2  1999/11/30 22:51:01  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.8.6.1  1999/11/24 17:30:02  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
