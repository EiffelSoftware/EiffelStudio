indexing
	description:
		"Action sequences for EV_BUTTON."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_BUTTON_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when button is pressed then released.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end

end
