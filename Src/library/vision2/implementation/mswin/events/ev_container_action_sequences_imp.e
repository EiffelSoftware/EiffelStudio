indexing
	description:
		"Action sequences for EV_CONTAINER_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_CONTAINER_ACTION_SEQUENCES_IMP

inherit
	EV_CONTAINER_ACTION_SEQUENCES_I

feature -- Event handling

	create_new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Create a new_item action sequence.
		do
			create Result
		end

end
