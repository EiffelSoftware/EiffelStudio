indexing
	description:
		"Action sequences for EV_GAUGE."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_GAUGE_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_GAUGE_ACTION_SEQUENCES_I

feature -- Event handling


	change_actions: EV_VALUE_CHANGE_ACTION_SEQUENCE is
			-- Actions to be performed when `value' changes.
		do
			Result := implementation.change_actions
		ensure
			not_void: Result /= Void
		end

end
