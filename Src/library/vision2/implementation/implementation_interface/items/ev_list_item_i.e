indexing
	description: "Eiffel Vision list item. Implementation interface."
	status: "See notice at end of class"
	keywords: "list, item"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_ITEM_I
	
inherit
	EV_ITEM_I
		redefine
			interface,
			parent		
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_I

feature -- Status report

	is_selectable: BOOLEAN is
			-- May `Current' be selected?
		do
			Result := parent /= Void and then parent.is_sensitive
		end

feature -- Access

	parent: EV_LIST_ITEM_LIST is
			-- List containing `interface'.
		do
			if Precursor /= Void then
				Result ?= Precursor
				check
					parent_is_list: Result /= Void
				end
			end
		end

feature {EV_LIST_ITEM_I} -- Implementation

	interface: EV_LIST_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
	
end -- class EV_LIST_ITEM_I

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
--| Revision 1.36  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.35  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.34  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.26.4.7  2001/05/25 20:08:13  rogers
--| Tightened is_selectable, to ensure that a parent `is_sensitive' before
--| you can select an item.
--|
--| Revision 1.26.4.6  2001/05/14 16:53:41  rogers
--| Removed toggle.
--|
--| Revision 1.26.4.5  2000/07/24 21:31:44  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.26.4.4  2000/06/13 17:58:07  bonnard
--| `parent' is now an EV_LIST_ITEM_LIST.
--|
--| Revision 1.26.4.3  2000/05/10 23:43:43  king
--| Made tooltipable
--|
--| Revision 1.26.4.2  2000/05/09 22:37:30  king
--| Integrated selectable, is_selectable for list items
--|
--| Revision 1.26.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.32  2000/04/07 20:48:56  brendel
--| EV_SIMPLE_ITEM_I -> EV_ITEM_I & EV_TEXTABLE_I.
--|
--| Revision 1.31  2000/03/29 20:22:43  brendel
--| Modified in compliance with interface.
--|
--| Revision 1.30  2000/03/09 20:11:34  king
--| Removed inheritence from PND
--|
--| Revision 1.29  2000/03/09 17:48:49  king
--| Inheriting from PND
--|
--| Revision 1.28  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.27  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.26.6.7  2000/02/04 04:02:40  oconnor
--| released
--|
--| Revision 1.26.6.6  2000/01/28 18:54:18  king
--| Removed redundant features, changed to generic structure of ev_item_list
--|
--| Revision 1.26.6.5  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.26.6.4  2000/01/14 21:49:15  oconnor
--| fixed comments, check type of parent
--|
--| Revision 1.26.6.3  2000/01/11 19:27:18  king
--| Removed command association routines
--|
--| Revision 1.26.6.2  1999/11/30 22:51:01  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.26.6.1  1999/11/24 17:30:02  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.26.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.26.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
