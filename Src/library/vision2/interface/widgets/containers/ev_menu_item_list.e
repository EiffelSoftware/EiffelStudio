indexing
	description: "Eiffel Vision menu item list."
	status: "See notice at end of class"
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
		do
			menu_item_list_parent ?= parent
			if menu_item_list_parent /= Void then
				Result := a_list = parent or else
					(parent /= Void and then menu_item_list_parent.is_parent_recursive (a_list))
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_LIST_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	item_select_actions_not_void: is_usable implies item_select_actions /= Void

end -- class EV_MENU_ITEM_LIST

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

