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

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Container of `Current'.
		deferred
		end
		
feature -- Contract support

	is_parent_recursive (a_list: EV_MENU_ITEM_LIST): BOOLEAN is
			-- Is `Current' present in `a_list' hierarchy?
		do
			Result := a_list = parent or else
				(parent /= Void and then parent.is_parent_recursive (a_list))
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_LIST_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	item_select_actions_not_void: is_usable implies item_select_actions /= Void

end -- class EV_MENU_ITEM_LIST

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

