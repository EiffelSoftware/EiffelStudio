--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_I
	
inherit
	EV_PRIMITIVE_I
		rename
			interface as primitive_interface
		redefine
			set_default_colors
		end

	EV_ITEM_LIST_I [EV_LIST_ITEM]
		select
			interface
		end

feature {EV_WIDGET} -- Initialization

	set_default_colors is
			-- Common initializations for Gtk and Windows.
		local
			color: EV_COLOR
		do
			create color.make_with_rgb (1, 1, 1)
			set_background_color (color)
			create color.make_with_rgb (0, 0, 0)
			set_foreground_color (color)
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected
			-- It needs to be in single selection mode
		deferred
		end

	selected_items: LINKED_LIST [EV_LIST_ITEM] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
		local
			litem: EV_LIST_ITEM
			list: ARRAYED_LIST [EV_LIST_ITEM]
		do
			--|FIXME re-implement this feature
			create Result.make
			--if multiple_selection_enabled then
			--	from
			--		list := ev_children
			--		list.start
			--	until
			--		list.after
			--	loop
			--		if list.item.is_selected then
			--			litem ?= (list.item.interface)
			--			if litem /= Void then 
			--				Result.extend (litem)
			--			end
			--		end
			--		list.forth
			--	end
			--else
			--	Result.extend (selected_item)
			--end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
		deferred
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
		deferred
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `an_index' of the list.
		require
			index_large_enough: an_index > 0
			index_small_enough: an_index <= count
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `an_index'.
		require
			index_large_enough: an_index > 0
			index_small_enough: an_index <= count
		deferred
		end

	clear_selection is
			-- Clear the selection of the list.
		require
		deferred
		end

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

feature {EV_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children
end -- class EV_LIST_I

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
--| Revision 1.35  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.34.6.13  2000/02/10 17:19:40  king
--| Removed redundant command association commands
--|
--| Revision 1.34.6.12  2000/02/04 07:40:46  oconnor
--| removed old command features
--|
--| Revision 1.34.6.11  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.34.6.10  2000/02/01 20:11:16  king
--| Altered inheritence from item_list to deal with new generic item structure
--|
--| Revision 1.34.6.9  2000/01/28 19:08:36  king
--| Converted to fit in with generic structure of ev_item_list
--|
--| Revision 1.34.6.8  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.34.6.7  2000/01/18 17:24:08  rogers
--| Changed is_multiple_Selection to multiple_selection_enabled.
--|
--| Revision 1.34.6.6  2000/01/18 01:14:59  king
--| Instantiated selected_items to satisfy invariant, needs implementing
--|
--| Revision 1.34.6.5  2000/01/15 00:53:44  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
--|
--| Revision 1.34.6.4  1999/12/17 18:09:46  rogers
--| Redefined interface to be of more refined type. Item now comes from EV_ITEM_LIST_I. Commented out selected_items pending re-implementation.
--|
--| Revision 1.34.6.3  1999/12/03 07:47:01  oconnor
--| make_rgb (int) -> make_with_rgb (real)
--|
--| Revision 1.34.6.2  1999/11/30 22:46:56  oconnor
--| 8 bit to REAL color fix, redefine interface to more refined type
--|
--| Revision 1.34.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.34.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.34.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
