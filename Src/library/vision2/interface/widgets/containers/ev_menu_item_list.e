indexing
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
		undefine
			is_equal
		redefine
			implementation
		end

feature -- Contract support

	is_parent_recursive (a_list: like item): BOOLEAN is
			-- Is `Current' present in `a_list' hierarchy?
		local
			menu_item_list_parent: EV_MENU_ITEM_LIST
			l_list: EV_ANY
		do
			menu_item_list_parent ?= parent
			if menu_item_list_parent /= Void then
				l_list := a_list
				Result := l_list = parent or else
					(parent /= Void and then menu_item_list_parent.is_parent_recursive (a_list))
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_LIST_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	item_select_actions_not_void: is_usable implies item_select_actions /= Void

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




end -- class EV_MENU_ITEM_LIST

