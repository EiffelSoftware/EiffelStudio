indexing
	description:
		"[
			Drop down menu containing EV_MENU_ITEMs
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM
		undefine
			is_equal
		redefine
			implementation,
			create_implementation,
			is_in_default_state,
			parent
		end
	
	EV_MENU_ITEM_LIST
		undefine
			initialize
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Menu item list containing `Current'.
		do
			Result := implementation.parent
		end

feature -- Standard operations

	show is
			-- Pop up on the current pointer position.
		require
			not_destroyed: not is_destroyed
			not_parented: parent = Void
		do
			implementation.show
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		require
			not_destroyed: not is_destroyed
			not_parented: parent = Void
			widget_not_void: a_widget /= Void
			widget_not_destroyed: not a_widget.is_destroyed
			widget_displayed: a_widget.is_displayed
		do
			implementation.show_at (a_widget, a_x, a_y)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_MENU_ITEM} and Precursor {EV_MENU_ITEM_LIST}
		end
		
	one_selected_radio_item_per_separator: BOOLEAN is
			-- Is there at most one selected radio item between
			-- consecutive separators?
		do
			Result := implementation.one_radio_item_selected_per_separator
		ensure
			index_not_changed: index = old index
		end


feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_I	
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation
	
	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_IMP} implementation.make (Current)
		end
		
invariant
	one_selected_radio_item_per_separator: one_selected_radio_item_per_separator

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




end -- class EV_MENU

