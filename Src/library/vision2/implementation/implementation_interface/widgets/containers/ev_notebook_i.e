indexing
	description: 
		"EiffelVision notebook. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_NOTEBOOK_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end
	
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_NOTEBOOK_ACTION_SEQUENCES_I
	
	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end

feature {EV_NOTEBOOK} -- Access

	item_text (an_item: like item): STRING is
			-- Label of `an_item'.
		require
			interface_has_an_item: interface.has (an_item)
		deferred
		ensure
			not_void: Result /= Void
		end
		
	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB is
			-- Tab associated with `an_item'.
		require
			has_an_item: has (an_item)
		deferred
		ensure
			result_not_void: Result /= Void
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
		
	pointed_tab_index: INTEGER is
			-- index of tab currently under mouse pointer, or 0 if none.
		deferred
		ensure
			result_valid: Result >= 0 and Result <= count
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_NOTEBOOK_I

