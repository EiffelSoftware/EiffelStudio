indexing
	description:
		"Action sequences for EV_MENU_ITEM_LIST_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MENU_ITEM_LIST_ACTION_SEQUENCES_I


feature -- Event handling

	item_select_actions: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed when a menu item is selected.
		do
			if item_select_actions_internal = Void then
				item_select_actions_internal :=
					 create_item_select_actions
			end
			Result := item_select_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_item_select_actions: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE is
			-- Create a item_select action sequence.
		deferred
		end

	item_select_actions_internal: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE
			-- Implementation of once per object `item_select_actions'.

end

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

