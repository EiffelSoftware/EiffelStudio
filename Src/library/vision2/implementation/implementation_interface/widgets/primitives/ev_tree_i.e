--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision Tree. Implemenation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_ITEM_LIST_I [EV_TREE_ITEM]
		redefine
			interface
		end

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Tree item which is currently selected
			-- It needs to be in single selection mode
		deferred
		end

	selected_items: LINKED_LIST [EV_TREE_ITEM] is
			-- List of all the selected tree items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
		deferred
		end

feature -- Status setting

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
		deferred
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
		deferred
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one tree item selected ?
		require
		deferred
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
		deferred
		end


feature {EV_ANY_I}

	interface: EV_TREE

end -- class EV_TREE_I

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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2000/02/29 00:02:53  king
--| Added multiple select features
--|
--| Revision 1.17  2000/02/22 23:57:58  king
--| Added selected_item
--|
--| Revision 1.16  2000/02/22 21:39:50  king
--| Removed redundant command association features, inheriting from item_list
--|
--| Revision 1.15  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.3  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.2  1999/12/17 17:47:15  rogers
--| Redefined interface to be of more refined type.
--|
--| Revision 1.13.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
