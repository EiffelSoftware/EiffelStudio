indexing
	description: 
		"Eiffel Vision notebook. Multiple widget container. Each child is%N%
		%displayed on an individual page and may be selected via a tab.%N%
		%The selected page is displayed above all others."
	status: "See notice at end of class"
	keywrods: "notebook, tab, page"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK

inherit
	
	EV_WIDGET_LIST
		redefine
			implementation,
			create_action_sequences
		end

feature -- Access 

	item_text (an_item: like item): STRING is
			-- Label of `an_item'.
		require
			has_an_item: has (an_item)
		do
			Result := implementation.item_text (an_item)
		ensure
			bridge_ok: Result.is_equal (implementation.item_text (an_item))
			not_void: Result /= Void
		end

feature -- Status report

	selected_item: like item is
			-- Page displayed topmost.
		require
			item_is_selected: not empty
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
		do
			Result := implementation.selected_item_index
		ensure
			bridge_ok: Result = implementation.selected_item_index
		end

	tab_position: INTEGER is
			-- Position of tabs.
			-- One of `Tab_left', `Tab_right', `Tab_top' or `Tab_bottom'.
			-- Default: `Tab_top'
		do
			Result := implementation.tab_position
		end

feature -- Status setting
	
	position_tabs_top is
			-- Display tabs at top of notebook.
		do
			implementation.set_tab_position (Tab_top)
		ensure
			tab_position_set: tab_position = Tab_top
		end

	position_tabs_bottom is
			-- Display tabs at bottom of notebook.
		do
			implementation.set_tab_position (Tab_bottom)
		ensure
			tab_position_set: tab_position = Tab_bottom
		end

	position_tabs_left is
			-- Display tabs at left of notebook.
		do
			implementation.set_tab_position (Tab_left)
		ensure
			tab_position_set: tab_position = Tab_left
		end

	position_tabs_right is
			-- Display tabs at right of notebook.
		do
			implementation.set_tab_position (Tab_right)
		ensure
			tab_position_set: tab_position = Tab_right
		end

	set_tab_position (a_tab_position: INTEGER) is
			-- Display tabes at `a_tab_position'.
		require
			a_position_within_range:
				a_tab_position = Tab_left or a_tab_position = Tab_right or
				a_tab_position = Tab_bottom or a_tab_position = Tab_top
		do
			implementation.set_tab_position (a_tab_position)
		ensure
			tab_position_set: tab_position = a_tab_position
		end

	select_item (an_item: like item) is
			-- Display `an_item' above all others.
		require
			has_an_item: has (an_item)
		do
			implementation.select_item (an_item)
		ensure
			item_selected: selected_item = an_item
		end

feature -- Constants
	
	Tab_left: INTEGER is unique
			-- Value used to position tab on the left.

	Tab_right: INTEGER is unique
			-- Value used to position tab on the right.

	Tab_top: INTEGER is unique
			-- Value used to position tab at the top.

	Tab_bottom: INTEGER is unique
			-- Value used to position tab at the bottom.

feature -- Element change

	set_item_text (an_item: like item; a_text: STRING) is
			-- Assign `a_text' to the label for `an_item'.
		require
			has_an_item: has (an_item)
			a_text_not_void: a_text /= Void
		do
			implementation.set_item_text (an_item, a_text)
		ensure
			item_text_assigned: item_text (an_item).is_equal (a_text)
		end

feature -- Event handling

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when `selected_item' changes.

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_NOTEBOOK_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_action_sequences is
			-- Create action sequences for button.
		do
			{EV_WIDGET_LIST} Precursor
			create selection_actions
		end

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_NOTEBOOK_IMP} implementation.make (Current)
		end

invariant
	tab_position_within_range: is_useable implies
		tab_position = Tab_left or tab_position = Tab_right or
		tab_position = Tab_bottom or tab_position = Tab_top
	selected_item_not_void: not empty implies selected_item /= Void
	selected_item_index_within_range:
		not empty implies
		(selected_item_index >= index_of (first, 1) and
		selected_item_index <= index_of (last, 1))
	selected_item_is_i_th_of_selected_item_index:
		not empty implies selected_item = i_th (selected_item_index)
	selected_item_index_is_index_of_selected_item:
		not empty implies selected_item_index = index_of (selected_item, 1)
	selection_actions_not_void:
			selection_actions /= Void

end -- class EV_NOTEBOOK

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
--| Revision 1.15  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.12  2000/02/08 00:41:46  rogers
--| Changed the postcondition of item_text.
--|
--| Revision 1.13.6.11  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.13.6.10  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.9  2000/01/27 17:45:21  rogers
--| Added is_useable implies to the start of tab_position_within_range invariant.
--|
--| Revision 1.13.6.8  2000/01/19 08:03:47  oconnor
--| fixed off by one error in invariant
--|
--| Revision 1.13.6.7  2000/01/18 23:20:37  king
--| Altered invariant to check selected_item only when notebook is not empty
--|
--| Revision 1.13.6.6  2000/01/18 01:38:41  oconnor
--| Complete revision.
--| Commenting, formatting.
--| Renamed features to refer to item not page.
--| Now inherits widget list.
--| Removed side structures holding state info. Now go direct to source.
--|
--| Revision 1.13.6.5  2000/01/13 23:58:51  king
--| Corrected comment for switch action
--|
--| Revision 1.13.6.4  2000/01/13 22:30:12  king
--| Added switch action sequence, count, removed old switch association commands
--|
--| Revision 1.13.6.3  2000/01/13 01:18:49  king
--| Added standard cursor navigation features
--|
--| Revision 1.13.6.2  1999/12/17 20:00:49  rogers
--| redefined implementation to be a a more refined type.
--| Added deferred features from colelaction.
--|
--| Revision 1.13.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
