indexing
	description: 
		"Multiple widget container. Each widget is displayed on an individual%
		%page. A tab is displayed for each page allow its selection. Only the%
		%selected page is visible."
	appearance:
		"  _______  _______  _______       %N%
		%_/ tab_1 \/_tab_2_\/_tab_3_\______%N%
		%|                                |%N%
		%|        `selected_item'         |%N%
		%|                                |%N%
		%----------------------------------"
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
			is_in_default_state
		end

	EV_NOTEBOOK_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

create
	default_create

feature -- Access 

	item_text (an_item: EV_WIDGET): STRING is
			-- Label of `an_item'.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.item_text (an_item)
		ensure
			bridge_ok: Result.is_equal (implementation.item_text (an_item))
			not_void: Result /= Void
		end

feature -- Status report

	selected_item: EV_WIDGET is
			-- Page displayed topmost.
		require
			not_destroyed: not is_destroyed
			item_is_selected: not is_empty
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item_index
		ensure
			bridge_ok: Result = implementation.selected_item_index
		end

	tab_position: INTEGER is
			-- Position of tabs.
			-- One of `Tab_left', `Tab_right', `Tab_top' or `Tab_bottom'.
			-- Default: `Tab_top'
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tab_position
		ensure
			bridge_ok: Result = implementation.tab_position
		end

feature -- Status setting
	
	position_tabs_top is
			-- Display tabs at top of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_top)
		ensure
			tab_position_set: tab_position = Tab_top
		end

	position_tabs_bottom is
			-- Display tabs at bottom of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_bottom)
		ensure
			tab_position_set: tab_position = Tab_bottom
		end

	position_tabs_left is
			-- Display tabs at left of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_left)
		ensure
			tab_position_set: tab_position = Tab_left
		end

	position_tabs_right is
			-- Display tabs at right of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_right)
		ensure
			tab_position_set: tab_position = Tab_right
		end

	set_tab_position (a_tab_position: INTEGER) is
			-- Display tabs at `a_tab_position'.
		require
			not_destroyed: not is_destroyed
			a_position_within_range:
				a_tab_position = Tab_left or a_tab_position = Tab_right or
				a_tab_position = Tab_bottom or a_tab_position = Tab_top
		do
			implementation.set_tab_position (a_tab_position)
		ensure
			tab_position_set: tab_position = a_tab_position
		end

	select_item (an_item: EV_WIDGET) is
			-- Display `an_item' above all others.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.select_item (an_item)
		ensure
			item_selected: selected_item = an_item
		end

feature -- Constants
	
	Tab_left: INTEGER is unique
			-- Value used to position tab at left.

	Tab_right: INTEGER is unique
			-- Value used to position tab at right.

	Tab_top: INTEGER is unique
			-- Value used to position tab at top.

	Tab_bottom: INTEGER is unique
			-- Value used to position tab at bottom.

feature -- Element change

	set_item_text (an_item: EV_WIDGET; a_text: STRING) is
			-- Assign `a_text' to label of `an_item'.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
			a_text_not_void: a_text /= Void
		do
			implementation.set_item_text (an_item, a_text)
		ensure
			item_text_assigned: item_text (an_item).is_equal (a_text)
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_WIDGET_LIST} and tab_position = Tab_top
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_NOTEBOOK_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_NOTEBOOK_IMP} implementation.make (Current)
		end

invariant
	tab_position_within_range: is_usable implies
		tab_position = Tab_left or tab_position = Tab_right or
		tab_position = Tab_bottom or tab_position = Tab_top
	selected_item_not_void: not is_empty implies selected_item /= Void
	selected_item_index_within_range:
		not is_empty implies
		(selected_item_index >= index_of (first, 1) and
		selected_item_index <= index_of (last, 1))
	selected_item_is_i_th_of_selected_item_index:
		not is_empty implies selected_item = i_th (selected_item_index)
	selected_item_index_is_index_of_selected_item:
		not is_empty implies selected_item_index = index_of (selected_item, 1)

end -- class EV_NOTEBOOK

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

