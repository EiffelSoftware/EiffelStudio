indexing
	description:
		"Action sequences for EV_MENU_ITEM_LIST."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MENU_ITEM_LIST_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_MENU_ITEM_LIST_ACTION_SEQUENCES_I

feature -- Event handling


	item_select_actions: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed when a menu item is selected.
		do
			Result := implementation.item_select_actions
		ensure
			not_void: Result /= Void
		end

end
