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

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected in `parent'?
		require
			parent_not_void: parent /= Void
		deferred
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		require
			parent_not_void: parent /= Void
		deferred
		ensure
			is_selected: is_selected
		end

	disable_select is
			-- Set `is_selected' `False'.
		require
			parent_not_void: parent /= Void
		deferred
		ensure
			not_selected: not is_selected
		end

	toggle is
			-- Change `is_selected'.
		require
			parent_not_void: parent /= Void
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		ensure
			state_changed: old is_selected = not is_selected
		end

feature -- Access

	parent: EV_LIST is
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
