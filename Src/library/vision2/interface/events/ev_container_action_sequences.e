indexing
	description:
		"Action sequences for EV_CONTAINER."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_CONTAINER_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_CONTAINER_ACTION_SEQUENCES_I

feature -- Event handling


	new_item_actions: EV_NEW_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when a new item is added.
		do
			Result := implementation.new_item_actions
		ensure
			not_void: Result /= Void
		end

end
