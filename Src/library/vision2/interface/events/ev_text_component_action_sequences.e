indexing
	description:
		"Action sequences for EV_TEXT_COMPONENT."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_COMPONENT_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_COMPONENT_ACTION_SEQUENCES_I

feature -- Event handling


	change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `text' changes.
		do
			Result := implementation.change_actions
		ensure
			not_void: Result /= Void
		end

end
