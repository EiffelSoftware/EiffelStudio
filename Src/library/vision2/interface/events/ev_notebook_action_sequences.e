indexing
	description:
		"Action sequences for EV_NOTEBOOK."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_NOTEBOOK_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_NOTEBOOK_ACTION_SEQUENCES_I

feature -- Event handling


	selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `selected_item' changes.
		do
			Result := implementation.selection_actions
		ensure
			not_void: Result /= Void
		end

end
