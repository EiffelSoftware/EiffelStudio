note
	description: "Eiffel Vision menu item list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST

inherit
	EV_ITEM_LIST [EV_MENU_ITEM]
		redefine
			implementation
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES

feature -- Contract support

	is_parent_recursive (a_list: like item): BOOLEAN
			-- Is `Current' present in `a_list' hierarchy?
		do
			if attached {EV_MENU_ITEM_LIST} parent as menu_item_list_parent then
				Result := parent ~ a_list or else menu_item_list_parent.is_parent_recursive (a_list)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_LIST_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	item_select_actions_not_void: is_usable implies item_select_actions /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_ITEM_LIST











