indexing
	description:
		"Action sequences for EV_TEXT_FIELD."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_FIELD_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_FIELD_ACTION_SEQUENCES_I

feature -- Event handling


	return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when return key is pressed.
		do
			Result := implementation.return_actions
		ensure
			not_void: Result /= Void
		end

end
