indexing
	description:
		"Action sequences for EV_STANDARD_DIALOG."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_STANDARD_DIALOG_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_STANDARD_DIALOG_ACTION_SEQUENCES_I

feature -- Event handling


	ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user clicks OK.
		do
			Result := implementation.ok_actions
		ensure
			not_void: Result /= Void
		end


	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user cancels.
		do
			Result := implementation.cancel_actions
		ensure
			not_void: Result /= Void
		end

end
