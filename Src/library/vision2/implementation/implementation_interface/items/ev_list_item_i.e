indexing
	description: "Eiffel Vision list item. Implementation interface."
	status: "See notice at end of class"
	keywords: "list, item"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_ITEM_I
	
inherit
	EV_SIMPLE_ITEM_I
		redefine
			interface,
			parent		
		end

feature -- Access

	parent: EV_ITEM_LIST [EV_LIST_ITEM] is
			-- List containing `interface'.
		local
			p: EV_ITEM_LIST [EV_LIST_ITEM]
		do
			p ?= {EV_SIMPLE_ITEM_I} Precursor
			if p /= Void then
				Result ?= p
				check
					parent_is_list: Result /= Void
				end
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		require
			has_parent: parent_imp /= Void
		deferred
		end

	is_first: BOOLEAN is
			-- Is `Current' first in list?
		require
			has_parent: parent_imp /= Void
		deferred
		end

	is_last: BOOLEAN is
			-- Is `Current' last in list?
		require
			has_parent: parent_imp /= Void
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			has_parent: parent_imp /= Void
		deferred
		ensure
			state_set: is_selected = flag
		end

	toggle is
			-- Change selection state.
		require
			has_parent: parent_imp /= Void
		deferred
		end

feature {EV_LIST_ITEM_I} -- Implementation

	interface: EV_LIST_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
	
end -- class EV_LIST_ITEM_I

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
