indexing
	description:
		"Action sequences for EV_MENU_ITEM_LIST_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

inherit
	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_I


feature -- Event handling

	create_item_select_actions: EV_MENU_ITEM_SELECT_ACTION_SEQUENCE is
			-- Create a item_select action sequence.
		do
			create Result
		end

end
