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

