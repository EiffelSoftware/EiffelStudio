indexing
	description: 
		"EiffelVision notebook. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_NOTEBOOK_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_NOTEBOOK_ACTION_SEQUENCES_I

feature {EV_NOTEBOOK} -- Access

	item_text (an_item: like item): STRING is
			-- Label of `an_item'.
		require
			interface_has_an_item: interface.has (an_item)
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	selected_item: like item is
			-- Page displayed topmost.
		deferred
		end

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
		deferred
		end

	tab_position: INTEGER is
			-- Position of tabs.
			-- One of `Tab_left', `Tab_right', `Tab_top' or `Tab_bottom'.
			-- Default: `Tab_top'
		deferred
		end

feature {EV_NOTEBOOK} -- Status setting
	
	set_tab_position (a_tab_position: INTEGER) is
			-- Display tabs at `a_tab_position'.
		require
			a_position_within_range:
				a_tab_position = interface.Tab_left or
				a_tab_position = interface.Tab_right or
				a_tab_position = interface.Tab_bottom or
				a_tab_position = interface.Tab_top
		deferred
		end

	select_item (an_item: like item) is
			-- Display `an_item' above all others.
		require
			interface_has_an_item: interface.has (an_item)
		deferred
		ensure
			item_selected: selected_item = an_item
		end
	
feature {EV_NOTEBOOK} -- Element change

	set_item_text (an_item: like item; a_text: STRING) is
			-- Assign `a_text' to the label for `an_item'.
		require
			interface_has_an_item: interface.has (an_item)
			a_text_not_void: a_text /= Void
		deferred
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_I} -- Implementation

	interface: EV_NOTEBOOK
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	tab_position_within_range: is_usable implies
		tab_position = interface.Tab_left or
		tab_position = interface.Tab_right or
		tab_position = interface.Tab_bottom or
		tab_position = interface.Tab_top
		selected_item_not_void: is_usable and count > 0 implies selected_item /= Void
		selected_item_index_within_range:
			is_usable and count > 0 implies (
			selected_item_index >= interface.index_of (interface.first, 1) and
			selected_item_index <= interface.index_of (interface.last, 1) )
		selected_item_is_i_th_of_selected_item_index:
			count > 0 implies
			selected_item = interface.i_th (selected_item_index)
		selected_item_index_is_index_of_selected_item:
			count > 0 implies
			selected_item_index = interface.index_of (selected_item, 1)

end -- class EV_NOTEBOOK_I

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
--| Revision 1.18  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.17  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.3  2001/02/16 00:12:49  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.13.4.2  2000/07/24 21:30:47  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.13.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.15  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.12  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.13.6.11  2000/02/03 17:08:45  rogers
--| Added is_useable to class invariants.
--|
--| Revision 1.13.6.10  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.9  2000/01/27 17:39:30  rogers
--| Added is_useable implies to the start of tab_position_within_range invariant.
--|
--| Revision 1.13.6.8  2000/01/19 08:04:06  oconnor
--| fixed off by one error in invariant
--|
--| Revision 1.13.6.7  2000/01/18 23:21:41  king
--| Altered invariant to check selected_item only when notebook is not empty
--|
--| Revision 1.13.6.6  2000/01/18 01:38:15  oconnor
--| Complete revision.
--| Commenting, formatting.
--| Renamed features to refer to item not page.
--| Now inherits widget list.
--|
--| Revision 1.13.6.5  2000/01/13 22:27:56  king
--| Added count procedure, removed switch association commands
--|
--| Revision 1.13.6.4  2000/01/13 01:17:01  king
--| Added extend, has, off, empty, put, prune, wipeout, forth
--|
--| Revision 1.13.6.3  1999/12/17 19:15:54  rogers
--| Added FIXME to precondition in set_page_title.
--|
--| Revision 1.13.6.2  1999/12/17 18:35:23  rogers
--| count now only needed in interface. changed index to an_index in arguments.
--|
--| Revision 1.13.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:41  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
